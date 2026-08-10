// mine_ii1_parallel_scan.cpp
//
// Bitcoin SHA-256d HLS miner.
// Resource-balanced version targeting HASH_CHUNK II=1 with an 8-way parallel result scan.
//
// Interface is kept compatible with the restored host-midstate version:
//   midstate_in[8]
//   tail_words_in[3]
//   target_words_in[8]
//   nonce_start
//   nonce_count
//   found_nonce
//   found
//
// The generic sha256d_80() path is retained for the existing C-simulation
// golden-vector test. The active mining path uses host-precomputed midstate
// and targets II=4 so Vitis HLS can share arithmetic across pipeline slots.

#include <stdint.h>

// SHA-256 round constants.
static const uint32_t K[64] = {
    0x428a2f98U, 0x71374491U, 0xb5c0fbcfU, 0xe9b5dba5U,
    0x3956c25bU, 0x59f111f1U, 0x923f82a4U, 0xab1c5ed5U,
    0xd807aa98U, 0x12835b01U, 0x243185beU, 0x550c7dc3U,
    0x72be5d74U, 0x80deb1feU, 0x9bdc06a7U, 0xc19bf174U,
    0xe49b69c1U, 0xefbe4786U, 0x0fc19dc6U, 0x240ca1ccU,
    0x2de92c6fU, 0x4a7484aaU, 0x5cb0a9dcU, 0x76f988daU,
    0x983e5152U, 0xa831c66dU, 0xb00327c8U, 0xbf597fc7U,
    0xc6e00bf3U, 0xd5a79147U, 0x06ca6351U, 0x14292967U,
    0x27b70a85U, 0x2e1b2138U, 0x4d2c6dfcU, 0x53380d13U,
    0x650a7354U, 0x766a0abbU, 0x81c2c92eU, 0x92722c85U,
    0xa2bfe8a1U, 0xa81a664bU, 0xc24b8b70U, 0xc76c51a3U,
    0xd192e819U, 0xd6990624U, 0xf40e3585U, 0x106aa070U,
    0x19a4c116U, 0x1e376c08U, 0x2748774cU, 0x34b0bcb5U,
    0x391c0cb3U, 0x4ed8aa4aU, 0x5b9cca4fU, 0x682e6ff3U,
    0x748f82eeU, 0x78a5636fU, 0x84c87814U, 0x8cc70208U,
    0x90befffaU, 0xa4506cebU, 0xbef9a3f7U, 0xc67178f2U
};

// SHA-256 initial state.
static const uint32_t H0[8] = {
    0x6a09e667U, 0xbb67ae85U, 0x3c6ef372U, 0xa54ff53aU,
    0x510e527fU, 0x9b05688cU, 0x1f83d9abU, 0x5be0cd19U
};

static inline uint32_t rotr(uint32_t x, unsigned n) {
    return (x >> n) | (x << (32U - n));
}

static inline uint32_t bswap32(uint32_t x) {
    return ((x & 0x000000ffU) << 24) |
           ((x & 0x0000ff00U) << 8)  |
           ((x & 0x00ff0000U) >> 8)  |
           ((x & 0xff000000U) >> 24);
}

static inline uint32_t small_sigma0(uint32_t x) {
    return rotr(x, 7) ^ rotr(x, 18) ^ (x >> 3);
}

static inline uint32_t small_sigma1(uint32_t x) {
    return rotr(x, 17) ^ rotr(x, 19) ^ (x >> 10);
}

static inline uint32_t big_sigma0(uint32_t x) {
    return rotr(x, 2) ^ rotr(x, 13) ^ rotr(x, 22);
}

static inline uint32_t big_sigma1(uint32_t x) {
    return rotr(x, 6) ^ rotr(x, 11) ^ rotr(x, 25);
}

static inline uint32_t choose(uint32_t e, uint32_t f, uint32_t g) {
    // Equivalent to (e & f) ^ (~e & g), usually slightly cheaper.
    return g ^ (e & (f ^ g));
}

static inline uint32_t majority(uint32_t a, uint32_t b, uint32_t c) {
    // Equivalent to (a & b) ^ (a & c) ^ (b & c).
    return (a & b) ^ (c & (a ^ b));
}

