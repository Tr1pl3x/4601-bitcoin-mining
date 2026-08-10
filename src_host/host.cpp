// host.cpp
//
// KV260 Bitcoin miner evaluation harness.
//
// Uses the SAME midstate_preprocess.hpp as the HLS C testbench.
//
// Usage:
//   ./mine_host <xclbin> [golden.dat] [hw_nonces] [hw_runs]
//               [sw_nonces] [sw_threads]
//
// Example:
//   ./mine_host bitcoin-miner.xclbin golden.dat 268435456 5 2000000 4
//
// Defaults:
//   golden.dat = golden.dat
//   hw_nonces  = 268435456   (2^28)
//   hw_runs     = 5
//   sw_nonces  = 2000000
//   sw_threads = 4
//
// Evaluation:
//   1. FPGA correctness test: expected nonce = 8603
//   2. FPGA throughput benchmark using all-zero target
//   3. ARM Cortex-A53 software SHA256d benchmark
//   4. Hardware/software speedup

#include <xrt/xrt_bo.h>
#include <xrt/xrt_device.h>
#include <xrt/xrt_kernel.h>

#include "midstate_preprocess.hpp"

#include <algorithm>
#include <array>
#include <atomic>
#include <cerrno>
#include <chrono>
#include <cctype>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <limits>
#include <stdexcept>
#include <string>
#include <string_view>
#include <thread>
#include <vector>

