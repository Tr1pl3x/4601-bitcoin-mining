// Bitcoin miner HLS kernel — midstate-only optimization.
//
// This version keeps the original SHA-256 compression architecture and data
// structures. The only algorithmic optimization is that the first 64-byte
// block of the 80-byte Bitcoin header is compressed once before the nonce
// loop. Each nonce then performs only:
//   1. the second block of the first SHA-256, and
//   2. the complete second SHA-256.
//
// The original sha256d_80() function is retained for the existing testbench.

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
    0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
};

// Initial hash state: FIPS 180-4, section 5.3.3.
static const uint32_t H0[8] = {
    0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
    0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19
};

static inline uint32_t rotr(uint32_t x, int n) {
    return (x >> n) | (x << (32 - n));
}

static inline uint32_t bswap32(uint32_t x) {
    return ((x & 0x000000ffU) << 24) |
           ((x & 0x0000ff00U) << 8)  |
           ((x & 0x00ff0000U) >> 8)  |
           ((x & 0xff000000U) >> 24);
}

// Fold one 64-byte block into the eight-word state.
static void sha256_compress(
    uint32_t state[8],
    const uint8_t block[64]
) {
    uint32_t w[16];

    // Moderate partitioning rather than complete partitioning of every array.
#pragma HLS ARRAY_PARTITION variable=w cyclic factor=4 dim=1

    LOAD_INITIAL_WORDS:
    for (int i = 0; i < 16; i++) {
        w[i] =
            ((uint32_t)block[i * 4]     << 24) |
            ((uint32_t)block[i * 4 + 1] << 16) |
            ((uint32_t)block[i * 4 + 2] << 8)  |
            ((uint32_t)block[i * 4 + 3]);
    }

    uint32_t a = state[0];
    uint32_t b = state[1];
    uint32_t c = state[2];
    uint32_t d = state[3];
    uint32_t e = state[4];
    uint32_t f = state[5];
    uint32_t g = state[6];
    uint32_t h = state[7];

    SHA256_ROUNDS:
    for (int t = 0; t < 64; t++) {
        uint32_t wt;

        if (t < 16) {
            wt = w[t];
        } else {
            int j = t & 15;

            uint32_t w15 = w[(j + 1) & 15];
            uint32_t w2  = w[(j + 14) & 15];

            uint32_t s0 =
                rotr(w15, 7) ^
                rotr(w15, 18) ^
                (w15 >> 3);

            uint32_t s1 =
                rotr(w2, 17) ^
                rotr(w2, 19) ^
                (w2 >> 10);

            wt = w[j] + s0 + w[(j + 9) & 15] + s1;

            // Replace the schedule word that is no longer needed.
            w[j] = wt;
        }

        uint32_t S1 =
            rotr(e, 6) ^
            rotr(e, 11) ^
            rotr(e, 25);

        uint32_t ch = (e & f) ^ (~e & g);
        uint32_t t1 = h + S1 + ch + K[t] + wt;

        uint32_t S0 =
            rotr(a, 2) ^
            rotr(a, 13) ^
            rotr(a, 22);

        uint32_t maj =
            (a & b) ^
            (a & c) ^
            (b & c);

        uint32_t t2 = S0 + maj;

        h = g;
        g = f;
        f = e;
        e = d + t1;
        d = c;
        c = b;
        b = a;
        a = t1 + t2;
    }

    state[0] += a;
    state[1] += b;
    state[2] += c;
    state[3] += d;
    state[4] += e;
    state[5] += f;
    state[6] += g;
    state[7] += h;
}

