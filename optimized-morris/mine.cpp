// Bitcoin miner HLS kernel (v2 optimisation working file).
//
// Started from the plain baseline and optimised step by step (see the log
// below). It gives the same answers as the software baseline in src/baseline/
// and targets 200 MHz on the KV260. The top function mine() sweeps a nonce
// range and reports the first nonce whose double hash is below the target.
//
// SHA-256 constants and the compression steps are from FIPS 180-4, the same
// source the baseline cites. sha256d_80 hashes a fixed 80-byte header twice.
//
// ---------------------------------------------------------------------------
// OPTIMISATION LOG
//   STEP 1: array_partition on hdr  -> II 231 -> 198, but LUT 58% -> 156%.
//           Lesson: the 3 SHA compressions are the real cost, not hdr ports.
//   STEP 2: MIDSTATE. Header bytes 0..63 never change with the nonce, so
//           Compression 1 runs once before the loop. 2 compressions per nonce
//           instead of 3. -> II 137, LUT 99%, fits. See the "STEP 2" tags.
//   STEP 3: pipeline II=1 on the nonce loop -> did not fit / did not finish.
//           Forcing II=1 tries to unroll everything. (We thought II 137 was the
//           floor, but STEP 3.3 later broke it the right way.)
//   STEP 3.1: rolling 16-word message schedule -> FF 44% -> 9%, but LUT 99% ->
//           137% and timing FAILED. Changing index w[i&15] = big muxes, and the
//           in-loop schedule lengthened the path. REVERTED.
//   STEP 3.2: share one SHA unit (2-stage compress loop + pipeline off) -> LUT
//           99% -> 93% but II 137 -> 241 (lost the pipeline overlap). REVERTED.
//   STEP 3.3: remove the early return from the nonce loop. The data-dependent
//           exit was stopping the tool from overlapping nonces, pinning II at
//           137. Sweep the full range, keep the first winner in a sticky flag.
//           RESULT: II 137 -> 4, LUT 98%, timing met, ~50 MH/s. Breakthrough.
//           The tool pipelined the in-loop SHA engine to II=1; LUT is the limit
//           (II violation = resource limited), so 4 is the fit-ceiling.
//   STEP 4: move the midstate to the host. The kernel takes the precomputed
//           midstate (8 words) + the fixed block-2 tail (header 64..75), not the
//           full header, and no longer builds Compression 1 in hardware. Deletes
//           the ~44% LUT midstate unit that ran once then sat idle.
//           RESULT: LUT 98% -> 55%, II 4 -> 6 (~33 MH/s). Board-safe; correct
//           PS/PL split. Freed room, but a 2nd core alone would be ~110%.
//   STEP 5: unroll the nonce loop by 2 to add a 2nd SHA pipeline. FAILED: unroll
//           turned OFF the auto-pipeline, so the loop went sequential (~140
//           cyc/nonce vs 6) and no 2nd engine appeared. Unroll alone does not
//           combine with auto-pipelining. REVERTED.
//   STEP 5.1: explicit pipeline II=3 on the nonce loop. FAILED: the scheduler
//           hung (same as step 3's II=1), so it was killed. Forcing II below the
//           auto value (6) is not feasible on this design. REVERTED.
//
//   STEP 6: array_partition the hot-path arrays (w[], block[]) to test whether
//           II=6 was a memory-port stall. NO EFFECT: II stayed 6, LUT stayed
//           ~56%. So II=6 is NOT memory-limited; it is fundamental (one engine,
//           two dependent compressions per nonce). REVERTED.
//
// FINAL = STEP 4: host-side midstate, auto-pipelined nonce loop. II 6, LUT 55%,
//   timing met, ~33 MH/s single core, board-safe. Confirmed the chip ceiling for
//   a buildable single-engine design after exhausting the lab-safe options.
// ---------------------------------------------------------------------------

#include <stdint.h>

// Round constants: FIPS 180-4, section 4.2.2.
static const uint32_t K[64] = {
    0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
    0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
    0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
    0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
    0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
    0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
    0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2};

// Initial hash state: FIPS 180-4, section 5.3.3.
static const uint32_t H0[8] = {
    0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
    0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19};

static inline uint32_t rotr(uint32_t x, int n) {
    return (x >> n) | (x << (32 - n));
}

