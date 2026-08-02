#include <array>
#include <cstdint>
#include <cstdlib>
#include <exception>
#include <iostream>
#include <stdexcept>
#include <string>

#include <xrt/xrt_bo.h>
#include <xrt/xrt_device.h>
#include <xrt/xrt_kernel.h>
#include <chrono>
#include <fstream>

namespace {

constexpr std::size_t HEADER_BYTES = 80;
constexpr std::size_t HEADER_WORDS = 20;
constexpr std::size_t TARGET_BYTES = 32;
constexpr std::size_t TARGET_WORDS = 8;

uint8_t hex_digit(char c) {
    if (c >= '0' && c <= '9') {
        return static_cast<uint8_t>(c - '0');
    }

    if (c >= 'a' && c <= 'f') {
        return static_cast<uint8_t>(c - 'a' + 10);
    }

    if (c >= 'A' && c <= 'F') {
        return static_cast<uint8_t>(c - 'A' + 10);
    }

    throw std::invalid_argument("Invalid hexadecimal character");
}

template <std::size_t N>
std::array<uint8_t, N> hex_to_bytes(const std::string& hex) {
    if (hex.size() != N * 2) {
        throw std::invalid_argument(
            "Expected " + std::to_string(N * 2) +
            " hexadecimal characters, but received " +
            std::to_string(hex.size())
        );
    }

    std::array<uint8_t, N> bytes{};

    for (std::size_t i = 0; i < N; ++i) {
        const uint8_t high = hex_digit(hex[i * 2]);
        const uint8_t low = hex_digit(hex[i * 2 + 1]);

        bytes[i] = static_cast<uint8_t>((high << 4) | low);
    }

    return bytes;
}

template <std::size_t WordCount>
std::array<uint32_t, WordCount> pack_bytes_to_words(
    const std::array<uint8_t, WordCount * 4>& bytes
) {
    std::array<uint32_t, WordCount> words{};

    for (std::size_t i = 0; i < WordCount; ++i) {
        words[i] =
            static_cast<uint32_t>(bytes[i * 4]) |
            (static_cast<uint32_t>(bytes[i * 4 + 1]) << 8) |
            (static_cast<uint32_t>(bytes[i * 4 + 2]) << 16) |
            (static_cast<uint32_t>(bytes[i * 4 + 3]) << 24);
    }

    return words;
}



std::array<uint32_t, HEADER_WORDS> read_first_header(
    const std::string& golden_path
) {
    std::ifstream golden_file(golden_path);

    if (!golden_file) {
        throw std::runtime_error(
            "Could not open golden data file: " + golden_path
        );
    }

    std::string header_hex;
    std::string expected_hash_hex;

    /*
     * Each line of golden.dat contains:
     *
     * <160-character header> <64-character expected hash>
     *
     * We only need the first header here.
     */
    if (!(golden_file >> header_hex >> expected_hash_hex)) {
        throw std::runtime_error(
            "golden.dat does not contain a valid header/hash line"
        );
    }

    const auto header_bytes =
        hex_to_bytes<HEADER_BYTES>(header_hex);

    return pack_bytes_to_words<HEADER_WORDS>(header_bytes);
}

std::array<uint32_t, TARGET_WORDS> make_easy_target() {
    std::array<uint8_t, TARGET_BYTES> target_bytes{};

    target_bytes.fill(0xff);

    target_bytes[0] = 0x00;
    target_bytes[1] = 0x00;

    return pack_bytes_to_words<TARGET_WORDS>(target_bytes);
}


void print_usage(const char* program) {
    std::cerr
        << "Usage:\n"
        << "  " << program
        << " <mine.xclbin> <golden.dat>\n\n"
        << "Example:\n"
        << "  " << program
        << " binary_container_1.xclbin golden.dat\n";
}

} // namespace

