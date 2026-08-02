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

uint32_t parse_u32(const char* text, const char* name) {
    char* end = nullptr;
    const unsigned long value = std::strtoul(text, &end, 0);

    if (end == text || *end != '\0' || value > UINT32_MAX) {
        throw std::invalid_argument(
            std::string("Invalid value for ") + name + ": " + text
        );
    }

    return static_cast<uint32_t>(value);
}

void print_usage(const char* program) {
    std::cerr
        << "Usage:\n"
        << "  " << program
        << " <mine.xclbin> <160-char-header-hex>"
        << " <64-char-target-hex> <nonce-start> <nonce-count>\n\n"
        << "Example:\n"
        << "  " << program
        << " mine.xclbin HEADER_HEX TARGET_HEX 0 20000\n";
}

} // namespace

int main(int argc, char* argv[]) {
    try {
        if (argc != 6) {
            print_usage(argv[0]);
            return EXIT_FAILURE;
        }

        const std::string xclbin_path = argv[1];
        const std::string header_hex = argv[2];
        const std::string target_hex = argv[3];

        const uint32_t nonce_start =
            parse_u32(argv[4], "nonce-start");

        const uint32_t nonce_count =
            parse_u32(argv[5], "nonce-count");

        /*
         * Convert the input strings into the exact formats expected by:
         *
         * void mine(
         *     const uint32_t header[20],
         *     const uint32_t target[8],
         *     uint32_t nonce_start,
         *     uint32_t nonce_count,
         *     uint32_t *found_nonce,
         *     int *found
         * );
         */
        const auto header_bytes =
            hex_to_bytes<HEADER_BYTES>(header_hex);

        const auto target_bytes =
            hex_to_bytes<TARGET_BYTES>(target_hex);

        const auto header_words =
            pack_bytes_to_words<HEADER_WORDS>(header_bytes);

        const auto target_words =
            pack_bytes_to_words<TARGET_WORDS>(target_bytes);

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
            << nonce_start << ", "
            << static_cast<uint64_t>(nonce_start) + nonce_count
            << ")...\n";

        auto run = kernel(
            header_bo,
            target_bo,
            nonce_start,
            nonce_count,
            found_nonce_bo,
            found_bo
        );

        run.wait();

        /*
         * Copy the two output buffers back to the processor.
         */
        found_nonce_bo.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
        found_bo.sync(XCL_BO_SYNC_BO_FROM_DEVICE);

        if (*found != 0) {
            std::cout
                << "Nonce found: "
                << *found_nonce_ptr
                << '\n';

            return EXIT_SUCCESS;
        }

        std::cout << "No valid nonce found in the requested range.\n";
        return EXIT_SUCCESS;

    } catch (const std::exception& error) {
        std::cerr << "ERROR: " << error.what() << '\n';
        return EXIT_FAILURE;
    }
}