// C++ testbench for the Bitcoin miner HLS kernel.
//
// Two checks:
//   Test 1 (hashing): read golden.dat, hash every header with sha256d_80(),
//       and compare against the golden hash. This verifies that the SHA-256
//       implementation still matches the software baseline.
//   Test 2 (search): preprocess the first header on the host side to produce
//       the midstate, invariant tail words, and target words, then pass those
//       values to mine() and confirm that the search finds nonce 8603.
//
// Vitis copies files listed as tb.file into the C simulation working folder,
// so golden.dat is opened by its plain name. main() returns non-zero on any
// failure, which is how C simulation reports PASS or FAIL.

#include <cstdint>
#include <cstdio>
#include <cstring>

#include "midstate_preprocess.hpp"

// Functions from mine.cpp. In HLS C simulation, the design file and this
// testbench are compiled together, so these declarations are sufficient.
void sha256d_80(const std::uint8_t header[80], std::uint8_t out[32]);

void mine(
    const std::uint32_t midstate_in[8],
    const std::uint32_t tail_words_in[3],
    const std::uint32_t target_words_in[8],
    std::uint32_t nonce_start,
    std::uint32_t nonce_count,
    std::uint32_t* found_nonce,
    int* found
);

// Convert a hexadecimal string into bytes.
// Returns the number of bytes written, or -1 if invalid hexadecimal is found.
static int hex_to_bytes(
    const char* hex,
    std::uint8_t* out,
    int max_bytes
) {
    int count = 0;

    while (
        count < max_bytes &&
        hex[2 * count] != '\0' &&
        hex[2 * count + 1] != '\0'
    ) {
        unsigned int value = 0;

        if (std::sscanf(hex + 2 * count, "%2x", &value) != 1) {
            return -1;
        }

        out[count] = static_cast<std::uint8_t>(value);
        ++count;
    }

    return count;
}

int main() {
    // ---------------------------------------------------------------------
    // Test 1: verify double SHA-256 results against golden.dat.
    // ---------------------------------------------------------------------
    FILE* fp = std::fopen("golden.dat", "r");

    if (fp == nullptr) {
        std::printf("ERROR: cannot open golden.dat\n");
        return 1;
    }

    char header_hex[256];
    char hash_hex[128];

    int lines = 0;
    int hash_mismatches = 0;

    std::uint8_t first_header[80] = {};
    bool have_first_header = false;

    // Each line has:
    //   <160 hexadecimal header characters>
    //   <64 hexadecimal displayed-hash characters>
    while (
        std::fscanf(fp, "%160s %64s", header_hex, hash_hex) == 2
    ) {
        std::uint8_t header[80] = {};
        std::uint8_t golden_hash[32] = {};

        const int header_bytes =
            hex_to_bytes(header_hex, header, 80);
        const int hash_bytes =
            hex_to_bytes(hash_hex, golden_hash, 32);

        if (header_bytes != 80 || hash_bytes != 32) {
            std::printf(
                "ERROR: malformed golden.dat entry on line %d\n",
                lines + 1
            );
            std::fclose(fp);
            return 1;
        }

        if (!have_first_header) {
            std::memcpy(first_header, header, sizeof(first_header));
            have_first_header = true;
        }

        std::uint8_t raw_hash[32] = {};
        sha256d_80(header, raw_hash);

        // golden_hash is stored in display order. The raw SHA-256 result is
        // compared in reverse byte order, matching the software baseline.
        bool matches = true;

        for (int i = 0; i < 32; ++i) {
            if (golden_hash[i] != raw_hash[31 - i]) {
                matches = false;
                break;
            }
        }

        if (!matches) {
            ++hash_mismatches;

            if (hash_mismatches <= 3) {
                std::printf(
                    "  hash mismatch on line %d\n",
                    lines + 1
                );
            }
        }

        ++lines;
    }

    std::fclose(fp);

    const bool test1_ok =
        lines > 0 &&
        hash_mismatches == 0;

    std::printf(
        "Test 1 (hashing): %d lines, %d mismatches -> %s\n",
        lines,
        hash_mismatches,
        test1_ok ? "PASS" : "FAIL"
    );

    if (!have_first_header) {
        std::printf("ERROR: golden.dat had no valid lines\n");
        return 1;
    }

    // ---------------------------------------------------------------------
    // Test 2: preprocess the mining job on the host side and verify search.
    // ---------------------------------------------------------------------
    //
    // Easy target: the two most significant bytes are zero and all remaining
    // bytes are 0xff. This matches "./miner demo 2", whose first valid nonce
    // is 8603.
    std::uint8_t target[32];
    std::memset(target, 0xff, sizeof(target));
    target[0] = 0x00;
    target[1] = 0x00;

    // Perform the work that is now assigned to the host:
    //   - compress header bytes 0..63 to generate the midstate;
    //   - convert header bytes 64..75 into three invariant words;
    //   - convert the target into eight big-endian words.
    const bitcoin_preprocess::JobInputs job =
        bitcoin_preprocess::prepare(first_header, target);

    std::uint32_t found_nonce = 0;
    int found = 0;

    // Searching 20,000 nonces is enough because the expected result is 8603.
    mine(
        job.midstate.data(),
        job.tail_words.data(),
        job.target_words.data(),
        0,
        20000,
        &found_nonce,
        &found
    );

    const bool test2_ok =
        found == 1 &&
        found_nonce == 8603;

    std::printf(
        "Test 2 (host-preprocessed search): found=%d nonce=%u -> %s\n",
        found,
        found_nonce,
        test2_ok ? "PASS" : "FAIL"
    );

    const bool failed =
        !test1_ok ||
        !test2_ok;

    std::printf("%s\n", failed ? "FAILED" : "ALL PASS");

    return failed ? 1 : 0;
}