// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.2 (64-bit)
// Tool Version Limit: 2025.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XMINE_H
#define XMINE_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xmine_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
#ifdef SDT
    char *Name;
#else
    u16 DeviceId;
#endif
    u64 Control_BaseAddress;
} XMine_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XMine;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XMine_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XMine_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XMine_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XMine_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
#ifdef SDT
int XMine_Initialize(XMine *InstancePtr, UINTPTR BaseAddress);
XMine_Config* XMine_LookupConfig(UINTPTR BaseAddress);
#else
int XMine_Initialize(XMine *InstancePtr, u16 DeviceId);
XMine_Config* XMine_LookupConfig(u16 DeviceId);
#endif
int XMine_CfgInitialize(XMine *InstancePtr, XMine_Config *ConfigPtr);
#else
int XMine_Initialize(XMine *InstancePtr, const char* InstanceName);
int XMine_Release(XMine *InstancePtr);
#endif

void XMine_Start(XMine *InstancePtr);
u32 XMine_IsDone(XMine *InstancePtr);
u32 XMine_IsIdle(XMine *InstancePtr);
u32 XMine_IsReady(XMine *InstancePtr);
void XMine_Continue(XMine *InstancePtr);
void XMine_EnableAutoRestart(XMine *InstancePtr);
void XMine_DisableAutoRestart(XMine *InstancePtr);

void XMine_Set_header(XMine *InstancePtr, u64 Data);
u64 XMine_Get_header(XMine *InstancePtr);
void XMine_Set_target(XMine *InstancePtr, u64 Data);
u64 XMine_Get_target(XMine *InstancePtr);
void XMine_Set_nonce_start(XMine *InstancePtr, u32 Data);
u32 XMine_Get_nonce_start(XMine *InstancePtr);
void XMine_Set_nonce_count(XMine *InstancePtr, u32 Data);
u32 XMine_Get_nonce_count(XMine *InstancePtr);
void XMine_Set_found_nonce(XMine *InstancePtr, u64 Data);
u64 XMine_Get_found_nonce(XMine *InstancePtr);
void XMine_Set_found(XMine *InstancePtr, u64 Data);
u64 XMine_Get_found(XMine *InstancePtr);

void XMine_InterruptGlobalEnable(XMine *InstancePtr);
void XMine_InterruptGlobalDisable(XMine *InstancePtr);
void XMine_InterruptEnable(XMine *InstancePtr, u32 Mask);
void XMine_InterruptDisable(XMine *InstancePtr, u32 Mask);
void XMine_InterruptClear(XMine *InstancePtr, u32 Mask);
u32 XMine_InterruptGetEnabled(XMine *InstancePtr);
u32 XMine_InterruptGetStatus(XMine *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
