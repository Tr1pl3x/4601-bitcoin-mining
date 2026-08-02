set moduleName sha256_compress_words_1_Pipeline_SHA256_ROUNDS
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
set C_modelName {sha256_compress_words.1_Pipeline_SHA256_ROUNDS}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ w_15_reload int 32 regular  }
	{ w_14_reload int 32 regular  }
	{ w_13_reload int 32 regular  }
	{ w_12_reload int 32 regular  }
	{ w_11_reload int 32 regular  }
	{ w_10_reload int 32 regular  }
	{ w_9_reload int 32 regular  }
	{ w_8_reload int 32 regular  }
	{ w_7_reload int 32 regular  }
	{ w_6_reload int 32 regular  }
	{ w_5_reload int 32 regular  }
	{ w_4_reload int 32 regular  }
	{ w_3_reload int 32 regular  }
	{ w_2_reload int 32 regular  }
	{ w_1_reload int 32 regular  }
	{ w_reload int 32 regular  }
	{ a_2_out int 32 regular {pointer 1}  }
	{ b_out int 32 regular {pointer 1}  }
	{ c_out int 32 regular {pointer 1}  }
	{ d_out int 32 regular {pointer 1}  }
	{ e_2_out int 32 regular {pointer 1}  }
	{ f_out int 32 regular {pointer 1}  }
	{ g_out int 32 regular {pointer 1}  }
	{ h_out int 32 regular {pointer 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "w_15_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_14_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_13_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_12_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_11_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_10_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_9_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_8_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_7_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_6_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_5_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_4_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_3_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_2_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_1_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "a_2_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "b_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "c_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "d_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "e_2_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "f_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "g_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "h_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 38
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ w_15_reload sc_in sc_lv 32 signal 0 } 
	{ w_14_reload sc_in sc_lv 32 signal 1 } 
	{ w_13_reload sc_in sc_lv 32 signal 2 } 
	{ w_12_reload sc_in sc_lv 32 signal 3 } 
	{ w_11_reload sc_in sc_lv 32 signal 4 } 
	{ w_10_reload sc_in sc_lv 32 signal 5 } 
	{ w_9_reload sc_in sc_lv 32 signal 6 } 
	{ w_8_reload sc_in sc_lv 32 signal 7 } 
	{ w_7_reload sc_in sc_lv 32 signal 8 } 
	{ w_6_reload sc_in sc_lv 32 signal 9 } 
	{ w_5_reload sc_in sc_lv 32 signal 10 } 
	{ w_4_reload sc_in sc_lv 32 signal 11 } 
	{ w_3_reload sc_in sc_lv 32 signal 12 } 
	{ w_2_reload sc_in sc_lv 32 signal 13 } 
	{ w_1_reload sc_in sc_lv 32 signal 14 } 
	{ w_reload sc_in sc_lv 32 signal 15 } 
	{ a_2_out sc_out sc_lv 32 signal 16 } 
	{ a_2_out_ap_vld sc_out sc_logic 1 outvld 16 } 
	{ b_out sc_out sc_lv 32 signal 17 } 
	{ b_out_ap_vld sc_out sc_logic 1 outvld 17 } 
	{ c_out sc_out sc_lv 32 signal 18 } 
	{ c_out_ap_vld sc_out sc_logic 1 outvld 18 } 
	{ d_out sc_out sc_lv 32 signal 19 } 
	{ d_out_ap_vld sc_out sc_logic 1 outvld 19 } 
	{ e_2_out sc_out sc_lv 32 signal 20 } 
	{ e_2_out_ap_vld sc_out sc_logic 1 outvld 20 } 
	{ f_out sc_out sc_lv 32 signal 21 } 
	{ f_out_ap_vld sc_out sc_logic 1 outvld 21 } 
	{ g_out sc_out sc_lv 32 signal 22 } 
	{ g_out_ap_vld sc_out sc_logic 1 outvld 22 } 
	{ h_out sc_out sc_lv 32 signal 23 } 
	{ h_out_ap_vld sc_out sc_logic 1 outvld 23 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "w_15_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_15_reload", "role": "default" }} , 
 	{ "name": "w_14_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_14_reload", "role": "default" }} , 
 	{ "name": "w_13_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_13_reload", "role": "default" }} , 
 	{ "name": "w_12_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_12_reload", "role": "default" }} , 
 	{ "name": "w_11_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_11_reload", "role": "default" }} , 
 	{ "name": "w_10_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_10_reload", "role": "default" }} , 
 	{ "name": "w_9_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_9_reload", "role": "default" }} , 
 	{ "name": "w_8_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_8_reload", "role": "default" }} , 
 	{ "name": "w_7_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_7_reload", "role": "default" }} , 
 	{ "name": "w_6_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_6_reload", "role": "default" }} , 
 	{ "name": "w_5_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_5_reload", "role": "default" }} , 
 	{ "name": "w_4_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_4_reload", "role": "default" }} , 
 	{ "name": "w_3_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_3_reload", "role": "default" }} , 
 	{ "name": "w_2_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_2_reload", "role": "default" }} , 
 	{ "name": "w_1_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_1_reload", "role": "default" }} , 
 	{ "name": "w_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_reload", "role": "default" }} , 
 	{ "name": "a_2_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "a_2_out", "role": "default" }} , 
 	{ "name": "a_2_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "a_2_out", "role": "ap_vld" }} , 
 	{ "name": "b_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "b_out", "role": "default" }} , 
 	{ "name": "b_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "b_out", "role": "ap_vld" }} , 
 	{ "name": "c_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "c_out", "role": "default" }} , 
 	{ "name": "c_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "c_out", "role": "ap_vld" }} , 
 	{ "name": "d_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "d_out", "role": "default" }} , 
 	{ "name": "d_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "d_out", "role": "ap_vld" }} , 
 	{ "name": "e_2_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "e_2_out", "role": "default" }} , 
 	{ "name": "e_2_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "e_2_out", "role": "ap_vld" }} , 
 	{ "name": "f_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "f_out", "role": "default" }} , 
 	{ "name": "f_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "f_out", "role": "ap_vld" }} , 
 	{ "name": "g_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "g_out", "role": "default" }} , 
 	{ "name": "g_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "g_out", "role": "ap_vld" }} , 
 	{ "name": "h_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "h_out", "role": "default" }} , 
 	{ "name": "h_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "h_out", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
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
	{"Name" : "Latency", "Min" : "67", "Max" : "67"}
	, {"Name" : "Interval", "Min" : "65", "Max" : "65"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	w_15_reload { ap_none {  { w_15_reload in_data 0 32 } } }
	w_14_reload { ap_none {  { w_14_reload in_data 0 32 } } }
	w_13_reload { ap_none {  { w_13_reload in_data 0 32 } } }
	w_12_reload { ap_none {  { w_12_reload in_data 0 32 } } }
	w_11_reload { ap_none {  { w_11_reload in_data 0 32 } } }
	w_10_reload { ap_none {  { w_10_reload in_data 0 32 } } }
	w_9_reload { ap_none {  { w_9_reload in_data 0 32 } } }
	w_8_reload { ap_none {  { w_8_reload in_data 0 32 } } }
	w_7_reload { ap_none {  { w_7_reload in_data 0 32 } } }
	w_6_reload { ap_none {  { w_6_reload in_data 0 32 } } }
	w_5_reload { ap_none {  { w_5_reload in_data 0 32 } } }
	w_4_reload { ap_none {  { w_4_reload in_data 0 32 } } }
	w_3_reload { ap_none {  { w_3_reload in_data 0 32 } } }
	w_2_reload { ap_none {  { w_2_reload in_data 0 32 } } }
	w_1_reload { ap_none {  { w_1_reload in_data 0 32 } } }
	w_reload { ap_none {  { w_reload in_data 0 32 } } }
	a_2_out { ap_vld {  { a_2_out out_data 1 32 }  { a_2_out_ap_vld out_vld 1 1 } } }
	b_out { ap_vld {  { b_out out_data 1 32 }  { b_out_ap_vld out_vld 1 1 } } }
	c_out { ap_vld {  { c_out out_data 1 32 }  { c_out_ap_vld out_vld 1 1 } } }
	d_out { ap_vld {  { d_out out_data 1 32 }  { d_out_ap_vld out_vld 1 1 } } }
	e_2_out { ap_vld {  { e_2_out out_data 1 32 }  { e_2_out_ap_vld out_vld 1 1 } } }
	f_out { ap_vld {  { f_out out_data 1 32 }  { f_out_ap_vld out_vld 1 1 } } }
	g_out { ap_vld {  { g_out out_data 1 32 }  { g_out_ap_vld out_vld 1 1 } } }
	h_out { ap_vld {  { h_out out_data 1 32 }  { h_out_ap_vld out_vld 1 1 } } }
}