// Fold one 64-byte block into the eight-word state (FIPS 180-4, 6.2.2).
// (STEP 3.1 rolling-window version was tried and reverted: it cut FF but pushed
//  LUT to 137% and broke timing, because the changing index w[i&15] becomes big
//  multiplexers and the in-loop schedule lengthened the critical path.)
static void sha256_compress(uint32_t state[8], const uint8_t block[64]) {
    uint32_t w[64];

    // Load the first 16 words big-endian.
    for (int i = 0; i < 16; i++) {
        w[i] = ((uint32_t)block[i * 4]     << 24) |
               ((uint32_t)block[i * 4 + 1] << 16) |
               ((uint32_t)block[i * 4 + 2] <<  8) |
               ((uint32_t)block[i * 4 + 3]);
    }
    // Extend to 64 words.
    for (int i = 16; i < 64; i++) {
        uint32_t s0 = rotr(w[i - 15], 7) ^ rotr(w[i - 15], 18) ^ (w[i - 15] >> 3);
        uint32_t s1 = rotr(w[i - 2], 17) ^ rotr(w[i - 2], 19) ^ (w[i - 2] >> 10);
        w[i] = w[i - 16] + s0 + w[i - 7] + s1;
    }

    uint32_t a = state[0], b = state[1], c = state[2], d = state[3];
    uint32_t e = state[4], f = state[5], g = state[6], h = state[7];

    // 64 rounds.
    for (int i = 0; i < 64; i++) {
        uint32_t S1 = rotr(e, 6) ^ rotr(e, 11) ^ rotr(e, 25);
        uint32_t ch = (e & f) ^ (~e & g);
        uint32_t t1 = h + S1 + ch + K[i] + w[i];
        uint32_t S0 = rotr(a, 2) ^ rotr(a, 13) ^ rotr(a, 22);
        uint32_t maj = (a & b) ^ (a & c) ^ (b & c);
        uint32_t t2 = S0 + maj;
        h = g; g = f; f = e; e = d + t1;
        d = c; c = b; b = a; a = t1 + t2;
    }

    state[0] += a; state[1] += b; state[2] += c; state[3] += d;
    state[4] += e; state[5] += f; state[6] += g; state[7] += h;
}

// Double SHA-256 of a fixed 80-byte header. Writes 32 raw bytes into out.
// The input sizes never change, so all the padding is constant:
//   first hash:  80 bytes -> block 1 (bytes 0..63) + block 2 (bytes 64..79
//                + pad + length 640 bits)
//   second hash: 32 bytes -> one block (digest + pad + length 256 bits)
void sha256d_80(const uint8_t header[80], uint8_t out[32]) {
    uint8_t block[64];
    uint32_t s[8];

    // ---- first hash, block 1: header bytes 0..63 ----
    for (int i = 0; i < 8; i++) s[i] = H0[i];
    for (int i = 0; i < 64; i++) block[i] = header[i];
    sha256_compress(s, block);

    // ---- first hash, block 2: header bytes 64..79 then padding ----
    for (int i = 0; i < 16; i++) block[i] = header[64 + i];
    block[16] = 0x80;
    for (int i = 17; i < 64; i++) block[i] = 0x00;
    // message length = 640 bits = 0x0280, big-endian in the last 8 bytes
    block[62] = 0x02;
    block[63] = 0x80;
    sha256_compress(s, block);

    // first digest as 32 big-endian bytes
    uint8_t digest1[32];
    for (int i = 0; i < 8; i++) {
        digest1[i * 4]     = (uint8_t)(s[i] >> 24);
        digest1[i * 4 + 1] = (uint8_t)(s[i] >> 16);
        digest1[i * 4 + 2] = (uint8_t)(s[i] >>  8);
        digest1[i * 4 + 3] = (uint8_t)(s[i]);
    }

    // ---- second hash: the 32-byte digest in one padded block ----
    for (int i = 0; i < 8; i++) s[i] = H0[i];
    for (int i = 0; i < 32; i++) block[i] = digest1[i];
    block[32] = 0x80;
    for (int i = 33; i < 64; i++) block[i] = 0x00;
    // message length = 256 bits = 0x0100
    block[62] = 0x01;
    block[63] = 0x00;
    sha256_compress(s, block);

    for (int i = 0; i < 8; i++) {
        out[i * 4]     = (uint8_t)(s[i] >> 24);
        out[i * 4 + 1] = (uint8_t)(s[i] >> 16);
        out[i * 4 + 2] = (uint8_t)(s[i] >>  8);
        out[i * 4 + 3] = (uint8_t)(s[i]);
    }
}

// STEP 2/4 (midstate): the SHA-256 state after Compression 1 (header bytes
// 0..63). These bytes never change while the nonce is swept. As of STEP 4 the
// kernel does NOT run this; the host computes the midstate once and passes it in.
// This function stays here only so the software testbench (playing the host) can
// call it. It is not reachable from mine(), so HLS does not synthesize it.
void sha256_midstate(const uint8_t header[80], uint32_t midstate[8]) {
    uint8_t block[64];
    for (int i = 0; i < 8; i++) midstate[i] = H0[i];
    for (int i = 0; i < 64; i++) block[i] = header[i];
    sha256_compress(midstate, block);
}

