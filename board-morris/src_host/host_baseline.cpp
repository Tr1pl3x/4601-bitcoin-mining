// Host program for the BASELINE miner kernel on the Kria KV260.
//
// The baseline kernel takes the full 80-byte header. This host:
//   1. correctness: easy target (top two bytes zero) must find nonce 8603,
//      re-hashed on the PS to confirm it is below target;
//   2. hardware hash rate: all-zero target (never wins), one big sweep, median;
//   3. software baseline: the same scan on the ARM PS across 4 threads.
//
//   ./mine_host -x <xclbin> [-d <device>] [-n <bench nonce count>]
//
// Kernel: mine(uint8_t header[80], uint8_t target[32], uint32_t start,
//              uint32_t count, uint32_t* found_nonce, int* found)
//   group_ids: header=0, target=1, found_nonce=4, found=5.

#include <iostream>
#include <cstring>
#include <cstdint>
#include <cstdlib>
#include <chrono>
#include <algorithm>
#include <vector>
#include <thread>
#include <string>

#include "xrt/xrt_bo.h"
#include "xrt/xrt_device.h"
#include "xrt/xrt_kernel.h"

#include "sha256.h"
#include "miner_core.h"

static double median(std::vector<double> v) {
    std::sort(v.begin(), v.end());
    return v[v.size() / 2];
}

static double sw_bench(const BlockHeader& base, const uint8_t target[32],
                       uint64_t count, int nthreads) {
    std::vector<std::thread> pool;
    auto t0 = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < nthreads; i++) {
        uint64_t begin = count * (uint64_t)i / nthreads;
        uint64_t end   = count * (uint64_t)(i + 1) / nthreads;
        pool.emplace_back([&base, &target, begin, end]() {
            uint32_t fn = 0; uint64_t done = 0;
            mine_range(base, target, begin, end, fn, done);
        });
    }
    for (auto& th : pool) th.join();
    auto t1 = std::chrono::high_resolution_clock::now();
    return std::chrono::duration<double>(t1 - t0).count();
}

int main(int argc, char** argv) {
    std::string binaryFile;
    int device_index = 0;
    uint64_t bench_count = 2000000;
    for (int i = 1; i < argc; i++) {
        std::string a = argv[i];
        if      (a == "-x" && i + 1 < argc) binaryFile   = argv[++i];
        else if (a == "-d" && i + 1 < argc) device_index = atoi(argv[++i]);
        else if (a == "-n" && i + 1 < argc) bench_count  = strtoull(argv[++i], nullptr, 10);
    }
    if (binaryFile.empty()) {
        std::cerr << "usage: " << argv[0] << " -x <xclbin> [-d device] [-n count]\n";
        return EXIT_FAILURE;
    }

    BlockHeader base = genesis_header();
    uint8_t header[HEADER_BYTES];
    serialize_header(base, header);
    uint8_t easy[32]; memset(easy, 0xff, 32); easy[0] = 0x00; easy[1] = 0x00;
    uint8_t zero[32]; memset(zero, 0x00, 32);

    std::cout << "Open device " << device_index << " (baseline)\n";
    auto device = xrt::device(device_index);
    std::cout << "Load xclbin " << binaryFile << "\n";
    auto uuid = device.load_xclbin(binaryFile);
    auto krnl = xrt::kernel(device, uuid, "mine");

    auto hdr_bo = xrt::bo(device, 80,               krnl.group_id(0));
    auto tgt_bo = xrt::bo(device, 32,               krnl.group_id(1));
    auto fn_bo  = xrt::bo(device, sizeof(uint32_t), krnl.group_id(4));
    auto fd_bo  = xrt::bo(device, sizeof(int),      krnl.group_id(5));
    auto hdr_map = hdr_bo.map<uint8_t*>();
    auto tgt_map = tgt_bo.map<uint8_t*>();
    auto fn_map  = fn_bo.map<uint32_t*>();
    auto fd_map  = fd_bo.map<int*>();

    memcpy(hdr_map, header, 80);
    hdr_bo.sync(XCL_BO_SYNC_BO_TO_DEVICE);

    // 1. correctness
    memcpy(tgt_map, easy, 32);
    tgt_bo.sync(XCL_BO_SYNC_BO_TO_DEVICE);
    { auto r = krnl(hdr_bo, tgt_bo, (uint32_t)0, (uint32_t)20000, fn_bo, fd_bo);
      r.wait();
      fn_bo.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
      fd_bo.sync(XCL_BO_SYNC_BO_FROM_DEVICE); }
    uint32_t nonce = fn_map[0];
    int found = fd_map[0];

    bool verify_ok = false;
    if (found) {
        BlockHeader vh = base; vh.nonce = nonce;
        uint8_t vblk[HEADER_BYTES], vhash[32];
        serialize_header(vh, vblk);
        sha256d(vblk, HEADER_BYTES, vhash);
        verify_ok = hash_below_target(vhash, easy);
    }
    bool correct = (found && nonce == 8603 && verify_ok);

    // 2. hardware hash rate
    const int N = 5;
    std::vector<double> ker, tot;
    for (int r = 0; r < N; r++) {
        memcpy(tgt_map, zero, 32);
        auto t0  = std::chrono::high_resolution_clock::now();
        tgt_bo.sync(XCL_BO_SYNC_BO_TO_DEVICE);
        auto tk0 = std::chrono::high_resolution_clock::now();
        auto rn  = krnl(hdr_bo, tgt_bo, (uint32_t)0, (uint32_t)bench_count, fn_bo, fd_bo);
        rn.wait();
        auto tk1 = std::chrono::high_resolution_clock::now();
        fn_bo.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
        fd_bo.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
        auto t1  = std::chrono::high_resolution_clock::now();
        ker.push_back(std::chrono::duration<double>(tk1 - tk0).count());
        tot.push_back(std::chrono::duration<double>(t1  - t0).count());
    }
    double hw_ker_s = median(ker);
    double hw_tot_s = median(tot);
    double hw_rate  = bench_count / hw_ker_s;

    // 3. software baseline
    double sw_s    = sw_bench(base, zero, bench_count, 4);
    double sw_rate = bench_count / sw_s;
    auto   mhs     = [](double r){ return r / 1e6; };

    std::cout << "--------------------------------------------\n";
    std::cout << "Correctness (easy target): found=" << found
              << " nonce=" << nonce << " (expect 8603) reverify="
              << (verify_ok ? "ok" : "NO") << " -> " << (correct ? "PASS" : "FAIL") << "\n";
    std::cout << "PL HARDWARE (baseline kernel @ 200 MHz)\n";
    std::cout << "  nonces/run   : " << bench_count << "\n";
    std::cout << "  median kernel: " << hw_ker_s << " s\n";
    std::cout << "  median total : " << hw_tot_s << " s  (DMA + kernel)\n";
    std::cout << "  hash rate    : " << mhs(hw_rate) << " MH/s\n";
    std::cout << "ARM PS SOFTWARE (4-thread scan, same count)\n";
    std::cout << "  hash rate    : " << mhs(sw_rate) << " MH/s\n";
    std::cout << "SPEEDUP hardware / software : " << (hw_rate / sw_rate) << "x\n";
    std::cout << "--------------------------------------------\n";
    std::cout << (correct ? "TEST PASSED" : "TEST FAILED") << std::endl;
    return correct ? EXIT_SUCCESS : EXIT_FAILURE;
}