static void sha256_compress_words(
    uint32_t state[8],
    const uint32_t initial_words[16]
) {
#pragma HLS INLINE off

    uint32_t w[64];

    COPY_INITIAL_WORDS:
    for (int i = 0; i < 16; i++) {
        w[i] = initial_words[i];
    }

    EXTEND_WORDS_DIRECT:
    for (int i = 16; i < 64; i++) {
        uint32_t s0 =
            rotr(w[i - 15], 7) ^
            rotr(w[i - 15], 18) ^
            (w[i - 15] >> 3);

        uint32_t s1 =
            rotr(w[i - 2], 17) ^
            rotr(w[i - 2], 19) ^
            (w[i - 2] >> 10);

        w[i] = w[i - 16] + s0 + w[i - 7] + s1;
    }

    uint32_t a = state[0];
    uint32_t b = state[1];
    uint32_t c = state[2];
    uint32_t d = state[3];
    uint32_t e = state[4];
    uint32_t f = state[5];
    uint32_t g = state[6];
    uint32_t h = state[7];

    SHA256_WORD_ROUNDS:
    for (int i = 0; i < 64; i++) {
        uint32_t S1 =
            rotr(e, 6) ^
            rotr(e, 11) ^
            rotr(e, 25);

        uint32_t ch = (e & f) ^ (~e & g);
        uint32_t t1 = h + S1 + ch + K[i] + w[i];

        uint32_t S0 =
            rotr(a, 2) ^
            rotr(a, 13) ^
            rotr(a, 22);

        uint32_t maj =
            (a & b) ^
            (a & c) ^
            (b & c);

        uint32_t t2 = S0 + maj;

        h = g;
        g = f;
        f = e;
        e = d + t1;
        d = c;
        c = b;
        b = a;
        a = t1 + t2;
    }

    state[0] += a;
    state[1] += b;
    state[2] += c;
    state[3] += d;
    state[4] += e;
    state[5] += f;
    state[6] += g;
    state[7] += h;
}

static void sha256d_80_from_midstate_words(
    const uint32_t midstate[8],
    uint32_t tail_word0,
    uint32_t tail_word1,
    uint32_t tail_word2,
    uint32_t nonce,
    uint32_t final_state[8]
) {
#pragma HLS INLINE off

    uint32_t first_hash_state[8];

    COPY_WORD_MIDSTATE:
    for (int i = 0; i < 8; i++) {
        first_hash_state[i] = midstate[i];
    }

    // First SHA-256, second block.
    //
    // W0..W2: header bytes 64..75
    // W3:     nonce from bytes 76..79
    // W4:     padding
    // W5..14: zero
    // W15:    640-bit message length
    uint32_t block1_words[16];

    block1_words[0] = tail_word0;
    block1_words[1] = tail_word1;
    block1_words[2] = tail_word2;

    // The nonce is stored little-endian in the Bitcoin header, but SHA-256
    // loads message words big-endian.
    block1_words[3] = bswap32(nonce);

    block1_words[4] = 0x80000000U;

    CLEAR_BLOCK1_WORDS:
    for (int i = 5; i < 15; i++) {
        block1_words[i] = 0;
    }

    block1_words[15] = 0x00000280U;

    sha256_compress_words(first_hash_state, block1_words);

    // Second SHA-256 block.
    //
    // W0..W7: first digest
    // W8:     padding
    // W9..14: zero
    // W15:    256-bit message length
    uint32_t block2_words[16];

    COPY_FIRST_DIGEST_WORDS:
    for (int i = 0; i < 8; i++) {
        block2_words[i] = first_hash_state[i];
    }

    block2_words[8] = 0x80000000U;

    CLEAR_BLOCK2_WORDS:
    for (int i = 9; i < 15; i++) {
        block2_words[i] = 0;
    }

    block2_words[15] = 0x00000100U;

    uint32_t second_hash_state[8];

    INIT_SECOND_HASH_WORDS:
    for (int i = 0; i < 8; i++) {
        second_hash_state[i] = H0[i];
    }

    sha256_compress_words(second_hash_state, block2_words);

    COPY_FINAL_STATE:
    for (int i = 0; i < 8; i++) {
        final_state[i] = second_hash_state[i];
    }
}

static bool hash_state_below_target(
    const uint32_t hash_state[8],
    const uint32_t target_words[8]
) {
    COMPARE_HASH_WORDS:
    for (int i = 0; i < 8; i++) {
        // Existing code reverses all 32 raw hash bytes before comparison.
        // This is equivalent to reversing the word order and byte-swapping
        // each state word.
        uint32_t hash_word = bswap32(hash_state[7 - i]);
        uint32_t target_word = target_words[i];

        if (hash_word < target_word) {
            return true;
        }

        if (hash_word > target_word) {
            return false;
        }
    }

    return false;
}