// Double SHA-256 from a precomputed midstate. STEP 4: block 2 is built from the
// 12 fixed tail bytes (header 64..75: end of merkle root, time, bits) plus the
// nonce, so the kernel no longer needs the full header or Compression 1. Does
// only Compression 2 (block 2, holds the nonce) and Compression 3 (second hash).
void sha256d_from_midstate(const uint32_t midstate[8], const uint8_t tail[12],
                           uint32_t nonce, uint8_t out[32]) {
    uint8_t block[64];
    uint32_t s[8];

    // ---- start from the midstate (Compression 1 done on the host) ----
    for (int i = 0; i < 8; i++) s[i] = midstate[i];

    // ---- Compression 2: block 2 = tail (12B) + nonce (4B, little-endian) + pad ----
    for (int i = 0; i < 12; i++) block[i] = tail[i];
    block[12] = (uint8_t)(nonce);
    block[13] = (uint8_t)(nonce >> 8);
    block[14] = (uint8_t)(nonce >> 16);
    block[15] = (uint8_t)(nonce >> 24);
    block[16] = 0x80;
    for (int i = 17; i < 64; i++) block[i] = 0x00;
    block[62] = 0x02;
    block[63] = 0x80;
    sha256_compress(s, block);

    // first digest as 32 big-endian bytes
    uint8_t digest1[32];
    for (int i = 0; i < 8; i++) {
        digest1[i * 4]     = (uint8_t)(s[i] >> 24);
        digest1[i * 4 + 1] = (uint8_t)(s[i] >> 16);
        digest1[i * 4 + 2] = (uint8_t)(s[i] >>  8);
        digest1[i * 4 + 3] = (uint8_t)(s[i]);
    }

    // ---- Compression 3: second hash of the 32-byte digest ----
    for (int i = 0; i < 8; i++) s[i] = H0[i];
    for (int i = 0; i < 32; i++) block[i] = digest1[i];
    block[32] = 0x80;
    for (int i = 33; i < 64; i++) block[i] = 0x00;
    block[62] = 0x01;
    block[63] = 0x00;
    sha256_compress(s, block);

    for (int i = 0; i < 8; i++) {
        out[i * 4]     = (uint8_t)(s[i] >> 24);
        out[i * 4 + 1] = (uint8_t)(s[i] >> 16);
        out[i * 4 + 2] = (uint8_t)(s[i] >>  8);
        out[i * 4 + 3] = (uint8_t)(s[i]);
    }
}

// A hash wins if, read as a 256-bit big-endian number, it is below the target.
// The raw sha256d output is little-endian, so walk it back to front and compare
// most significant byte first. Same rule as the baseline's hash_below_target.
static bool hash_below_target(const uint8_t raw[32], const uint8_t target[32]) {
    for (int i = 0; i < 32; i++) {
        uint8_t hb = raw[31 - i];
        uint8_t tb = target[i];
        if (hb < tb) return true;
        if (hb > tb) return false;
    }
    return false;  // exactly equal does not win
}

// Top function. STEP 4: inputs are the host-precomputed midstate (8 words) and
// the fixed block-2 tail (header bytes 64..75), not the full header. Search
// nonces [nonce_start, nonce_start + nonce_count) for the first whose double hash
// is below the target; report the winner and a found flag.
void mine(const uint32_t midstate[8], const uint8_t tail[12],
          const uint8_t target[32], uint32_t nonce_start, uint32_t nonce_count,
          uint32_t *found_nonce, int *found) {
#pragma HLS interface m_axi port=midstate bundle=gmem0 depth=8
#pragma HLS interface m_axi port=tail bundle=gmem0 depth=12
#pragma HLS interface m_axi port=target bundle=gmem1 depth=32
#pragma HLS interface m_axi port=found_nonce bundle=gmem2 depth=1
#pragma HLS interface m_axi port=found bundle=gmem2 depth=1
#pragma HLS interface s_axilite port=nonce_start
#pragma HLS interface s_axilite port=nonce_count
#pragma HLS interface s_axilite port=return

    // Read the small inputs into local registers once.
    uint32_t ms[8];
    for (int i = 0; i < 8; i++) ms[i] = midstate[i];
    uint8_t tl[12];
    for (int i = 0; i < 12; i++) tl[i] = tail[i];
    uint8_t tgt[32];
    for (int i = 0; i < 32; i++) tgt[i] = target[i];

    // STEP 3.3: no early return. A data-dependent exit blocks the tool from
    // overlapping consecutive nonces. We sweep the whole range and keep the FIRST
    // winner in sticky registers, so the loop can pipeline nonce after nonce.
    int      found_flag = 0;
    uint32_t found_n    = 0;

    for (uint32_t k = 0; k < nonce_count; k++) {
        // Let the tool auto-pipeline (step 4). Forcing a lower II (step 3 tried
        // II=1, step 5.1 tried II=3) makes the scheduler hang, so we leave it.
        uint32_t n = nonce_start + k;
        uint8_t h[32];
        sha256d_from_midstate(ms, tl, n, h);
        if (hash_below_target(h, tgt) && !found_flag) {
            found_flag = 1;
            found_n    = n;
        }
    }

    *found       = found_flag;
    *found_nonce = found_n;
}
