// C testbench for the miner HLS kernel.
//
// Two checks:
//   Test 1 (hashing): read golden.dat, and for each header compute the midstate
//       and tail (this testbench plays the host, STEP 4), hash via the kernel's
//       sha256d_from_midstate, and compare to the golden hash.
//   Test 2 (search): give the kernel an easy target (the same one as
//       "./miner demo 2") and confirm its nonce search finds nonce 8603.
//
// Vitis copies files listed as tb.file into the C simulation working folder,
// so golden.dat is opened by its plain name. main() returns non-zero on any
// failure, which is how C simulation reports PASS or FAIL.

#include <stdio.h>
#include <stdint.h>
#include <string.h>

// Functions from mine.cpp. In HLS C simulation the design file and this
// testbench are compiled together, so these declarations are enough.
void sha256_midstate(const uint8_t header[80], uint32_t midstate[8]);
void sha256d_from_midstate(const uint32_t midstate[8], const uint8_t tail[12],
                           uint32_t nonce, uint8_t out[32]);
void mine(const uint32_t midstate[8], const uint8_t tail[12],
          const uint8_t target[32], uint32_t nonce_start, uint32_t nonce_count,
          uint32_t *found_nonce, int *found);

// Turn a hex string into bytes. Returns how many bytes were written.
static int hex_to_bytes(const char *hex, uint8_t *out, int max_bytes) {
    int n = 0;
    while (n < max_bytes && hex[2 * n] && hex[2 * n + 1]) {
        unsigned v;
        sscanf(hex + 2 * n, "%2x", &v);
        out[n] = (uint8_t)v;
        n++;
    }
    return n;
}

int main() {
    // ---------- Test 1: hashing against golden.dat ----------
    FILE *fp = fopen("golden.dat", "r");
    if (!fp) {
        printf("ERROR: cannot open golden.dat\n");
        return 1;
    }

    char hdr_hex[256];
    char hash_hex[128];
    int lines = 0;
    int hash_mismatches = 0;
    uint8_t first_header[80];
    int have_first = 0;

    // Each line: <160 hex chars header> <64 hex chars hash>
    while (fscanf(fp, "%160s %64s", hdr_hex, hash_hex) == 2) {
        uint8_t hdr[80];
        uint8_t gold[32];
        hex_to_bytes(hdr_hex, hdr, 80);
        hex_to_bytes(hash_hex, gold, 32);

        if (!have_first) {
            memcpy(first_header, hdr, 80);
            have_first = 1;
        }

        // STEP 4: the host (this testbench) computes the midstate, and pulls the
        // 12 tail bytes and the nonce out of the header, exactly like the board
        // host will. Then it calls the kernel's from-midstate path.
        uint32_t ms[8];
        sha256_midstate(hdr, ms);
        uint8_t tail[12];
        for (int i = 0; i < 12; i++) tail[i] = hdr[64 + i];
        uint32_t nonce = (uint32_t)hdr[76] | ((uint32_t)hdr[77] << 8) |
                         ((uint32_t)hdr[78] << 16) | ((uint32_t)hdr[79] << 24);
        uint8_t raw[32];
        sha256d_from_midstate(ms, tail, nonce, raw);

        // The golden hash is in display order, which is the raw hash reversed.
        // So gold[i] must equal raw[31 - i].
        int ok = 1;
        for (int i = 0; i < 32; i++) {
            if (gold[i] != raw[31 - i]) { ok = 0; break; }
        }
        if (!ok) {
            hash_mismatches++;
            if (hash_mismatches <= 3) printf("  hash mismatch on line %d\n", lines);
        }
        lines++;
    }
    fclose(fp);

    int test1_ok = (lines > 0 && hash_mismatches == 0);
    printf("Test 1 (hashing): %d lines, %d mismatches -> %s\n",
           lines, hash_mismatches, test1_ok ? "PASS" : "FAIL");

    if (!have_first) {
        printf("ERROR: golden.dat had no lines\n");
        return 1;
    }

    // ---------- Test 2: the search finds the demo nonce ----------
    // Easy target: the top two bytes must be zero, everything else 0xff.
    // This is exactly what "./miner demo 2" uses, and it finds nonce 8603.
    uint8_t target[32];
    memset(target, 0xff, 32);
    target[0] = 0x00;
    target[1] = 0x00;

    // STEP 4: compute the midstate and tail from the first header (host role),
    // then hand them to the kernel. first_header's own nonce field is ignored;
    // mine() sweeps its own nonces.
    uint32_t ms0[8];
    sha256_midstate(first_header, ms0);
    uint8_t tail0[12];
    for (int i = 0; i < 12; i++) tail0[i] = first_header[64 + i];

    uint32_t found_nonce = 0;
    int found = 0;
    // Searching from nonce 0 reproduces the demo; 20000 covers it (8603 < 20000).
    mine(ms0, tail0, target, 0, 20000, &found_nonce, &found);

    int test2_ok = (found == 1 && found_nonce == 8603);
    printf("Test 2 (search): found=%d nonce=%u -> %s\n",
           found, found_nonce, test2_ok ? "PASS" : "FAIL");

    int failed = (!test1_ok) || (!test2_ok);
    printf("%s\n", failed ? "FAILED" : "ALL PASS");
    return failed;
}
