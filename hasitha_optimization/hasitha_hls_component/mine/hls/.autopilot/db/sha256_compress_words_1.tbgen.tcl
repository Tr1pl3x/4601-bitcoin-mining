set moduleName sha256_compress_words_1
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set isPipelined_legacy 0
set pipeline_type none
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
set C_modelName {sha256_compress_words.1}
set C_modelType { int 256 }
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
 	{ "Name" : "ap_return", "interface" : "wire", "bitwidth" : 256} ]}
# RTL Port declarations: 
set portNum 30
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
	{ ap_return_0 sc_out sc_lv 32 signal -1 } 
	{ ap_return_1 sc_out sc_lv 32 signal -1 } 
	{ ap_return_2 sc_out sc_lv 32 signal -1 } 
	{ ap_return_3 sc_out sc_lv 32 signal -1 } 
	{ ap_return_4 sc_out sc_lv 32 signal -1 } 
	{ ap_return_5 sc_out sc_lv 32 signal -1 } 
	{ ap_return_6 sc_out sc_lv 32 signal -1 } 
	{ ap_return_7 sc_out sc_lv 32 signal -1 } 
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
 	{ "name": "ap_return_0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_0", "role": "default" }} , 
 	{ "name": "ap_return_1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_1", "role": "default" }} , 
 	{ "name": "ap_return_2", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_2", "role": "default" }} , 
 	{ "name": "ap_return_3", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_3", "role": "default" }} , 
 	{ "name": "ap_return_4", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_4", "role": "default" }} , 
 	{ "name": "ap_return_5", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_5", "role": "default" }} , 
 	{ "name": "ap_return_6", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_6", "role": "default" }} , 
 	{ "name": "ap_return_7", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_7", "role": "default" }}  ]}

set ArgLastReadFirstWriteLatency {
	sha256_compress_words_1 {
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
		K {Type I LastRead -1 FirstWrite -1}}
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
		w_out {Type O LastRead -1 FirstWrite 0}}
	sha256_compress_words_1_Pipeline_SHA256_ROUNDS {
		w_15_reload {Type I LastRead 0 FirstWrite -1}
		w_14_reload {Type I LastRead 0 FirstWrite -1}
		w_13_reload {Type I LastRead 0 FirstWrite -1}
		w_12_reload {Type I LastRead 0 FirstWrite -1}
		w_11_reload {Type I LastRead 0 FirstWrite -1}
		w_10_reload {Type I LastRead 0 FirstWrite -1}
		w_9_reload {Type I LastRead 0 FirstWrite -1}
		w_8_reload {Type I LastRead 0 FirstWrite -1}
		w_7_reload {Type I LastRead 0 FirstWrite -1}
		w_6_reload {Type I LastRead 0 FirstWrite -1}
		w_5_reload {Type I LastRead 0 FirstWrite -1}
		w_4_reload {Type I LastRead 0 FirstWrite -1}
		w_3_reload {Type I LastRead 0 FirstWrite -1}
		w_2_reload {Type I LastRead 0 FirstWrite -1}
		w_1_reload {Type I LastRead 0 FirstWrite -1}
		w_reload {Type I LastRead 0 FirstWrite -1}
		a_2_out {Type O LastRead -1 FirstWrite 2}
		b_out {Type O LastRead -1 FirstWrite 2}
		c_out {Type O LastRead -1 FirstWrite 2}
		d_out {Type O LastRead -1 FirstWrite 2}
		e_2_out {Type O LastRead -1 FirstWrite 2}
		f_out {Type O LastRead -1 FirstWrite 2}
		g_out {Type O LastRead -1 FirstWrite 2}
		h_out {Type O LastRead -1 FirstWrite 2}
		K {Type I LastRead -1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "89", "Max" : "89"}
	, {"Name" : "Interval", "Min" : "89", "Max" : "89"}
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
}