// Original complete double SHA-256 implementation.
// Retained so the existing HLS testbench can test sha256d_80 directly.
void sha256d_80(const uint8_t header[80], uint8_t out[32]) {
    uint8_t block[64];
    uint32_t s[8];

    INIT_FIRST_HASH:
    for (int i = 0; i < 8; i++) {
        s[i] = H0[i];
    }

    COPY_FIRST_BLOCK:
    for (int i = 0; i < 64; i++) {
        block[i] = header[i];
    }

    sha256_compress(s, block);

    COPY_SECOND_BLOCK_DATA:
    for (int i = 0; i < 16; i++) {
        block[i] = header[64 + i];
    }

    block[16] = 0x80;

    CLEAR_SECOND_BLOCK:
    for (int i = 17; i < 64; i++) {
        block[i] = 0x00;
    }

    // 80 bytes = 640 bits = 0x0280.
    block[62] = 0x02;
    block[63] = 0x80;

    sha256_compress(s, block);

    uint8_t digest1[32];

    STATE_TO_DIGEST:
    for (int i = 0; i < 8; i++) {
        digest1[i * 4]     = (uint8_t)(s[i] >> 24);
        digest1[i * 4 + 1] = (uint8_t)(s[i] >> 16);
        digest1[i * 4 + 2] = (uint8_t)(s[i] >> 8);
        digest1[i * 4 + 3] = (uint8_t)(s[i]);
    }

    INIT_SECOND_HASH:
    for (int i = 0; i < 8; i++) {
        s[i] = H0[i];
    }

    COPY_DIGEST:
    for (int i = 0; i < 32; i++) {
        block[i] = digest1[i];
    }

    block[32] = 0x80;

    CLEAR_DIGEST_BLOCK:
    for (int i = 33; i < 64; i++) {
        block[i] = 0x00;
    }

    // 32 bytes = 256 bits = 0x0100.
    block[62] = 0x01;
    block[63] = 0x00;

    sha256_compress(s, block);

    WRITE_OUTPUT:
    for (int i = 0; i < 8; i++) {
        out[i * 4]     = (uint8_t)(s[i] >> 24);
        out[i * 4 + 1] = (uint8_t)(s[i] >> 16);
        out[i * 4 + 2] = (uint8_t)(s[i] >> 8);
        out[i * 4 + 3] = (uint8_t)(s[i]);
    }
}

// Continue double SHA-256 from the state after header bytes 0..63.
static void sha256d_80_from_midstate(
    const uint32_t midstate[8],
    const uint8_t header[80],
    uint8_t out[32]
) {
    uint8_t block[64];
    uint32_t s[8];

    COPY_MIDSTATE:
    for (int i = 0; i < 8; i++) {
        s[i] = midstate[i];
    }

    COPY_TAIL:
    for (int i = 0; i < 16; i++) {
        block[i] = header[64 + i];
    }

    block[16] = 0x80;

    CLEAR_TAIL_BLOCK:
    for (int i = 17; i < 64; i++) {
        block[i] = 0x00;
    }

    // 80 bytes = 640 bits = 0x0280.
    block[62] = 0x02;
    block[63] = 0x80;

    sha256_compress(s, block);

    uint8_t digest1[32];

    MIDSTATE_DIGEST:
    for (int i = 0; i < 8; i++) {
        digest1[i * 4]     = (uint8_t)(s[i] >> 24);
        digest1[i * 4 + 1] = (uint8_t)(s[i] >> 16);
        digest1[i * 4 + 2] = (uint8_t)(s[i] >> 8);
        digest1[i * 4 + 3] = (uint8_t)(s[i]);
    }

    RESET_SECOND_HASH:
    for (int i = 0; i < 8; i++) {
        s[i] = H0[i];
    }

    COPY_FIRST_DIGEST:
    for (int i = 0; i < 32; i++) {
        block[i] = digest1[i];
    }

    block[32] = 0x80;

    CLEAR_SECOND_HASH_BLOCK:
    for (int i = 33; i < 64; i++) {
        block[i] = 0x00;
    }

    // 32 bytes = 256 bits = 0x0100.
    block[62] = 0x01;
    block[63] = 0x00;

    sha256_compress(s, block);

    WRITE_MIDSTATE_OUTPUT:
    for (int i = 0; i < 8; i++) {
        out[i * 4]     = (uint8_t)(s[i] >> 24);
        out[i * 4 + 1] = (uint8_t)(s[i] >> 16);
        out[i * 4 + 2] = (uint8_t)(s[i] >> 8);
        out[i * 4 + 3] = (uint8_t)(s[i]);
    }
}

