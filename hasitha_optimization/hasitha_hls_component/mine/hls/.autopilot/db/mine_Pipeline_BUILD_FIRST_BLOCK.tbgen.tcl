set moduleName mine_Pipeline_BUILD_FIRST_BLOCK
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set isPipelined_legacy 1
set pipeline_type loop_auto_rewind
set FunctionProtocol ap_ctrl_hs
set restart_counter_num 0
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set svuvm_can_support 1
set cdfgNum 14
set C_modelName {mine_Pipeline_BUILD_FIRST_BLOCK}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict hdr { MEM_WIDTH 32 MEM_SIZE 80 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ hdr int 32 regular {array 20 { 1 3 } 1 1 }  }
	{ or7_i_i37_out int 32 regular {pointer 1}  }
	{ or7_i_i35_out int 32 regular {pointer 1}  }
	{ or7_i_i33_out int 32 regular {pointer 1}  }
	{ or7_i_i31_out int 32 regular {pointer 1}  }
	{ or7_i_i29_out int 32 regular {pointer 1}  }
	{ or7_i_i27_out int 32 regular {pointer 1}  }
	{ or7_i_i25_out int 32 regular {pointer 1}  }
	{ or7_i_i23_out int 32 regular {pointer 1}  }
	{ or7_i_i21_out int 32 regular {pointer 1}  }
	{ or7_i_i19_out int 32 regular {pointer 1}  }
	{ or7_i_i17_out int 32 regular {pointer 1}  }
	{ or7_i_i15_out int 32 regular {pointer 1}  }
	{ or7_i_i13_out int 32 regular {pointer 1}  }
	{ or7_i_i11_out int 32 regular {pointer 1}  }
	{ or7_i_i9_out int 32 regular {pointer 1}  }
	{ or7_i_i7_out int 32 regular {pointer 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "hdr", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "or7_i_i37_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "or7_i_i35_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "or7_i_i33_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "or7_i_i31_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "or7_i_i29_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "or7_i_i27_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "or7_i_i25_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "or7_i_i23_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "or7_i_i21_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "or7_i_i19_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "or7_i_i17_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "or7_i_i15_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "or7_i_i13_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "or7_i_i11_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "or7_i_i9_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "or7_i_i7_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 41
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ hdr_address0 sc_out sc_lv 5 signal 0 } 
	{ hdr_ce0 sc_out sc_logic 1 signal 0 } 
	{ hdr_q0 sc_in sc_lv 32 signal 0 } 
	{ or7_i_i37_out sc_out sc_lv 32 signal 1 } 
	{ or7_i_i37_out_ap_vld sc_out sc_logic 1 outvld 1 } 
	{ or7_i_i35_out sc_out sc_lv 32 signal 2 } 
	{ or7_i_i35_out_ap_vld sc_out sc_logic 1 outvld 2 } 
	{ or7_i_i33_out sc_out sc_lv 32 signal 3 } 
	{ or7_i_i33_out_ap_vld sc_out sc_logic 1 outvld 3 } 
	{ or7_i_i31_out sc_out sc_lv 32 signal 4 } 
	{ or7_i_i31_out_ap_vld sc_out sc_logic 1 outvld 4 } 
	{ or7_i_i29_out sc_out sc_lv 32 signal 5 } 
	{ or7_i_i29_out_ap_vld sc_out sc_logic 1 outvld 5 } 
	{ or7_i_i27_out sc_out sc_lv 32 signal 6 } 
	{ or7_i_i27_out_ap_vld sc_out sc_logic 1 outvld 6 } 
	{ or7_i_i25_out sc_out sc_lv 32 signal 7 } 
	{ or7_i_i25_out_ap_vld sc_out sc_logic 1 outvld 7 } 
	{ or7_i_i23_out sc_out sc_lv 32 signal 8 } 
	{ or7_i_i23_out_ap_vld sc_out sc_logic 1 outvld 8 } 
	{ or7_i_i21_out sc_out sc_lv 32 signal 9 } 
	{ or7_i_i21_out_ap_vld sc_out sc_logic 1 outvld 9 } 
	{ or7_i_i19_out sc_out sc_lv 32 signal 10 } 
	{ or7_i_i19_out_ap_vld sc_out sc_logic 1 outvld 10 } 
	{ or7_i_i17_out sc_out sc_lv 32 signal 11 } 
	{ or7_i_i17_out_ap_vld sc_out sc_logic 1 outvld 11 } 
	{ or7_i_i15_out sc_out sc_lv 32 signal 12 } 
	{ or7_i_i15_out_ap_vld sc_out sc_logic 1 outvld 12 } 
	{ or7_i_i13_out sc_out sc_lv 32 signal 13 } 
	{ or7_i_i13_out_ap_vld sc_out sc_logic 1 outvld 13 } 
	{ or7_i_i11_out sc_out sc_lv 32 signal 14 } 
	{ or7_i_i11_out_ap_vld sc_out sc_logic 1 outvld 14 } 
	{ or7_i_i9_out sc_out sc_lv 32 signal 15 } 
	{ or7_i_i9_out_ap_vld sc_out sc_logic 1 outvld 15 } 
	{ or7_i_i7_out sc_out sc_lv 32 signal 16 } 
	{ or7_i_i7_out_ap_vld sc_out sc_logic 1 outvld 16 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "hdr_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "hdr", "role": "address0" }} , 
 	{ "name": "hdr_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "hdr", "role": "ce0" }} , 
 	{ "name": "hdr_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "hdr", "role": "q0" }} , 
 	{ "name": "or7_i_i37_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "or7_i_i37_out", "role": "default" }} , 
 	{ "name": "or7_i_i37_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "or7_i_i37_out", "role": "ap_vld" }} , 
 	{ "name": "or7_i_i35_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "or7_i_i35_out", "role": "default" }} , 
 	{ "name": "or7_i_i35_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "or7_i_i35_out", "role": "ap_vld" }} , 
 	{ "name": "or7_i_i33_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "or7_i_i33_out", "role": "default" }} , 
 	{ "name": "or7_i_i33_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "or7_i_i33_out", "role": "ap_vld" }} , 
 	{ "name": "or7_i_i31_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "or7_i_i31_out", "role": "default" }} , 
 	{ "name": "or7_i_i31_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "or7_i_i31_out", "role": "ap_vld" }} , 
 	{ "name": "or7_i_i29_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "or7_i_i29_out", "role": "default" }} , 
 	{ "name": "or7_i_i29_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "or7_i_i29_out", "role": "ap_vld" }} , 
 	{ "name": "or7_i_i27_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "or7_i_i27_out", "role": "default" }} , 
 	{ "name": "or7_i_i27_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "or7_i_i27_out", "role": "ap_vld" }} , 
 	{ "name": "or7_i_i25_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "or7_i_i25_out", "role": "default" }} , 
 	{ "name": "or7_i_i25_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "or7_i_i25_out", "role": "ap_vld" }} , 
 	{ "name": "or7_i_i23_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "or7_i_i23_out", "role": "default" }} , 
 	{ "name": "or7_i_i23_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "or7_i_i23_out", "role": "ap_vld" }} , 
 	{ "name": "or7_i_i21_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "or7_i_i21_out", "role": "default" }} , 
 	{ "name": "or7_i_i21_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "or7_i_i21_out", "role": "ap_vld" }} , 
 	{ "name": "or7_i_i19_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "or7_i_i19_out", "role": "default" }} , 
 	{ "name": "or7_i_i19_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "or7_i_i19_out", "role": "ap_vld" }} , 
 	{ "name": "or7_i_i17_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "or7_i_i17_out", "role": "default" }} , 
 	{ "name": "or7_i_i17_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "or7_i_i17_out", "role": "ap_vld" }} , 
 	{ "name": "or7_i_i15_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "or7_i_i15_out", "role": "default" }} , 
 	{ "name": "or7_i_i15_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "or7_i_i15_out", "role": "ap_vld" }} , 
 	{ "name": "or7_i_i13_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "or7_i_i13_out", "role": "default" }} , 
 	{ "name": "or7_i_i13_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "or7_i_i13_out", "role": "ap_vld" }} , 
 	{ "name": "or7_i_i11_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "or7_i_i11_out", "role": "default" }} , 
 	{ "name": "or7_i_i11_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "or7_i_i11_out", "role": "ap_vld" }} , 
 	{ "name": "or7_i_i9_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "or7_i_i9_out", "role": "default" }} , 
 	{ "name": "or7_i_i9_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "or7_i_i9_out", "role": "ap_vld" }} , 
 	{ "name": "or7_i_i7_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "or7_i_i7_out", "role": "default" }} , 
 	{ "name": "or7_i_i7_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "or7_i_i7_out", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	mine_Pipeline_BUILD_FIRST_BLOCK {
		hdr {Type I LastRead 0 FirstWrite -1}
		or7_i_i37_out {Type O LastRead -1 FirstWrite 0}
		or7_i_i35_out {Type O LastRead -1 FirstWrite 0}
		or7_i_i33_out {Type O LastRead -1 FirstWrite 0}
		or7_i_i31_out {Type O LastRead -1 FirstWrite 0}
		or7_i_i29_out {Type O LastRead -1 FirstWrite 0}
		or7_i_i27_out {Type O LastRead -1 FirstWrite 0}
		or7_i_i25_out {Type O LastRead -1 FirstWrite 0}
		or7_i_i23_out {Type O LastRead -1 FirstWrite 0}
		or7_i_i21_out {Type O LastRead -1 FirstWrite 0}
		or7_i_i19_out {Type O LastRead -1 FirstWrite 0}
		or7_i_i17_out {Type O LastRead -1 FirstWrite 0}
		or7_i_i15_out {Type O LastRead -1 FirstWrite 0}
		or7_i_i13_out {Type O LastRead -1 FirstWrite 0}
		or7_i_i11_out {Type O LastRead -1 FirstWrite 0}
		or7_i_i9_out {Type O LastRead -1 FirstWrite 0}
		or7_i_i7_out {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "18", "Max" : "18"}
	, {"Name" : "Interval", "Min" : "17", "Max" : "17"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	hdr { ap_memory {  { hdr_address0 mem_address 1 5 }  { hdr_ce0 mem_ce 1 1 }  { hdr_q0 mem_dout 0 32 } } }
	or7_i_i37_out { ap_vld {  { or7_i_i37_out out_data 1 32 }  { or7_i_i37_out_ap_vld out_vld 1 1 } } }
	or7_i_i35_out { ap_vld {  { or7_i_i35_out out_data 1 32 }  { or7_i_i35_out_ap_vld out_vld 1 1 } } }
	or7_i_i33_out { ap_vld {  { or7_i_i33_out out_data 1 32 }  { or7_i_i33_out_ap_vld out_vld 1 1 } } }
	or7_i_i31_out { ap_vld {  { or7_i_i31_out out_data 1 32 }  { or7_i_i31_out_ap_vld out_vld 1 1 } } }
	or7_i_i29_out { ap_vld {  { or7_i_i29_out out_data 1 32 }  { or7_i_i29_out_ap_vld out_vld 1 1 } } }
	or7_i_i27_out { ap_vld {  { or7_i_i27_out out_data 1 32 }  { or7_i_i27_out_ap_vld out_vld 1 1 } } }
	or7_i_i25_out { ap_vld {  { or7_i_i25_out out_data 1 32 }  { or7_i_i25_out_ap_vld out_vld 1 1 } } }
	or7_i_i23_out { ap_vld {  { or7_i_i23_out out_data 1 32 }  { or7_i_i23_out_ap_vld out_vld 1 1 } } }
	or7_i_i21_out { ap_vld {  { or7_i_i21_out out_data 1 32 }  { or7_i_i21_out_ap_vld out_vld 1 1 } } }
	or7_i_i19_out { ap_vld {  { or7_i_i19_out out_data 1 32 }  { or7_i_i19_out_ap_vld out_vld 1 1 } } }
	or7_i_i17_out { ap_vld {  { or7_i_i17_out out_data 1 32 }  { or7_i_i17_out_ap_vld out_vld 1 1 } } }
	or7_i_i15_out { ap_vld {  { or7_i_i15_out out_data 1 32 }  { or7_i_i15_out_ap_vld out_vld 1 1 } } }
	or7_i_i13_out { ap_vld {  { or7_i_i13_out out_data 1 32 }  { or7_i_i13_out_ap_vld out_vld 1 1 } } }
	or7_i_i11_out { ap_vld {  { or7_i_i11_out out_data 1 32 }  { or7_i_i11_out_ap_vld out_vld 1 1 } } }
	or7_i_i9_out { ap_vld {  { or7_i_i9_out out_data 1 32 }  { or7_i_i9_out_ap_vld out_vld 1 1 } } }
	or7_i_i7_out { ap_vld {  { or7_i_i7_out out_data 1 32 }  { or7_i_i7_out_ap_vld out_vld 1 1 } } }
}
