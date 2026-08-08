#ifndef MINER_CORE_H
#define MINER_CORE_H

// Software-side helpers the board host reuses from the baseline miner: build a
// header, decode the target, compare a hash, and run a software nonce scan.
// These are the exact functions from src/baseline/miner.cpp, moved into a
// header so the host can share them with the kernel path bit-for-bit. Only the
// linkage changed (static -> inline); the logic is untouched, so the genesis
// test still proves the byte order.

#include <cstdint>
#include <cstring>
#include "sha256.h"

static const int HEADER_BYTES = 80;

struct BlockHeader {
    uint32_t version;
    uint8_t  prev_hash[32];    // internal byte order (little-endian display reversed)
    uint8_t  merkle_root[32];  // internal byte order
    uint32_t time;
    uint32_t bits;
    uint32_t nonce;
};

inline void put_le32(uint8_t* p, uint32_t v) {
    p[0] = uint8_t(v);
    p[1] = uint8_t(v >> 8);
    p[2] = uint8_t(v >> 16);
    p[3] = uint8_t(v >> 24);
}

// Lay the header out into its 80 raw bytes, ready to hash.
inline void serialize_header(const BlockHeader& h, uint8_t out[HEADER_BYTES]) {
    put_le32(out + 0, h.version);
    memcpy(out + 4, h.prev_hash, 32);
    memcpy(out + 36, h.merkle_root, 32);
    put_le32(out + 68, h.time);
    put_le32(out + 72, h.bits);
    put_le32(out + 76, h.nonce);
}

// Expand the 4-byte compact target (nBits) into a full 32-byte big-endian target.
inline void bits_to_target(uint32_t bits, uint8_t target[32]) {
    memset(target, 0, 32);
    uint32_t exponent = bits >> 24;
    uint32_t mantissa = bits & 0x00ffffff;
    for (int i = 0; i < 3; i++) {
        int shift = int(exponent) - 3 + (2 - i);
        if (shift >= 0 && shift < 32) {
            target[31 - shift] = uint8_t(mantissa >> (8 * (2 - i)));
        }
    }
}

// A hash wins if, read as a 256-bit big-endian number, it is below the target.
inline bool hash_below_target(const uint8_t raw_hash[32], const uint8_t target[32]) {
    for (int i = 0; i < 32; i++) {
        uint8_t hb = raw_hash[31 - i];
        uint8_t tb = target[i];
        if (hb < tb) return true;
        if (hb > tb) return false;
    }
    return false;  // exactly equal does not count as below
}

// The real Bitcoin genesis block, used as the base header for tests and benchmarks.
inline BlockHeader genesis_header() {
    BlockHeader h;
    memset(&h, 0, sizeof(h));
    h.version = 1;
    static const uint8_t merkle_internal[32] = {
        0x3b, 0xa3, 0xed, 0xfd, 0x7a, 0x7b, 0x12, 0xb2, 0x7a, 0xc7, 0x2c, 0x3e, 0x67, 0x76, 0x8f, 0x61,
        0x7f, 0xc8, 0x1b, 0xc3, 0x88, 0x8a, 0x51, 0x32, 0x3a, 0x9f, 0xb8, 0xaa, 0x4b, 0x1e, 0x5e, 0x4a};
    memcpy(h.merkle_root, merkle_internal, 32);
    h.time  = 1231006505;   // 2009-01-03 18:15:05 UTC
    h.bits  = 0x1d00ffff;
    h.nonce = 2083236893;   // the known winning nonce
    return h;
}

// Midstate for the optimized kernel: the SHA-256 state after block 1 (header
// bytes 0..63). The optimized kernel takes this precomputed on the PS instead of
// the full header, so the host computes it once per work unit. Same result as the
// kernel's sha256_midstate.
inline void compute_midstate(const uint8_t header[HEADER_BYTES], uint32_t midstate[8]) {
    static const uint32_t H0[8] = {
        0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
        0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19};
    for (int i = 0; i < 8; i++) midstate[i] = H0[i];
    sha256_compress(midstate, header);   // header[0..63] = block 1
}

// Software nonce scan over [start, end). Same loop as the baseline; used on the
// PS both to re-verify a found nonce and as the software speed baseline.
inline bool mine_range(BlockHeader header, const uint8_t target[32],
                       uint64_t start, uint64_t end,
                       uint32_t& found_nonce, uint64_t& hashes_done) {
    uint8_t block[HEADER_BYTES];
    uint8_t hash[32];
    hashes_done = 0;
    for (uint64_t n = start; n < end; n++) {
        header.nonce = uint32_t(n);
        serialize_header(header, block);
        sha256d(block, HEADER_BYTES, hash);
        hashes_done++;
        if (hash_below_target(hash, target)) {
            found_nonce = uint32_t(n);
            return true;
        }
    }
    return false;
}

#endif  // MINER_CORE_H