static bool hash_below_target(
    const uint8_t raw[32],
    const uint8_t target[32]
) {
    COMPARE_HASH:
    for (int i = 0; i < 32; i++) {
        uint8_t hb = raw[31 - i];
        uint8_t tb = target[i];

        if (hb < tb) {
            return true;
        }

        if (hb > tb) {
            return false;
        }
    }

    return false;
}

// Top-level mining kernel.
void mine(
    const uint8_t header[80],
    const uint8_t target[32],
    uint32_t nonce_start,
    uint32_t nonce_count,
    uint32_t *found_nonce,
    int *found
) {
#pragma HLS interface m_axi port=header bundle=gmem0 depth=80
#pragma HLS interface m_axi port=target bundle=gmem1 depth=32
#pragma HLS interface m_axi port=found_nonce bundle=gmem2 depth=1
#pragma HLS interface m_axi port=found bundle=gmem2 depth=1
#pragma HLS interface s_axilite port=nonce_start
#pragma HLS interface s_axilite port=nonce_count
#pragma HLS interface s_axilite port=return

    uint8_t hdr[80];

    COPY_HEADER:
    for (int i = 0; i < 80; i++) {
        hdr[i] = header[i];
    }

    uint8_t tgt[32];

    COPY_TARGET:
    for (int i = 0; i < 32; i++) {
        tgt[i] = target[i];
    }

    uint32_t tail_word0 =
        ((uint32_t)hdr[64] << 24) |
        ((uint32_t)hdr[65] << 16) |
        ((uint32_t)hdr[66] << 8)  |
        ((uint32_t)hdr[67]);

    uint32_t tail_word1 =
        ((uint32_t)hdr[68] << 24) |
        ((uint32_t)hdr[69] << 16) |
        ((uint32_t)hdr[70] << 8)  |
        ((uint32_t)hdr[71]);

    uint32_t tail_word2 =
        ((uint32_t)hdr[72] << 24) |
        ((uint32_t)hdr[73] << 16) |
        ((uint32_t)hdr[74] << 8)  |
        ((uint32_t)hdr[75]);

    uint32_t target_words[8];

    BUILD_TARGET_WORDS:
    for (int i = 0; i < 8; i++) {
        target_words[i] =
            ((uint32_t)tgt[i * 4] << 24) |
            ((uint32_t)tgt[i * 4 + 1] << 16) |
            ((uint32_t)tgt[i * 4 + 2] << 8) |
            ((uint32_t)tgt[i * 4 + 3]);
    }

    *found = 0;
    *found_nonce = 0;

    // Compress invariant header bytes 0..63 once before NONCE_LOOP.
    uint8_t first_block[64];

    COPY_INVARIANT_BLOCK:
    for (int i = 0; i < 64; i++) {
        first_block[i] = hdr[i];
    }

    uint32_t midstate[8];

    INIT_MIDSTATE:
    for (int i = 0; i < 8; i++) {
        midstate[i] = H0[i];
    }

    sha256_compress(midstate, first_block);

    // Separate mutable header for each hashing lane.
    uint8_t hdr_lane0[80];
    uint8_t hdr_lane1[80];

    COPY_LANE_HEADERS:
    for (int i = 0; i < 80; i++) {
        hdr_lane0[i] = hdr[i];
        hdr_lane1[i] = hdr[i];
    }

    NONCE_LOOP:
    for (uint32_t k = 0; k < nonce_count; k++) {
    #pragma HLS LOOP_TRIPCOUNT min=1 avg=65536 max=1048576

        uint32_t nonce = nonce_start + k;
        uint32_t final_state[8];

        sha256d_80_from_midstate_words(
            midstate,
            tail_word0,
            tail_word1,
            tail_word2,
            nonce,
            final_state
        );

        if (hash_state_below_target(final_state, target_words)) {
            *found = 1;
            *found_nonce = nonce;
            return;
        }
    }
}