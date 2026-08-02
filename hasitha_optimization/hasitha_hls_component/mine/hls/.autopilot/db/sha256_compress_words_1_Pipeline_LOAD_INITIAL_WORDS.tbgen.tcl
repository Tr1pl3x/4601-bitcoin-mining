set moduleName sha256_compress_words_1_Pipeline_LOAD_INITIAL_WORDS
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
set C_modelName {sha256_compress_words.1_Pipeline_LOAD_INITIAL_WORDS}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ block_words_0_val int 32 regular  }
	{ block_words_1_val int 32 regular  }
	{ block_words_2_val int 32 regular  }
	{ block_words_3_val int 32 regular  }
	{ block_words_4_val int 32 regular  }
	{ block_words_5_val int 32 regular  }
	{ block_words_6_val int 32 regular  }
	{ block_words_7_val int 32 regular  }
	{ block_words_8_val int 32 regular  }
	{ block_words_9_val int 32 regular  }
	{ block_words_10_val int 32 regular  }
	{ block_words_11_val int 32 regular  }
	{ block_words_12_val int 32 regular  }
	{ block_words_13_val int 32 regular  }
	{ block_words_14_val int 32 regular  }
	{ block_words_15_val int 32 regular  }
	{ w_15_out int 32 regular {pointer 1}  }
	{ w_14_out int 32 regular {pointer 1}  }
	{ w_13_out int 32 regular {pointer 1}  }
	{ w_12_out int 32 regular {pointer 1}  }
	{ w_11_out int 32 regular {pointer 1}  }
	{ w_10_out int 32 regular {pointer 1}  }
	{ w_9_out int 32 regular {pointer 1}  }
	{ w_8_out int 32 regular {pointer 1}  }
	{ w_7_out int 32 regular {pointer 1}  }
	{ w_6_out int 32 regular {pointer 1}  }
	{ w_5_out int 32 regular {pointer 1}  }
	{ w_4_out int 32 regular {pointer 1}  }
	{ w_3_out int 32 regular {pointer 1}  }
	{ w_2_out int 32 regular {pointer 1}  }
	{ w_1_out int 32 regular {pointer 1}  }
	{ w_out int 32 regular {pointer 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "block_words_0_val", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_1_val", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_2_val", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_3_val", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_4_val", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_5_val", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_6_val", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_7_val", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_8_val", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_9_val", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_10_val", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_11_val", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_12_val", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_13_val", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_14_val", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_15_val", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_15_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_14_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_13_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_12_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_11_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_10_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_9_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_8_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_7_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_6_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_5_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_4_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_3_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_2_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_1_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 54
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ block_words_0_val sc_in sc_lv 32 signal 0 } 
	{ block_words_1_val sc_in sc_lv 32 signal 1 } 
	{ block_words_2_val sc_in sc_lv 32 signal 2 } 
	{ block_words_3_val sc_in sc_lv 32 signal 3 } 
	{ block_words_4_val sc_in sc_lv 32 signal 4 } 
	{ block_words_5_val sc_in sc_lv 32 signal 5 } 
	{ block_words_6_val sc_in sc_lv 32 signal 6 } 
	{ block_words_7_val sc_in sc_lv 32 signal 7 } 
	{ block_words_8_val sc_in sc_lv 32 signal 8 } 
	{ block_words_9_val sc_in sc_lv 32 signal 9 } 
	{ block_words_10_val sc_in sc_lv 32 signal 10 } 
	{ block_words_11_val sc_in sc_lv 32 signal 11 } 
	{ block_words_12_val sc_in sc_lv 32 signal 12 } 
	{ block_words_13_val sc_in sc_lv 32 signal 13 } 
	{ block_words_14_val sc_in sc_lv 32 signal 14 } 
	{ block_words_15_val sc_in sc_lv 32 signal 15 } 
	{ w_15_out sc_out sc_lv 32 signal 16 } 
	{ w_15_out_ap_vld sc_out sc_logic 1 outvld 16 } 
	{ w_14_out sc_out sc_lv 32 signal 17 } 
	{ w_14_out_ap_vld sc_out sc_logic 1 outvld 17 } 
	{ w_13_out sc_out sc_lv 32 signal 18 } 
	{ w_13_out_ap_vld sc_out sc_logic 1 outvld 18 } 
	{ w_12_out sc_out sc_lv 32 signal 19 } 
	{ w_12_out_ap_vld sc_out sc_logic 1 outvld 19 } 
	{ w_11_out sc_out sc_lv 32 signal 20 } 
	{ w_11_out_ap_vld sc_out sc_logic 1 outvld 20 } 
	{ w_10_out sc_out sc_lv 32 signal 21 } 
	{ w_10_out_ap_vld sc_out sc_logic 1 outvld 21 } 
	{ w_9_out sc_out sc_lv 32 signal 22 } 
	{ w_9_out_ap_vld sc_out sc_logic 1 outvld 22 } 
	{ w_8_out sc_out sc_lv 32 signal 23 } 
	{ w_8_out_ap_vld sc_out sc_logic 1 outvld 23 } 
	{ w_7_out sc_out sc_lv 32 signal 24 } 
	{ w_7_out_ap_vld sc_out sc_logic 1 outvld 24 } 
	{ w_6_out sc_out sc_lv 32 signal 25 } 
	{ w_6_out_ap_vld sc_out sc_logic 1 outvld 25 } 
	{ w_5_out sc_out sc_lv 32 signal 26 } 
	{ w_5_out_ap_vld sc_out sc_logic 1 outvld 26 } 
	{ w_4_out sc_out sc_lv 32 signal 27 } 
	{ w_4_out_ap_vld sc_out sc_logic 1 outvld 27 } 
	{ w_3_out sc_out sc_lv 32 signal 28 } 
	{ w_3_out_ap_vld sc_out sc_logic 1 outvld 28 } 
	{ w_2_out sc_out sc_lv 32 signal 29 } 
	{ w_2_out_ap_vld sc_out sc_logic 1 outvld 29 } 
	{ w_1_out sc_out sc_lv 32 signal 30 } 
	{ w_1_out_ap_vld sc_out sc_logic 1 outvld 30 } 
	{ w_out sc_out sc_lv 32 signal 31 } 
	{ w_out_ap_vld sc_out sc_logic 1 outvld 31 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "block_words_0_val", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_0_val", "role": "default" }} , 
 	{ "name": "block_words_1_val", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_1_val", "role": "default" }} , 
 	{ "name": "block_words_2_val", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_2_val", "role": "default" }} , 
 	{ "name": "block_words_3_val", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_3_val", "role": "default" }} , 
 	{ "name": "block_words_4_val", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_4_val", "role": "default" }} , 
 	{ "name": "block_words_5_val", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_5_val", "role": "default" }} , 
 	{ "name": "block_words_6_val", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_6_val", "role": "default" }} , 
 	{ "name": "block_words_7_val", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_7_val", "role": "default" }} , 
 	{ "name": "block_words_8_val", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_8_val", "role": "default" }} , 
 	{ "name": "block_words_9_val", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_9_val", "role": "default" }} , 
 	{ "name": "block_words_10_val", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_10_val", "role": "default" }} , 
 	{ "name": "block_words_11_val", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_11_val", "role": "default" }} , 
 	{ "name": "block_words_12_val", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_12_val", "role": "default" }} , 
 	{ "name": "block_words_13_val", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_13_val", "role": "default" }} , 
 	{ "name": "block_words_14_val", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_14_val", "role": "default" }} , 
 	{ "name": "block_words_15_val", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_15_val", "role": "default" }} , 
 	{ "name": "w_15_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_15_out", "role": "default" }} , 
 	{ "name": "w_15_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_15_out", "role": "ap_vld" }} , 
 	{ "name": "w_14_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_14_out", "role": "default" }} , 
 	{ "name": "w_14_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_14_out", "role": "ap_vld" }} , 
 	{ "name": "w_13_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_13_out", "role": "default" }} , 
 	{ "name": "w_13_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_13_out", "role": "ap_vld" }} , 
 	{ "name": "w_12_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_12_out", "role": "default" }} , 
 	{ "name": "w_12_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_12_out", "role": "ap_vld" }} , 
 	{ "name": "w_11_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_11_out", "role": "default" }} , 
 	{ "name": "w_11_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_11_out", "role": "ap_vld" }} , 
 	{ "name": "w_10_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_10_out", "role": "default" }} , 
 	{ "name": "w_10_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_10_out", "role": "ap_vld" }} , 
 	{ "name": "w_9_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_9_out", "role": "default" }} , 
 	{ "name": "w_9_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_9_out", "role": "ap_vld" }} , 
 	{ "name": "w_8_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_8_out", "role": "default" }} , 
 	{ "name": "w_8_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_8_out", "role": "ap_vld" }} , 
 	{ "name": "w_7_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_7_out", "role": "default" }} , 
 	{ "name": "w_7_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_7_out", "role": "ap_vld" }} , 
 	{ "name": "w_6_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_6_out", "role": "default" }} , 
 	{ "name": "w_6_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_6_out", "role": "ap_vld" }} , 
 	{ "name": "w_5_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_5_out", "role": "default" }} , 
 	{ "name": "w_5_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_5_out", "role": "ap_vld" }} , 
 	{ "name": "w_4_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_4_out", "role": "default" }} , 
 	{ "name": "w_4_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_4_out", "role": "ap_vld" }} , 
 	{ "name": "w_3_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_3_out", "role": "default" }} , 
 	{ "name": "w_3_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_3_out", "role": "ap_vld" }} , 
 	{ "name": "w_2_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_2_out", "role": "default" }} , 
 	{ "name": "w_2_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_2_out", "role": "ap_vld" }} , 
 	{ "name": "w_1_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_1_out", "role": "default" }} , 
 	{ "name": "w_1_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_1_out", "role": "ap_vld" }} , 
 	{ "name": "w_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_out", "role": "default" }} , 
 	{ "name": "w_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_out", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	sha256_compress_words_1_Pipeline_LOAD_INITIAL_WORDS {
		block_words_0_val {Type I LastRead 0 FirstWrite -1}
		block_words_1_val {Type I LastRead 0 FirstWrite -1}
		block_words_2_val {Type I LastRead 0 FirstWrite -1}
		block_words_3_val {Type I LastRead 0 FirstWrite -1}
		block_words_4_val {Type I LastRead 0 FirstWrite -1}
		block_words_5_val {Type I LastRead 0 FirstWrite -1}
		block_words_6_val {Type I LastRead 0 FirstWrite -1}
		block_words_7_val {Type I LastRead 0 FirstWrite -1}
		block_words_8_val {Type I LastRead 0 FirstWrite -1}
		block_words_9_val {Type I LastRead 0 FirstWrite -1}
		block_words_10_val {Type I LastRead 0 FirstWrite -1}
		block_words_11_val {Type I LastRead 0 FirstWrite -1}
		block_words_12_val {Type I LastRead 0 FirstWrite -1}
		block_words_13_val {Type I LastRead 0 FirstWrite -1}
		block_words_14_val {Type I LastRead 0 FirstWrite -1}
		block_words_15_val {Type I LastRead 0 FirstWrite -1}
		w_15_out {Type O LastRead -1 FirstWrite 0}
		w_14_out {Type O LastRead -1 FirstWrite 0}
		w_13_out {Type O LastRead -1 FirstWrite 0}
		w_12_out {Type O LastRead -1 FirstWrite 0}
		w_11_out {Type O LastRead -1 FirstWrite 0}
		w_10_out {Type O LastRead -1 FirstWrite 0}
		w_9_out {Type O LastRead -1 FirstWrite 0}
		w_8_out {Type O LastRead -1 FirstWrite 0}
		w_7_out {Type O LastRead -1 FirstWrite 0}
		w_6_out {Type O LastRead -1 FirstWrite 0}
		w_5_out {Type O LastRead -1 FirstWrite 0}
		w_4_out {Type O LastRead -1 FirstWrite 0}
		w_3_out {Type O LastRead -1 FirstWrite 0}
		w_2_out {Type O LastRead -1 FirstWrite 0}
		w_1_out {Type O LastRead -1 FirstWrite 0}
		w_out {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "18", "Max" : "18"}
	, {"Name" : "Interval", "Min" : "17", "Max" : "17"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	block_words_0_val { ap_none {  { block_words_0_val in_data 0 32 } } }
	block_words_1_val { ap_none {  { block_words_1_val in_data 0 32 } } }
	block_words_2_val { ap_none {  { block_words_2_val in_data 0 32 } } }
	block_words_3_val { ap_none {  { block_words_3_val in_data 0 32 } } }
	block_words_4_val { ap_none {  { block_words_4_val in_data 0 32 } } }
	block_words_5_val { ap_none {  { block_words_5_val in_data 0 32 } } }
	block_words_6_val { ap_none {  { block_words_6_val in_data 0 32 } } }
	block_words_7_val { ap_none {  { block_words_7_val in_data 0 32 } } }
	block_words_8_val { ap_none {  { block_words_8_val in_data 0 32 } } }
	block_words_9_val { ap_none {  { block_words_9_val in_data 0 32 } } }
	block_words_10_val { ap_none {  { block_words_10_val in_data 0 32 } } }
	block_words_11_val { ap_none {  { block_words_11_val in_data 0 32 } } }
	block_words_12_val { ap_none {  { block_words_12_val in_data 0 32 } } }
	block_words_13_val { ap_none {  { block_words_13_val in_data 0 32 } } }
	block_words_14_val { ap_none {  { block_words_14_val in_data 0 32 } } }
	block_words_15_val { ap_none {  { block_words_15_val in_data 0 32 } } }
	w_15_out { ap_vld {  { w_15_out out_data 1 32 }  { w_15_out_ap_vld out_vld 1 1 } } }
	w_14_out { ap_vld {  { w_14_out out_data 1 32 }  { w_14_out_ap_vld out_vld 1 1 } } }
	w_13_out { ap_vld {  { w_13_out out_data 1 32 }  { w_13_out_ap_vld out_vld 1 1 } } }
	w_12_out { ap_vld {  { w_12_out out_data 1 32 }  { w_12_out_ap_vld out_vld 1 1 } } }
	w_11_out { ap_vld {  { w_11_out out_data 1 32 }  { w_11_out_ap_vld out_vld 1 1 } } }
	w_10_out { ap_vld {  { w_10_out out_data 1 32 }  { w_10_out_ap_vld out_vld 1 1 } } }
	w_9_out { ap_vld {  { w_9_out out_data 1 32 }  { w_9_out_ap_vld out_vld 1 1 } } }
	w_8_out { ap_vld {  { w_8_out out_data 1 32 }  { w_8_out_ap_vld out_vld 1 1 } } }
	w_7_out { ap_vld {  { w_7_out out_data 1 32 }  { w_7_out_ap_vld out_vld 1 1 } } }
	w_6_out { ap_vld {  { w_6_out out_data 1 32 }  { w_6_out_ap_vld out_vld 1 1 } } }
	w_5_out { ap_vld {  { w_5_out out_data 1 32 }  { w_5_out_ap_vld out_vld 1 1 } } }
	w_4_out { ap_vld {  { w_4_out out_data 1 32 }  { w_4_out_ap_vld out_vld 1 1 } } }
	w_3_out { ap_vld {  { w_3_out out_data 1 32 }  { w_3_out_ap_vld out_vld 1 1 } } }
	w_2_out { ap_vld {  { w_2_out out_data 1 32 }  { w_2_out_ap_vld out_vld 1 1 } } }
	w_1_out { ap_vld {  { w_1_out out_data 1 32 }  { w_1_out_ap_vld out_vld 1 1 } } }
	w_out { ap_vld {  { w_out out_data 1 32 }  { w_out_ap_vld out_vld 1 1 } } }
}
