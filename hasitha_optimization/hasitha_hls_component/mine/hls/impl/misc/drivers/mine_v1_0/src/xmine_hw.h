// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.2 (64-bit)
// Tool Version Limit: 2025.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
// control
// 0x00 : Control signals
//        bit 0  - ap_start (Read/Write/COH)
//        bit 1  - ap_done (Read)
//        bit 2  - ap_idle (Read)
//        bit 3  - ap_ready (Read/COR)
//        bit 4  - ap_continue (Read/Write/SC)
//        bit 7  - auto_restart (Read/Write)
//        bit 9  - interrupt (Read)
//        others - reserved
// 0x04 : Global Interrupt Enable Register
//        bit 0  - Global Interrupt Enable (Read/Write)
//        others - reserved
// 0x08 : IP Interrupt Enable Register (Read/Write)
//        bit 0 - enable ap_done interrupt (Read/Write)
//        bit 1 - enable ap_ready interrupt (Read/Write)
//        others - reserved
// 0x0c : IP Interrupt Status Register (Read/TOW)
//        bit 0 - ap_done (Read/TOW)
//        bit 1 - ap_ready (Read/TOW)
//        others - reserved
// 0x10 : Data signal of header
//        bit 31~0 - header[31:0] (Read/Write)
// 0x14 : Data signal of header
//        bit 31~0 - header[63:32] (Read/Write)
// 0x18 : reserved
// 0x1c : Data signal of target
//        bit 31~0 - target[31:0] (Read/Write)
// 0x20 : Data signal of target
//        bit 31~0 - target[63:32] (Read/Write)
// 0x24 : reserved
// 0x28 : Data signal of nonce_start
//        bit 31~0 - nonce_start[31:0] (Read/Write)
// 0x2c : reserved
// 0x30 : Data signal of nonce_count
//        bit 31~0 - nonce_count[31:0] (Read/Write)
// 0x34 : reserved
// 0x38 : Data signal of found_nonce
//        bit 31~0 - found_nonce[31:0] (Read/Write)
// 0x3c : Data signal of found_nonce
//        bit 31~0 - found_nonce[63:32] (Read/Write)
// 0x40 : reserved
// 0x44 : Data signal of found
//        bit 31~0 - found[31:0] (Read/Write)
// 0x48 : Data signal of found
//        bit 31~0 - found[63:32] (Read/Write)
// 0x4c : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XMINE_CONTROL_ADDR_AP_CTRL          0x00
#define XMINE_CONTROL_ADDR_GIE              0x04
#define XMINE_CONTROL_ADDR_IER              0x08
#define XMINE_CONTROL_ADDR_ISR              0x0c
#define XMINE_CONTROL_ADDR_HEADER_DATA      0x10
#define XMINE_CONTROL_BITS_HEADER_DATA      64
#define XMINE_CONTROL_ADDR_TARGET_DATA      0x1c
#define XMINE_CONTROL_BITS_TARGET_DATA      64
#define XMINE_CONTROL_ADDR_NONCE_START_DATA 0x28
#define XMINE_CONTROL_BITS_NONCE_START_DATA 32
#define XMINE_CONTROL_ADDR_NONCE_COUNT_DATA 0x30
#define XMINE_CONTROL_BITS_NONCE_COUNT_DATA 32
#define XMINE_CONTROL_ADDR_FOUND_NONCE_DATA 0x38
#define XMINE_CONTROL_BITS_FOUND_NONCE_DATA 64
#define XMINE_CONTROL_ADDR_FOUND_DATA       0x44
#define XMINE_CONTROL_BITS_FOUND_DATA       64