namespace {

// ============================================================================
// Configuration
// ============================================================================

constexpr std::uint32_t EXPECTED_NONCE = 8603U;
constexpr std::uint32_t CORRECTNESS_COUNT = 20000U;

constexpr std::uint32_t DEFAULT_HW_NONCES = 268435456U;  // 2^28
constexpr unsigned DEFAULT_HW_RUNS = 5U;

constexpr std::uint32_t DEFAULT_SW_NONCES = 2000000U;
constexpr unsigned DEFAULT_SW_THREADS = 4U;

// ============================================================================
// SHA-256 constants for ARM software benchmark
// ============================================================================

constexpr std::array<std::uint32_t, 64> K = {
    0x428a2f98U,0x71374491U,0xb5c0fbcfU,0xe9b5dba5U,
    0x3956c25bU,0x59f111f1U,0x923f82a4U,0xab1c5ed5U,
    0xd807aa98U,0x12835b01U,0x243185beU,0x550c7dc3U,
    0x72be5d74U,0x80deb1feU,0x9bdc06a7U,0xc19bf174U,
    0xe49b69c1U,0xefbe4786U,0x0fc19dc6U,0x240ca1ccU,
    0x2de92c6fU,0x4a7484aaU,0x5cb0a9dcU,0x76f988daU,
    0x983e5152U,0xa831c66dU,0xb00327c8U,0xbf597fc7U,
    0xc6e00bf3U,0xd5a79147U,0x06ca6351U,0x14292967U,
    0x27b70a85U,0x2e1b2138U,0x4d2c6dfcU,0x53380d13U,
    0x650a7354U,0x766a0abbU,0x81c2c92eU,0x92722c85U,
    0xa2bfe8a1U,0xa81a664bU,0xc24b8b70U,0xc76c51a3U,
    0xd192e819U,0xd6990624U,0xf40e3585U,0x106aa070U,
    0x19a4c116U,0x1e376c08U,0x2748774cU,0x34b0bcb5U,
    0x391c0cb3U,0x4ed8aa4U,0x5b9cca4fU,0x682e6ff3U,
    0x748f82eeU,0x78a5636fU,0x84c87814U,0x8cc70208U,
    0x90befffaU,0xa4506cebU,0xbef9a3f7U,0xc67178f2U
};

constexpr std::array<std::uint32_t, 8> H0 = {
    0x6a09e667U,
    0xbb67ae85U,
    0x3c6ef372U,
    0xa54ff53aU,
    0x510e527fU,
    0x9b05688cU,
    0x1f83d9abU,
    0x5be0cd19U
};

// ============================================================================
// Utility
// ============================================================================

std::uint32_t rotr(std::uint32_t x, unsigned n)
{
    return (x >> n) | (x << (32U - n));
}

std::uint32_t load_be32(const std::uint8_t* p)
{
    return
        (std::uint32_t(p[0]) << 24) |
        (std::uint32_t(p[1]) << 16) |
        (std::uint32_t(p[2]) << 8) |
        std::uint32_t(p[3]);
}

void store_be32(std::uint8_t* p, std::uint32_t x)
{
    p[0] = static_cast<std::uint8_t>(x >> 24);
    p[1] = static_cast<std::uint8_t>(x >> 16);
    p[2] = static_cast<std::uint8_t>(x >> 8);
    p[3] = static_cast<std::uint8_t>(x);
}

// Bitcoin header integer fields, including nonce, are serialized little-endian.
void store_le32(std::uint8_t* p, std::uint32_t x)
{
    p[0] = static_cast<std::uint8_t>(x);
    p[1] = static_cast<std::uint8_t>(x >> 8);
    p[2] = static_cast<std::uint8_t>(x >> 16);
    p[3] = static_cast<std::uint8_t>(x >> 24);
}

int hexv(char c)
{
    if (c >= '0' && c <= '9')
        return c - '0';

    if (c >= 'a' && c <= 'f')
        return c - 'a' + 10;

    if (c >= 'A' && c <= 'F')
        return c - 'A' + 10;

    if (std::isspace(static_cast<unsigned char>(c)))
        return -2;

    return -1;
}

template <std::size_t N>
std::array<std::uint8_t, N> parse_hex(std::string_view text)
{
    std::string s;

    for (char c : text) {
        const int v = hexv(c);

        if (v == -2)
            continue;

        if (v < 0)
            throw std::invalid_argument("invalid hexadecimal input");

        s.push_back(c);
    }

    if (s.size() != N * 2U)
        throw std::invalid_argument("incorrect hexadecimal length");

    std::array<std::uint8_t, N> out{};

    for (std::size_t i = 0; i < N; ++i) {
        out[i] = static_cast<std::uint8_t>(
            (hexv(s[2 * i]) << 4) |
            hexv(s[2 * i + 1])
        );
    }

    return out;
}

std::uint32_t parse_u32(const char* text)
{
    char* end = nullptr;
    errno = 0;

    const unsigned long long value =
        std::strtoull(text, &end, 0);

    if (errno ||
        end == text ||
        *end != '\0' ||
        value > std::numeric_limits<std::uint32_t>::max()) {
        throw std::invalid_argument("invalid 32-bit integer");
    }

    return static_cast<std::uint32_t>(value);
}

unsigned parse_positive_unsigned(const char* text)
{
    const std::uint32_t value = parse_u32(text);

    if (value == 0)
        throw std::invalid_argument("value must be greater than zero");

    return static_cast<unsigned>(value);
}

double median(std::vector<double> values)
{
    if (values.empty())
        throw std::runtime_error("cannot calculate median");

    std::sort(values.begin(), values.end());

    const std::size_t n = values.size();

    if (n % 2U)
        return values[n / 2U];

    return (values[n / 2U - 1U] + values[n / 2U]) / 2.0;
}

// ============================================================================
// Read the first header from golden.dat
// ============================================================================

std::array<std::uint8_t, 80>
read_first_header(const std::string& filename)
{
    std::ifstream file(filename);

    if (!file)
        throw std::runtime_error(
            "could not open " + filename
        );

    std::string header_hex;
    std::string hash_hex;

    if (!(file >> header_hex >> hash_hex))
        throw std::runtime_error(
            filename + " contains no valid entries"
        );

    return parse_hex<80>(header_hex);
}

void print_header(
    const std::array<std::uint8_t, 80>& header,
    const std::string& filename
)
{
    std::cout
        << "Loaded header from "
        << filename
        << ":\n";

    for (const std::uint8_t b : header) {
        std::cout
            << std::hex
            << std::setw(2)
            << std::setfill('0')
            << static_cast<unsigned>(b);
    }

    std::cout
        << std::dec
        << std::setfill(' ')
        << "\n";
}

// ============================================================================
// ARM SHA-256 implementation
// ============================================================================

void sha256_compress_sw(
    std::array<std::uint32_t, 8>& state,
    const std::uint8_t block[64]
)
{
    std::array<std::uint32_t, 64> w{};

    for (int i = 0; i < 16; ++i)
        w[i] = load_be32(block + 4 * i);

    for (int i = 16; i < 64; ++i) {
        const std::uint32_t x = w[i - 15];
        const std::uint32_t y = w[i - 2];

        const std::uint32_t s0 =
            rotr(x, 7) ^
            rotr(x, 18) ^
            (x >> 3);

        const std::uint32_t s1 =
            rotr(y, 17) ^
            rotr(y, 19) ^
            (y >> 10);

        w[i] =
            w[i - 16] +
            s0 +
            w[i - 7] +
            s1;
    }

    std::uint32_t a = state[0];
    std::uint32_t b = state[1];
    std::uint32_t c = state[2];
    std::uint32_t d = state[3];
    std::uint32_t e = state[4];
    std::uint32_t f = state[5];
    std::uint32_t g = state[6];
    std::uint32_t h = state[7];

    for (int i = 0; i < 64; ++i) {
        const std::uint32_t S1 =
            rotr(e, 6) ^
            rotr(e, 11) ^
            rotr(e, 25);

        const std::uint32_t ch =
            (e & f) ^
            (~e & g);

        const std::uint32_t t1 =
            h + S1 + ch + K[i] + w[i];

        const std::uint32_t S0 =
            rotr(a, 2) ^
            rotr(a, 13) ^
            rotr(a, 22);

        const std::uint32_t maj =
            (a & b) ^
            (a & c) ^
            (b & c);

        const std::uint32_t t2 =
            S0 + maj;

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

void sha256d_80_sw(
    const std::uint8_t header[80],
    std::uint8_t output[32]
)
{
    // First SHA-256, block 1.
    std::array<std::uint32_t, 8> state = H0;

    std::array<std::uint8_t, 64> block{};

    std::memcpy(
        block.data(),
        header,
        64
    );

    sha256_compress_sw(
        state,
        block.data()
    );

    // First SHA-256, block 2.
    block.fill(0);

    std::memcpy(
        block.data(),
        header + 64,
        16
    );

    block[16] = 0x80;

    // 80 bytes = 640 bits = 0x280.
    block[62] = 0x02;
    block[63] = 0x80;

    sha256_compress_sw(
        state,
        block.data()
    );

    std::array<std::uint8_t, 32> first_hash{};

    for (int i = 0; i < 8; ++i) {
        store_be32(
            first_hash.data() + 4 * i,
            state[i]
        );
    }

    // Second SHA-256.
    state = H0;
    block.fill(0);

    std::memcpy(
        block.data(),
        first_hash.data(),
        first_hash.size()
    );

    block[32] = 0x80;

    // 32 bytes = 256 bits.
    block[62] = 0x01;
    block[63] = 0x00;

    sha256_compress_sw(
        state,
        block.data()
    );

    for (int i = 0; i < 8; ++i) {
        store_be32(
            output + 4 * i,
            state[i]
        );
    }
}

// ============================================================================
// ARM software throughput benchmark
// ============================================================================

struct SoftwareResult {
    double seconds = 0.0;
    double rate_mhs = 0.0;
    std::uint64_t checksum = 0;
};

SoftwareResult benchmark_software(
    const std::array<std::uint8_t, 80>& base_header,
    std::uint32_t nonce_start,
    std::uint32_t nonce_count,
    unsigned thread_count
)
{
    if (thread_count == 0)
        throw std::invalid_argument(
            "software thread count must be > 0"
        );

    std::atomic<std::uint64_t> checksum{0};

    std::vector<std::thread> workers;
    workers.reserve(thread_count);

    const auto start =
        std::chrono::steady_clock::now();

    for (unsigned t = 0; t < thread_count; ++t) {
        const std::uint64_t begin =
            (std::uint64_t(nonce_count) * t) /
            thread_count;

        const std::uint64_t end =
            (std::uint64_t(nonce_count) * (t + 1U)) /
            thread_count;

        workers.emplace_back(
            [&, begin, end]() {
                auto header = base_header;

                std::array<std::uint8_t, 32> hash{};

                std::uint64_t local_checksum = 0;

                for (std::uint64_t i = begin; i < end; ++i) {
                    const std::uint32_t nonce =
                        nonce_start +
                        static_cast<std::uint32_t>(i);

                    store_le32(
                        header.data() + 76,
                        nonce
                    );

                    sha256d_80_sw(
                        header.data(),
                        hash.data()
                    );

                    // Prevent the compiler from optimizing the hashes away.
                    local_checksum +=
                        std::uint64_t(hash[0]) |
                        (std::uint64_t(hash[1]) << 8) |
                        (std::uint64_t(hash[2]) << 16) |
                        (std::uint64_t(hash[3]) << 24);
                }

                checksum.fetch_add(
                    local_checksum,
                    std::memory_order_relaxed
                );
            }
        );
    }

    for (auto& worker : workers)
        worker.join();

    const auto end =
        std::chrono::steady_clock::now();

    const double seconds =
        std::chrono::duration<double>(
            end - start
        ).count();

    SoftwareResult result;
    result.seconds = seconds;
    result.rate_mhs =
        static_cast<double>(nonce_count) /
        seconds /
        1.0e6;

    result.checksum =
        checksum.load(
            std::memory_order_relaxed
        );

    return result;
}

// ============================================================================
// XRT buffers
// ============================================================================

struct DeviceBuffers {
    xrt::bo mid;
    xrt::bo tail;
    xrt::bo target;
    xrt::bo nonce;
    xrt::bo found;
};

void upload_job(
    DeviceBuffers& buffers,
    const bitcoin_preprocess::JobInputs& job
)
{
    std::memcpy(
        buffers.mid.map<std::uint32_t*>(),
        job.midstate.data(),
        sizeof(job.midstate)
    );

    std::memcpy(
        buffers.tail.map<std::uint32_t*>(),
        job.tail_words.data(),
        sizeof(job.tail_words)
    );

    std::memcpy(
        buffers.target.map<std::uint32_t*>(),
        job.target_words.data(),
        sizeof(job.target_words)
    );

    buffers.mid.sync(
        XCL_BO_SYNC_BO_TO_DEVICE
    );

    buffers.tail.sync(
        XCL_BO_SYNC_BO_TO_DEVICE
    );

    buffers.target.sync(
        XCL_BO_SYNC_BO_TO_DEVICE
    );
}

void reset_outputs(DeviceBuffers& buffers)
{
    *buffers.nonce.map<std::uint32_t*>() = 0U;
    *buffers.found.map<std::int32_t*>() = 0;

    buffers.nonce.sync(
        XCL_BO_SYNC_BO_TO_DEVICE
    );

    buffers.found.sync(
        XCL_BO_SYNC_BO_TO_DEVICE
    );
}

struct HardwareRun {
    double kernel_seconds = 0.0;
    double total_seconds = 0.0;

    std::int32_t found = 0;
    std::uint32_t found_nonce = 0;
};

HardwareRun run_hardware(
    xrt::kernel& kernel,
    DeviceBuffers& buffers,
    std::uint32_t nonce_start,
    std::uint32_t nonce_count
)
{
    reset_outputs(buffers);

    const auto total_start =
        std::chrono::steady_clock::now();

    const auto kernel_start =
        std::chrono::steady_clock::now();

    auto run = kernel(
        buffers.mid,
        buffers.tail,
        buffers.target,
        nonce_start,
        nonce_count,
        buffers.nonce,
        buffers.found
    );

    run.wait();

    const auto kernel_end =
        std::chrono::steady_clock::now();

    buffers.nonce.sync(
        XCL_BO_SYNC_BO_FROM_DEVICE
    );

    buffers.found.sync(
        XCL_BO_SYNC_BO_FROM_DEVICE
    );

    const auto total_end =
        std::chrono::steady_clock::now();

    HardwareRun result;

    result.kernel_seconds =
        std::chrono::duration<double>(
            kernel_end - kernel_start
        ).count();

    result.total_seconds =
        std::chrono::duration<double>(
            total_end - total_start
        ).count();

    result.found =
        *buffers.found.map<std::int32_t*>();

    result.found_nonce =
        *buffers.nonce.map<std::uint32_t*>();

    return result;
}

void print_job(
    const bitcoin_preprocess::JobInputs& job
)
{
    std::cout << "  midstate:";

    for (const auto value : job.midstate) {
        std::cout
            << " "
            << std::hex
            << std::setw(8)
            << std::setfill('0')
            << value;
    }

    std::cout
        << std::dec
        << std::setfill(' ')
        << "\n";

    std::cout << "  tail:";

    for (const auto value : job.tail_words) {
        std::cout
            << " "
            << std::hex
            << std::setw(8)
            << std::setfill('0')
            << value;
    }

    std::cout
        << std::dec
        << std::setfill(' ')
        << "\n";

    std::cout << "  target:";

    for (const auto value : job.target_words) {
        std::cout
            << " "
            << std::hex
            << std::setw(8)
            << std::setfill('0')
            << value;
    }

    std::cout
        << std::dec
        << std::setfill(' ')
        << "\n";
}

} // namespace

// ============================================================================
// Main
// ============================================================================

int main(int argc, char** argv)
{
    try {
        if (argc < 2 || argc > 7) {
            std::cerr
                << "Usage:\n  "
                << argv[0]
                << " <kernel.xclbin>"
                << " [golden.dat]"
                << " [hw_nonces]"
                << " [hw_runs]"
                << " [sw_nonces]"
                << " [sw_threads]\n";

            return 1;
        }

        const std::string xclbin_path =
            argv[1];

        const std::string golden_path =
            (argc >= 3)
                ? argv[2]
                : "golden.dat";

        const std::uint32_t hw_nonce_count =
            (argc >= 4)
                ? parse_u32(argv[3])
                : DEFAULT_HW_NONCES;

        const unsigned hw_runs =
            (argc >= 5)
                ? parse_positive_unsigned(argv[4])
                : DEFAULT_HW_RUNS;

        const std::uint32_t sw_nonce_count =
            (argc >= 6)
                ? parse_u32(argv[5])
                : DEFAULT_SW_NONCES;

        const unsigned sw_threads =
            (argc >= 7)
                ? parse_positive_unsigned(argv[6])
                : DEFAULT_SW_THREADS;

        if (hw_nonce_count == 0)
            throw std::invalid_argument(
                "hw_nonces must be > 0"
            );

        if (sw_nonce_count == 0)
            throw std::invalid_argument(
                "sw_nonces must be > 0"
            );

        // ====================================================================
        // Read test header.
        // ====================================================================

        const auto header =
            read_first_header(golden_path);

        print_header(
            header,
            golden_path
        );

        // ====================================================================
        // Targets
        // ====================================================================

        // Same easy target as the HLS testbench:
        //
        //   00 00 ff ff ff ff ...
        //
        std::array<std::uint8_t, 32> easy_target{};
        easy_target.fill(0xff);
        easy_target[0] = 0x00;
        easy_target[1] = 0x00;

        // Impossible target for benchmarking.
        //
        // This forces the kernel to process the complete nonce range.
        std::array<std::uint8_t, 32> benchmark_target{};
        benchmark_target.fill(0x00);

        // IMPORTANT:
        // Use exactly the same preprocessing implementation as HLS C simulation.
        const bitcoin_preprocess::JobInputs easy_job =
            bitcoin_preprocess::prepare(
                header.data(),
                easy_target.data()
            );

        const bitcoin_preprocess::JobInputs benchmark_job =
            bitcoin_preprocess::prepare(
                header.data(),
                benchmark_target.data()
            );

        // ====================================================================
        // XRT setup
        // ====================================================================

        std::cout
            << "Loading XCLBIN and creating kernel..."
            << std::endl;

        xrt::device device{0};

        const auto uuid =
            device.load_xclbin(
                xclbin_path
            );

        xrt::kernel kernel{
            device,
            uuid,
            "mine"
        };

        DeviceBuffers buffers{
            xrt::bo{
                device,
                sizeof(easy_job.midstate),
                kernel.group_id(0)
            },

            xrt::bo{
                device,
                sizeof(easy_job.tail_words),
                kernel.group_id(1)
            },

            xrt::bo{
                device,
                sizeof(easy_job.target_words),
                kernel.group_id(2)
            },

            xrt::bo{
                device,
                sizeof(std::uint32_t),
                kernel.group_id(5)
            },

            xrt::bo{
                device,
                sizeof(std::int32_t),
                kernel.group_id(6)
            }
        };

        // ====================================================================
        // 1. FPGA correctness test
        // ====================================================================

        std::cout
            << "Running FPGA correctness test..."
            << std::endl;

        upload_job(
            buffers,
            easy_job
        );

        print_job(easy_job);

        const HardwareRun correctness =
            run_hardware(
                kernel,
                buffers,
                0U,
                CORRECTNESS_COUNT
            );

        const bool correctness_pass =
            correctness.found == 1 &&
            correctness.found_nonce == EXPECTED_NONCE;

        std::cout
            << "  Kernel returned: found="
            << correctness.found
            << " nonce="
            << correctness.found_nonce
            << " time="
            << std::fixed
            << std::setprecision(6)
            << correctness.kernel_seconds
            << " s\n";

        std::cout
            << "Correctness (easy target): "
            << "found="
            << correctness.found
            << " nonce="
            << correctness.found_nonce
            << " (expect "
            << EXPECTED_NONCE
            << ") -> "
            << (correctness_pass ? "PASS" : "FAIL")
            << std::endl;

        if (!correctness_pass) {
            std::cout
                << "---------------------------------------------\n"
                << "TEST FAILED\n";

            return 1;
        }

        // ====================================================================
        // 2. FPGA benchmark
        // ====================================================================

        std::cout
            << "\nRunning FPGA benchmark..."
            << std::endl;

        upload_job(
            buffers,
            benchmark_job
        );

        std::vector<double> kernel_times;
        std::vector<double> total_times;

        kernel_times.reserve(hw_runs);
        total_times.reserve(hw_runs);

        bool hardware_ok = true;

        for (unsigned run_index = 0;
             run_index < hw_runs;
             ++run_index) {

            std::cout
                << "  FPGA run "
                << (run_index + 1U)
                << "/"
                << hw_runs
                << "..."
                << std::flush;

            const HardwareRun result =
                run_hardware(
                    kernel,
                    buffers,
                    0U,
                    hw_nonce_count
                );

            std::cout
                << " "
                << std::fixed
                << std::setprecision(6)
                << result.kernel_seconds
                << " s"
                << std::endl;

            kernel_times.push_back(
                result.kernel_seconds
            );

            total_times.push_back(
                result.total_seconds
            );

            // All-zero target must never produce a valid nonce.
            if (result.found != 0)
                hardware_ok = false;
        }

        const double median_kernel =
            median(kernel_times);

        const double median_total =
            median(total_times);

        const double hardware_rate_mhs =
            static_cast<double>(hw_nonce_count) /
            median_kernel /
            1.0e6;

        // ====================================================================
        // 3. ARM software benchmark
        // ====================================================================

        std::cout
            << "\nRunning ARM PS software benchmark ("
            << sw_threads
            << " threads, "
            << sw_nonce_count
            << " nonces)..."
            << std::endl;

        // Small warm-up so CPU frequency scaling / cache initialization
        // is less likely to distort the measured run.
        const std::uint32_t warmup_count =
            std::min<std::uint32_t>(
                sw_nonce_count,
                4096U
            );

        (void)benchmark_software(
            header,
            0U,
            warmup_count,
            sw_threads
        );

        const SoftwareResult software =
            benchmark_software(
                header,
                0U,
                sw_nonce_count,
                sw_threads
            );

        // ====================================================================
        // 4. Summary
        // ====================================================================

        const double speedup =
            hardware_rate_mhs /
            software.rate_mhs;

        std::cout
            << "\n=============================================\n";

        std::cout
            << "PL HARDWARE (optimized kernel @ 200 MHz)\n";

        std::cout
            << "  nonces/run   : "
            << hw_nonce_count
            << "\n";

        std::cout
            << "  runs         : "
            << hw_runs
            << "\n";

        std::cout
            << std::fixed
            << std::setprecision(6);

        std::cout
            << "  median kernel: "
            << median_kernel
            << " s\n";

        std::cout
            << "  median total : "
            << median_total
            << " s\n";

        std::cout
            << std::setprecision(3);

        std::cout
            << "  hash rate    : "
            << hardware_rate_mhs
            << " MH/s\n";

        std::cout
            << "\nARM PS SOFTWARE ("
            << sw_threads
            << "-threaded SHA256d)\n";

        std::cout
            << "  nonces       : "
            << sw_nonce_count
            << "\n";

        std::cout
            << std::setprecision(6);

        std::cout
            << "  time         : "
            << software.seconds
            << " s\n";

        std::cout
            << std::setprecision(3);

        std::cout
            << "  hash rate    : "
            << software.rate_mhs
            << " MH/s\n";

        // Print checksum so it is clear that the software benchmark
        // actually consumed all hash outputs.
        std::cout
            << "  checksum     : 0x"
            << std::hex
            << software.checksum
            << std::dec
            << "\n";

        std::cout
            << "\nSPEEDUP hardware / software : "
            << std::fixed
            << std::setprecision(2)
            << speedup
            << "x\n";

        std::cout
            << "=============================================\n";

        const bool passed =
            correctness_pass &&
            hardware_ok;

        std::cout
            << (passed ?
                    "TEST PASSED" :
                    "TEST FAILED")
            << std::endl;

        return passed ? 0 : 1;
    }
    catch (const std::exception& e) {
        std::cerr
            << "Error: "
            << e.what()
            << std::endl;

        return 1;
    }
}
