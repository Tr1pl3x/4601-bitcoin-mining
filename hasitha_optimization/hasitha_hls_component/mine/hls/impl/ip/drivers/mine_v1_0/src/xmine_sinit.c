// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.2 (64-bit)
// Tool Version Limit: 2025.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#ifdef SDT
#include "xparameters.h"
#endif
#include "xmine.h"

extern XMine_Config XMine_ConfigTable[];

#ifdef SDT
XMine_Config *XMine_LookupConfig(UINTPTR BaseAddress) {
	XMine_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XMine_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XMine_ConfigTable[Index].Control_BaseAddress == BaseAddress) {
			ConfigPtr = &XMine_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XMine_Initialize(XMine *InstancePtr, UINTPTR BaseAddress) {
	XMine_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XMine_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XMine_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XMine_Config *XMine_LookupConfig(u16 DeviceId) {
	XMine_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XMINE_NUM_INSTANCES; Index++) {
		if (XMine_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XMine_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XMine_Initialize(XMine *InstancePtr, u16 DeviceId) {
	XMine_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XMine_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XMine_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

