// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.2 (64-bit)
// Tool Version Limit: 2025.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xmine.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XMine_CfgInitialize(XMine *InstancePtr, XMine_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XMine_Start(XMine *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMine_ReadReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_AP_CTRL) & 0x80;
    XMine_WriteReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XMine_IsDone(XMine *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMine_ReadReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XMine_IsIdle(XMine *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMine_ReadReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XMine_IsReady(XMine *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMine_ReadReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XMine_Continue(XMine *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMine_ReadReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_AP_CTRL) & 0x80;
    XMine_WriteReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_AP_CTRL, Data | 0x10);
}

void XMine_EnableAutoRestart(XMine *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMine_WriteReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XMine_DisableAutoRestart(XMine *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMine_WriteReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_AP_CTRL, 0);
}

void XMine_Set_header(XMine *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMine_WriteReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_HEADER_DATA, (u32)(Data));
    XMine_WriteReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_HEADER_DATA + 4, (u32)(Data >> 32));
}

u64 XMine_Get_header(XMine *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMine_ReadReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_HEADER_DATA);
    Data += (u64)XMine_ReadReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_HEADER_DATA + 4) << 32;
    return Data;
}

void XMine_Set_target(XMine *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMine_WriteReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_TARGET_DATA, (u32)(Data));
    XMine_WriteReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_TARGET_DATA + 4, (u32)(Data >> 32));
}

u64 XMine_Get_target(XMine *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMine_ReadReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_TARGET_DATA);
    Data += (u64)XMine_ReadReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_TARGET_DATA + 4) << 32;
    return Data;
}

void XMine_Set_nonce_start(XMine *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMine_WriteReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_NONCE_START_DATA, Data);
}

u32 XMine_Get_nonce_start(XMine *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMine_ReadReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_NONCE_START_DATA);
    return Data;
}

void XMine_Set_nonce_count(XMine *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMine_WriteReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_NONCE_COUNT_DATA, Data);
}

u32 XMine_Get_nonce_count(XMine *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMine_ReadReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_NONCE_COUNT_DATA);
    return Data;
}

void XMine_Set_found_nonce(XMine *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMine_WriteReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_FOUND_NONCE_DATA, (u32)(Data));
    XMine_WriteReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_FOUND_NONCE_DATA + 4, (u32)(Data >> 32));
}

u64 XMine_Get_found_nonce(XMine *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMine_ReadReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_FOUND_NONCE_DATA);
    Data += (u64)XMine_ReadReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_FOUND_NONCE_DATA + 4) << 32;
    return Data;
}

void XMine_Set_found(XMine *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMine_WriteReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_FOUND_DATA, (u32)(Data));
    XMine_WriteReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_FOUND_DATA + 4, (u32)(Data >> 32));
}

u64 XMine_Get_found(XMine *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMine_ReadReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_FOUND_DATA);
    Data += (u64)XMine_ReadReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_FOUND_DATA + 4) << 32;
    return Data;
}

void XMine_InterruptGlobalEnable(XMine *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMine_WriteReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_GIE, 1);
}

void XMine_InterruptGlobalDisable(XMine *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMine_WriteReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_GIE, 0);
}

void XMine_InterruptEnable(XMine *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XMine_ReadReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_IER);
    XMine_WriteReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_IER, Register | Mask);
}

void XMine_InterruptDisable(XMine *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XMine_ReadReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_IER);
    XMine_WriteReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_IER, Register & (~Mask));
}

void XMine_InterruptClear(XMine *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMine_WriteReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_ISR, Mask);
}

u32 XMine_InterruptGetEnabled(XMine *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XMine_ReadReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_IER);
}

u32 XMine_InterruptGetStatus(XMine *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XMine_ReadReg(InstancePtr->Control_BaseAddress, XMINE_CONTROL_ADDR_ISR);
}