// -----------------------------------------------------------------------------
// Generic SHA-256 compression.
// Used only by sha256d_80() so the existing golden-vector test remains simple.
// -----------------------------------------------------------------------------
static void sha256_compress(
    uint32_t state[8],
    const uint8_t block[64]
) {
    uint32_t w[16];

#pragma HLS ARRAY_PARTITION variable=w cyclic factor=4 dim=1

    LOAD_INITIAL_WORDS:
    for (int i = 0; i < 16; ++i) {
        w[i] =
            ((uint32_t)block[i * 4 + 0] << 24) |
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

    SHA256_ROUNDS_GENERIC:
    for (int t = 0; t < 64; ++t) {
        uint32_t wt;

        if (t < 16) {
            wt = w[t];
        } else {
            const int j = t & 15;
            wt =
                w[j] +
                small_sigma0(w[(j + 1) & 15]) +
                w[(j + 9) & 15] +
                small_sigma1(w[(j + 14) & 15]);
            w[j] = wt;
        }

        const uint32_t t1 =
            h + big_sigma1(e) + choose(e, f, g) + K[t] + wt;
        const uint32_t t2 =
            big_sigma0(a) + majority(a, b, c);

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

// -----------------------------------------------------------------------------
// Resource-balanced active compression path.
//
// A 16-word rolling schedule is used instead of storing W[0..63].
// We keep the function boundary so Vitis can schedule/share this block rather
// than forcing it to be textually duplicated into the caller.
//
// The outer mining loop is the performance constraint: II=1.
// -----------------------------------------------------------------------------
static void sha256_compress_words_ii1(
    uint32_t state[8],
    const uint32_t block_words[16]
) {
#pragma HLS INLINE off

    uint32_t w[16];
#pragma HLS ARRAY_PARTITION variable=w complete dim=1

    LOAD_WORD_SCHEDULE:
    for (int i = 0; i < 16; ++i) {
#pragma HLS UNROLL
        w[i] = block_words[i];
    }

    uint32_t a = state[0];
    uint32_t b = state[1];
    uint32_t c = state[2];
    uint32_t d = state[3];
    uint32_t e = state[4];
    uint32_t f = state[5];
    uint32_t g = state[6];
    uint32_t h = state[7];

    SHA256_WORD_ROUNDS_II1:
    for (int i = 0; i < 64; ++i) {
        uint32_t wt;

        if (i < 16) {
            wt = w[i];
        } else {
            const int j = i & 15;

            const uint32_t wm15 = w[(j + 1) & 15];
            const uint32_t wm2  = w[(j + 14) & 15];

            const uint32_t s0 = small_sigma0(wm15);
            const uint32_t s1 = small_sigma1(wm2);

            // Keep the schedule additions explicit. Mapping these to DSPs
            // reduces LUT pressure while II=4 gives the scheduler more room
            // to share the arithmetic.
            uint32_t sched_sum0;
            uint32_t sched_sum1;
            uint32_t sched_sum2;

#pragma HLS BIND_OP variable=sched_sum0 op=add impl=fabric
#pragma HLS BIND_OP variable=sched_sum1 op=add impl=fabric
#pragma HLS BIND_OP variable=sched_sum2 op=add impl=fabric

            sched_sum0 = w[j] + s0;
            sched_sum1 = w[(j + 9) & 15] + s1;
            sched_sum2 = sched_sum0 + sched_sum1;
            wt = sched_sum2;
            w[j] = wt;
        }

        const uint32_t S1 = big_sigma1(e);
        const uint32_t ch = choose(e, f, g);

        uint32_t t1_sum0;
        uint32_t t1_sum1;
        uint32_t t1_sum2;
        uint32_t t1;

#pragma HLS BIND_OP variable=t1_sum0 op=add impl=dsp
#pragma HLS BIND_OP variable=t1_sum1 op=add impl=dsp
#pragma HLS BIND_OP variable=t1_sum2 op=add impl=dsp
#pragma HLS BIND_OP variable=t1      op=add impl=fabric

        t1_sum0 = h + S1;
        t1_sum1 = ch + K[i];
        t1_sum2 = t1_sum0 + t1_sum1;
        t1      = t1_sum2 + wt;

        const uint32_t S0 = big_sigma0(a);
        const uint32_t maj = majority(a, b, c);

        uint32_t t2;
#pragma HLS BIND_OP variable=t2 op=add impl=dsp
        t2 = S0 + maj;

        // Keep these two recurrence updates on LUT/carry logic. In previous
        // versions, forcing recurrence-path adds into DSPs could increase
        // round latency and hurt achieved II.
        const uint32_t next_e = d + t1;
        const uint32_t next_a = t1 + t2;

        h = g;
        g = f;
        f = e;
        e = next_e;
        d = c;
        c = b;
        b = a;
        a = next_a;
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

// Active Bitcoin double-SHA path starting from the host-computed midstate.
static void sha256d_80_from_midstate_words_ii1(
    const uint32_t midstate[8],
    uint32_t tail_word0,
    uint32_t tail_word1,
    uint32_t tail_word2,
    uint32_t nonce,
    uint32_t final_state[8]
) {
#pragma HLS INLINE off

    uint32_t first_hash_state[8];
#pragma HLS ARRAY_PARTITION variable=first_hash_state complete dim=1

    COPY_MIDSTATE_ACTIVE:
    for (int i = 0; i < 8; ++i) {
#pragma HLS UNROLL
        first_hash_state[i] = midstate[i];
    }

    uint32_t block1_words[16];
#pragma HLS ARRAY_PARTITION variable=block1_words complete dim=1

    block1_words[0] = tail_word0;
    block1_words[1] = tail_word1;
    block1_words[2] = tail_word2;
    block1_words[3] = bswap32(nonce);
    block1_words[4] = 0x80000000U;

    CLEAR_BLOCK1:
    for (int i = 5; i < 15; ++i) {
#pragma HLS UNROLL
        block1_words[i] = 0U;
    }

    block1_words[15] = 0x00000280U;

    sha256_compress_words_ii1(first_hash_state, block1_words);

    uint32_t second_hash_state[8];
#pragma HLS ARRAY_PARTITION variable=second_hash_state complete dim=1

    INIT_SECOND_STATE:
    for (int i = 0; i < 8; ++i) {
#pragma HLS UNROLL
        second_hash_state[i] = H0[i];
    }

    uint32_t block2_words[16];
#pragma HLS ARRAY_PARTITION variable=block2_words complete dim=1

    COPY_DIGEST_TO_SECOND_BLOCK:
    for (int i = 0; i < 8; ++i) {
#pragma HLS UNROLL
        block2_words[i] = first_hash_state[i];
    }

    block2_words[8] = 0x80000000U;

    CLEAR_BLOCK2:
    for (int i = 9; i < 15; ++i) {
#pragma HLS UNROLL
        block2_words[i] = 0U;
    }

    block2_words[15] = 0x00000100U;

    sha256_compress_words_ii1(second_hash_state, block2_words);

    COPY_FINAL_STATE:
    for (int i = 0; i < 8; ++i) {
#pragma HLS UNROLL
        final_state[i] = second_hash_state[i];
    }
}

static bool hash_state_below_target(
    const uint32_t hash_state[8],
    const uint32_t target_words[8]
) {
    COMPARE_HASH_WORDS:
    for (int i = 0; i < 8; ++i) {
        // raw hash is converted to Bitcoin display/integer order.
        const uint32_t hash_word = bswap32(hash_state[7 - i]);
        const uint32_t target_word = target_words[i];

        if (hash_word < target_word) {
            return true;
        }
        if (hash_word > target_word) {
            return false;
        }
    }
    return false;
}

// -----------------------------------------------------------------------------
// Full reference double SHA-256.
// Retained for existing golden.dat C simulation.
// -----------------------------------------------------------------------------
void sha256d_80(
    const uint8_t header[80],
    uint8_t out[32]
) {
    uint8_t block[64];
    uint32_t state[8];

    INIT_FIRST_HASH:
    for (int i = 0; i < 8; ++i) {
        state[i] = H0[i];
    }

    COPY_FIRST_BLOCK:
    for (int i = 0; i < 64; ++i) {
        block[i] = header[i];
    }

    sha256_compress(state, block);

    COPY_SECOND_BLOCK_DATA:
    for (int i = 0; i < 16; ++i) {
        block[i] = header[64 + i];
    }

    block[16] = 0x80U;

    CLEAR_SECOND_BLOCK:
    for (int i = 17; i < 64; ++i) {
        block[i] = 0U;
    }

    // 80 bytes = 640 bits.
    block[62] = 0x02U;
    block[63] = 0x80U;

    sha256_compress(state, block);

    uint8_t digest1[32];

    STATE_TO_DIGEST:
    for (int i = 0; i < 8; ++i) {
        digest1[i * 4 + 0] = (uint8_t)(state[i] >> 24);
        digest1[i * 4 + 1] = (uint8_t)(state[i] >> 16);
        digest1[i * 4 + 2] = (uint8_t)(state[i] >> 8);
        digest1[i * 4 + 3] = (uint8_t)(state[i]);
    }

    INIT_SECOND_HASH:
    for (int i = 0; i < 8; ++i) {
        state[i] = H0[i];
    }

    COPY_DIGEST:
    for (int i = 0; i < 32; ++i) {
        block[i] = digest1[i];
    }

    block[32] = 0x80U;

    CLEAR_DIGEST_BLOCK:
    for (int i = 33; i < 64; ++i) {
        block[i] = 0U;
    }

    // 32 bytes = 256 bits.
    block[62] = 0x01U;
    block[63] = 0x00U;

    sha256_compress(state, block);

    WRITE_OUTPUT:
    for (int i = 0; i < 8; ++i) {
        out[i * 4 + 0] = (uint8_t)(state[i] >> 24);
        out[i * 4 + 1] = (uint8_t)(state[i] >> 16);
        out[i * 4 + 2] = (uint8_t)(state[i] >> 8);
        out[i * 4 + 3] = (uint8_t)(state[i]);
    }
}

// -----------------------------------------------------------------------------
// Top-level mining kernel.
// -----------------------------------------------------------------------------
void mine(
    const uint32_t midstate_in[8],
    const uint32_t tail_words_in[3],
    const uint32_t target_words_in[8],
    uint32_t nonce_start,
    uint32_t nonce_count,
    uint32_t *found_nonce,
    int *found
) {
#pragma HLS INTERFACE m_axi port=midstate_in    bundle=gmem0 depth=8
#pragma HLS INTERFACE m_axi port=tail_words_in  bundle=gmem0 depth=3
#pragma HLS INTERFACE m_axi port=target_words_in bundle=gmem1 depth=8
#pragma HLS INTERFACE m_axi port=found_nonce    bundle=gmem2 depth=1
#pragma HLS INTERFACE m_axi port=found          bundle=gmem2 depth=1

#pragma HLS INTERFACE s_axilite port=nonce_start
#pragma HLS INTERFACE s_axilite port=nonce_count
#pragma HLS INTERFACE s_axilite port=return

    static const uint32_t CHUNK_SIZE = 2048U;

    uint32_t midstate[8];
    uint32_t target_words[8];

#pragma HLS ARRAY_PARTITION variable=midstate complete dim=1
#pragma HLS ARRAY_PARTITION variable=target_words complete dim=1

    LOAD_MIDSTATE:
    for (int i = 0; i < 8; ++i) {
#pragma HLS UNROLL
        midstate[i] = midstate_in[i];
    }

    const uint32_t tail_word0 = tail_words_in[0];
    const uint32_t tail_word1 = tail_words_in[1];
    const uint32_t tail_word2 = tail_words_in[2];

    LOAD_TARGET:
    for (int i = 0; i < 8; ++i) {
#pragma HLS UNROLL
        target_words[i] = target_words_in[i];
    }

    bool found_local = false;
    uint32_t found_nonce_local = 0U;

    CHUNK_LOOP:
    for (
        uint32_t chunk_base = 0U;
        chunk_base < nonce_count;
        chunk_base += CHUNK_SIZE
    ) {
#pragma HLS LOOP_TRIPCOUNT min=1 avg=2048 max=4096

        const uint32_t remaining = nonce_count - chunk_base;
        const uint32_t chunk_count =
            (remaining < CHUNK_SIZE) ? remaining : CHUNK_SIZE;

        // Eight cyclic banks let the scan read eight result flags in parallel.
        // HASH_CHUNK still writes only one flag per cycle, so this does not
        // increase the required write bandwidth.
        static const uint32_t SCAN_WIDTH = 8U;

        bool match_flags[CHUNK_SIZE];
#pragma HLS ARRAY_PARTITION variable=match_flags cyclic factor=8 dim=1
#pragma HLS BIND_STORAGE variable=match_flags type=ram_1p impl=lutram

        // Main mining throughput loop: one new nonce every clock cycle.
        HASH_CHUNK:
        for (uint32_t i = 0U; i < chunk_count; ++i) {
#pragma HLS LOOP_TRIPCOUNT min=1 avg=2048 max=2048
#pragma HLS PIPELINE II=1

            const uint32_t nonce =
                nonce_start + chunk_base + i;

            uint32_t final_state[8];
#pragma HLS ARRAY_PARTITION variable=final_state complete dim=1

            sha256d_80_from_midstate_words_ii1(
                midstate,
                tail_word0,
                tail_word1,
                tail_word2,
                nonce,
                final_state
            );

            match_flags[i] =
                hash_state_below_target(
                    final_state,
                    target_words
                );
        }

        bool chunk_found = false;
        uint32_t chunk_match_index = 0U;

        // Scan eight result flags per cycle.
        //
        // The explicit priority chain guarantees that if several flags in the
        // same group are true, the lowest index (therefore the lowest nonce)
        // is selected. chunk_found prevents later groups from overwriting the
        // first matching group.
        const uint32_t scan_groups =
            (chunk_count + SCAN_WIDTH - 1U) / SCAN_WIDTH;

        SCAN_CHUNK_PARALLEL:
        for (uint32_t group = 0U; group < scan_groups; ++group) {
#pragma HLS LOOP_TRIPCOUNT min=1 avg=256 max=256
#pragma HLS PIPELINE II=1

            const uint32_t base = group * SCAN_WIDTH;

            const bool m0 =
                (base + 0U < chunk_count) ? match_flags[base + 0U] : false;
            const bool m1 =
                (base + 1U < chunk_count) ? match_flags[base + 1U] : false;
            const bool m2 =
                (base + 2U < chunk_count) ? match_flags[base + 2U] : false;
            const bool m3 =
                (base + 3U < chunk_count) ? match_flags[base + 3U] : false;
            const bool m4 =
                (base + 4U < chunk_count) ? match_flags[base + 4U] : false;
            const bool m5 =
                (base + 5U < chunk_count) ? match_flags[base + 5U] : false;
            const bool m6 =
                (base + 6U < chunk_count) ? match_flags[base + 6U] : false;
            const bool m7 =
                (base + 7U < chunk_count) ? match_flags[base + 7U] : false;

            bool group_found = false;
            uint32_t group_offset = 0U;

            // Lowest-index priority encoder.
            if (m0) {
                group_found = true;
                group_offset = 0U;
            } else if (m1) {
                group_found = true;
                group_offset = 1U;
            } else if (m2) {
                group_found = true;
                group_offset = 2U;
            } else if (m3) {
                group_found = true;
                group_offset = 3U;
            } else if (m4) {
                group_found = true;
                group_offset = 4U;
            } else if (m5) {
                group_found = true;
                group_offset = 5U;
            } else if (m6) {
                group_found = true;
                group_offset = 6U;
            } else if (m7) {
                group_found = true;
                group_offset = 7U;
            }

            if (group_found && !chunk_found) {
                chunk_found = true;
                chunk_match_index = base + group_offset;
            }
        }

        if (chunk_found) {
            found_local = true;
            found_nonce_local =
                nonce_start + chunk_base + chunk_match_index;
            break;
        }
    }

    *found = found_local ? 1 : 0;
    *found_nonce = found_local ? found_nonce_local : 0U;
}