int main(int argc, char* argv[]) {
     try {
        if (argc != 3) {
            print_usage(argv[0]);
            return EXIT_FAILURE;
        }

        const std::string xclbin_path = argv[1];
        const std::string golden_path = argv[2];

        constexpr uint32_t nonce_start = 0;
        constexpr uint32_t nonce_count = 20000;
        constexpr uint32_t expected_nonce = 8603;

        const auto header_words =
            read_first_header(golden_path);

        const auto target_words =
            make_easy_target();

            std::cout << "Opening FPGA device 0...\n";
            xrt::device device{0};

            std::cout << "Loading " << xclbin_path << "...\n";
            const auto uuid = device.load_xclbin(xclbin_path);

            /*
            * The name must match the HLS top-function name.
            */
            xrt::kernel kernel{device, uuid, "mine"};

            /*
            * Kernel argument positions:
            *
            * 0: header
            * 1: target
            * 2: nonce_start
            * 3: nonce_count
            * 4: found_nonce
            * 5: found
            */
            xrt::bo header_bo{
                device,
                sizeof(uint32_t) * HEADER_WORDS,
                kernel.group_id(0)
            };

            xrt::bo target_bo{
                device,
                sizeof(uint32_t) * TARGET_WORDS,
                kernel.group_id(1)
            };

            xrt::bo found_nonce_bo{
                device,
                sizeof(uint32_t),
                kernel.group_id(4)
            };

            xrt::bo found_bo{
                device,
                sizeof(int),
                kernel.group_id(5)
            };

            auto* header_ptr = header_bo.map<uint32_t*>();
            auto* target_ptr = target_bo.map<uint32_t*>();
            auto* found_nonce_ptr = found_nonce_bo.map<uint32_t*>();
            auto* found_ptr = found_bo.map<int*>();

            for (std::size_t i = 0; i < HEADER_WORDS; ++i) {
                header_ptr[i] = header_words[i];
            }

            for (std::size_t i = 0; i < TARGET_WORDS; ++i) {
                target_ptr[i] = target_words[i];
            }

            *found_nonce_ptr = 0;
            *found_ptr = 0;

            /*
            * Copy only the input buffers to the FPGA before execution.
            */
            header_bo.sync(XCL_BO_SYNC_BO_TO_DEVICE);
            target_bo.sync(XCL_BO_SYNC_BO_TO_DEVICE);

                    std::cout
                << "Searching nonce range ["
                << nonce_start
                << ", "
                << static_cast<uint64_t>(nonce_start) + nonce_count
                << ")...\n";

            const auto kernel_start = std::chrono::steady_clock::now();

            auto run = kernel(
                header_bo,
                target_bo,
                nonce_start,
                nonce_count,
                found_nonce_bo,
                found_bo
            );

            run.wait();

            const auto kernel_end = std::chrono::steady_clock::now();

            // These transfers are outside the measured kernel time.
            found_nonce_bo.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
            found_bo.sync(XCL_BO_SYNC_BO_FROM_DEVICE);

            const double kernel_seconds =
                std::chrono::duration<double>(
                    kernel_end - kernel_start
                ).count();

            uint64_t nonces_tested = nonce_count;

            if (*found_ptr != 0) {
                nonces_tested =
                    static_cast<uint64_t>(*found_nonce_ptr) -
                    static_cast<uint64_t>(nonce_start) +
                    1;
            }

            const double hashes_per_second =
                kernel_seconds > 0.0
                    ? static_cast<double>(nonces_tested) / kernel_seconds
                    : 0.0;

            const double mega_hashes_per_second =
                hashes_per_second / 1.0e6;

        std::cout << "\n=====================================\n";
        std::cout << "      Bitcoin Miner Results\n";
        std::cout << "=====================================\n";

        std::cout
            << "Found           : "
            << *found_ptr
            << '\n';

        std::cout
            << "Nonce           : "
            << *found_nonce_ptr
            << '\n';

        std::cout
            << "Expected Nonce  : "
            << expected_nonce
            << '\n';

        std::cout
            << "Nonces Tested   : "
            << nonces_tested
            << '\n';

        std::cout
            << "Kernel Time     : "
            << kernel_seconds * 1000.0
            << " ms\n";

        std::cout
            << "Throughput      : "
            << mega_hashes_per_second
            << " MH/s\n";

            const bool passed =
        (*found_ptr == 1) &&
        (*found_nonce_ptr == expected_nonce);

        if (passed) {
            std::cout
                << "PASS: FPGA found the expected nonce "
                << expected_nonce
                << '\n';

            return EXIT_SUCCESS;
        }

        std::cout
            << "FAIL: expected found=1 and nonce="
            << expected_nonce
            << ", but received found="
            << *found_ptr
            << " and nonce="
            << *found_nonce_ptr
            << '\n';

    return EXIT_FAILURE;


    } catch (const std::exception& error) {
            std::cerr << "ERROR: " << error.what() << '\n';
        return EXIT_FAILURE;
    }
}
