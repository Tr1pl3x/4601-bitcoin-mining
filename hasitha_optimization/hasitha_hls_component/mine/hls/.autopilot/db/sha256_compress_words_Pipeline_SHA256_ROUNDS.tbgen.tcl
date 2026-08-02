set moduleName sha256_compress_words_Pipeline_SHA256_ROUNDS
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
set C_modelName {sha256_compress_words_Pipeline_SHA256_ROUNDS}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ w_80_reload int 32 regular  }
	{ w_79_reload int 32 regular  }
	{ w_78_reload int 32 regular  }
	{ w_77_reload int 32 regular  }
	{ w_76_reload int 32 regular  }
	{ w_75_reload int 32 regular  }
	{ w_74_reload int 32 regular  }
	{ w_73_reload int 32 regular  }
	{ w_72_reload int 32 regular  }
	{ w_71_reload int 32 regular  }
	{ w_70_reload int 32 regular  }
	{ w_69_reload int 32 regular  }
	{ w_68_reload int 32 regular  }
	{ w_67_reload int 32 regular  }
	{ w_66_reload int 32 regular  }
	{ w_reload int 32 regular  }
	{ state_read int 32 regular  }
	{ state_read_8 int 32 regular  }
	{ state_read_9 int 32 regular  }
	{ state_read_10 int 32 regular  }
	{ state_read_11 int 32 regular  }
	{ state_read_12 int 32 regular  }
	{ state_read_13 int 32 regular  }
	{ state_read_14 int 32 regular  }
	{ a_4_out int 32 regular {pointer 1}  }
	{ b_out int 32 regular {pointer 1}  }
	{ c_out int 32 regular {pointer 1}  }
	{ d_out int 32 regular {pointer 1}  }
	{ e_4_out int 32 regular {pointer 1}  }
	{ f_out int 32 regular {pointer 1}  }
	{ g_out int 32 regular {pointer 1}  }
	{ h_01_out int 32 regular {pointer 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "w_80_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_79_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_78_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_77_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_76_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_75_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_74_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_73_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_72_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_71_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_70_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_69_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_68_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_67_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_66_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "w_reload", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "state_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "state_read_8", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "state_read_9", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "state_read_10", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "state_read_11", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "state_read_12", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "state_read_13", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "state_read_14", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "a_4_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "b_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "c_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "d_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "e_4_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "f_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "g_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "h_01_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 46
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ w_80_reload sc_in sc_lv 32 signal 0 } 
	{ w_79_reload sc_in sc_lv 32 signal 1 } 
	{ w_78_reload sc_in sc_lv 32 signal 2 } 
	{ w_77_reload sc_in sc_lv 32 signal 3 } 
	{ w_76_reload sc_in sc_lv 32 signal 4 } 
	{ w_75_reload sc_in sc_lv 32 signal 5 } 
	{ w_74_reload sc_in sc_lv 32 signal 6 } 
	{ w_73_reload sc_in sc_lv 32 signal 7 } 
	{ w_72_reload sc_in sc_lv 32 signal 8 } 
	{ w_71_reload sc_in sc_lv 32 signal 9 } 
	{ w_70_reload sc_in sc_lv 32 signal 10 } 
	{ w_69_reload sc_in sc_lv 32 signal 11 } 
	{ w_68_reload sc_in sc_lv 32 signal 12 } 
	{ w_67_reload sc_in sc_lv 32 signal 13 } 
	{ w_66_reload sc_in sc_lv 32 signal 14 } 
	{ w_reload sc_in sc_lv 32 signal 15 } 
	{ state_read sc_in sc_lv 32 signal 16 } 
	{ state_read_8 sc_in sc_lv 32 signal 17 } 
	{ state_read_9 sc_in sc_lv 32 signal 18 } 
	{ state_read_10 sc_in sc_lv 32 signal 19 } 
	{ state_read_11 sc_in sc_lv 32 signal 20 } 
	{ state_read_12 sc_in sc_lv 32 signal 21 } 
	{ state_read_13 sc_in sc_lv 32 signal 22 } 
	{ state_read_14 sc_in sc_lv 32 signal 23 } 
	{ a_4_out sc_out sc_lv 32 signal 24 } 
	{ a_4_out_ap_vld sc_out sc_logic 1 outvld 24 } 
	{ b_out sc_out sc_lv 32 signal 25 } 
	{ b_out_ap_vld sc_out sc_logic 1 outvld 25 } 
	{ c_out sc_out sc_lv 32 signal 26 } 
	{ c_out_ap_vld sc_out sc_logic 1 outvld 26 } 
	{ d_out sc_out sc_lv 32 signal 27 } 
	{ d_out_ap_vld sc_out sc_logic 1 outvld 27 } 
	{ e_4_out sc_out sc_lv 32 signal 28 } 
	{ e_4_out_ap_vld sc_out sc_logic 1 outvld 28 } 
	{ f_out sc_out sc_lv 32 signal 29 } 
	{ f_out_ap_vld sc_out sc_logic 1 outvld 29 } 
	{ g_out sc_out sc_lv 32 signal 30 } 
	{ g_out_ap_vld sc_out sc_logic 1 outvld 30 } 
	{ h_01_out sc_out sc_lv 32 signal 31 } 
	{ h_01_out_ap_vld sc_out sc_logic 1 outvld 31 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "w_80_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_80_reload", "role": "default" }} , 
 	{ "name": "w_79_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_79_reload", "role": "default" }} , 
 	{ "name": "w_78_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_78_reload", "role": "default" }} , 
 	{ "name": "w_77_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_77_reload", "role": "default" }} , 
 	{ "name": "w_76_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_76_reload", "role": "default" }} , 
 	{ "name": "w_75_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_75_reload", "role": "default" }} , 
 	{ "name": "w_74_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_74_reload", "role": "default" }} , 
 	{ "name": "w_73_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_73_reload", "role": "default" }} , 
 	{ "name": "w_72_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_72_reload", "role": "default" }} , 
 	{ "name": "w_71_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_71_reload", "role": "default" }} , 
 	{ "name": "w_70_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_70_reload", "role": "default" }} , 
 	{ "name": "w_69_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_69_reload", "role": "default" }} , 
 	{ "name": "w_68_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_68_reload", "role": "default" }} , 
 	{ "name": "w_67_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_67_reload", "role": "default" }} , 
 	{ "name": "w_66_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_66_reload", "role": "default" }} , 
 	{ "name": "w_reload", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_reload", "role": "default" }} , 
 	{ "name": "state_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "state_read", "role": "default" }} , 
 	{ "name": "state_read_8", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "state_read_8", "role": "default" }} , 
 	{ "name": "state_read_9", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "state_read_9", "role": "default" }} , 
 	{ "name": "state_read_10", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "state_read_10", "role": "default" }} , 
 	{ "name": "state_read_11", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "state_read_11", "role": "default" }} , 
 	{ "name": "state_read_12", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "state_read_12", "role": "default" }} , 
 	{ "name": "state_read_13", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "state_read_13", "role": "default" }} , 
 	{ "name": "state_read_14", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "state_read_14", "role": "default" }} , 
 	{ "name": "a_4_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "a_4_out", "role": "default" }} , 
 	{ "name": "a_4_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "a_4_out", "role": "ap_vld" }} , 
 	{ "name": "b_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "b_out", "role": "default" }} , 
 	{ "name": "b_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "b_out", "role": "ap_vld" }} , 
 	{ "name": "c_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "c_out", "role": "default" }} , 
 	{ "name": "c_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "c_out", "role": "ap_vld" }} , 
 	{ "name": "d_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "d_out", "role": "default" }} , 
 	{ "name": "d_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "d_out", "role": "ap_vld" }} , 
 	{ "name": "e_4_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "e_4_out", "role": "default" }} , 
 	{ "name": "e_4_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "e_4_out", "role": "ap_vld" }} , 
 	{ "name": "f_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "f_out", "role": "default" }} , 
 	{ "name": "f_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "f_out", "role": "ap_vld" }} , 
 	{ "name": "g_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "g_out", "role": "default" }} , 
 	{ "name": "g_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "g_out", "role": "ap_vld" }} , 
 	{ "name": "h_01_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "h_01_out", "role": "default" }} , 
 	{ "name": "h_01_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "h_01_out", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	sha256_compress_words_Pipeline_SHA256_ROUNDS {
		w_80_reload {Type I LastRead 0 FirstWrite -1}
		w_79_reload {Type I LastRead 0 FirstWrite -1}
		w_78_reload {Type I LastRead 0 FirstWrite -1}
		w_77_reload {Type I LastRead 0 FirstWrite -1}
		w_76_reload {Type I LastRead 0 FirstWrite -1}
		w_75_reload {Type I LastRead 0 FirstWrite -1}
		w_74_reload {Type I LastRead 0 FirstWrite -1}
		w_73_reload {Type I LastRead 0 FirstWrite -1}
		w_72_reload {Type I LastRead 0 FirstWrite -1}
		w_71_reload {Type I LastRead 0 FirstWrite -1}
		w_70_reload {Type I LastRead 0 FirstWrite -1}
		w_69_reload {Type I LastRead 0 FirstWrite -1}
		w_68_reload {Type I LastRead 0 FirstWrite -1}
		w_67_reload {Type I LastRead 0 FirstWrite -1}
		w_66_reload {Type I LastRead 0 FirstWrite -1}
		w_reload {Type I LastRead 0 FirstWrite -1}
		state_read {Type I LastRead 0 FirstWrite -1}
		state_read_8 {Type I LastRead 0 FirstWrite -1}
		state_read_9 {Type I LastRead 0 FirstWrite -1}
		state_read_10 {Type I LastRead 0 FirstWrite -1}
		state_read_11 {Type I LastRead 0 FirstWrite -1}
		state_read_12 {Type I LastRead 0 FirstWrite -1}
		state_read_13 {Type I LastRead 0 FirstWrite -1}
		state_read_14 {Type I LastRead 0 FirstWrite -1}
		a_4_out {Type O LastRead -1 FirstWrite 2}
		b_out {Type O LastRead -1 FirstWrite 2}
		c_out {Type O LastRead -1 FirstWrite 2}
		d_out {Type O LastRead -1 FirstWrite 2}
		e_4_out {Type O LastRead -1 FirstWrite 2}
		f_out {Type O LastRead -1 FirstWrite 2}
		g_out {Type O LastRead -1 FirstWrite 2}
		h_01_out {Type O LastRead -1 FirstWrite 2}
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
	w_80_reload { ap_none {  { w_80_reload in_data 0 32 } } }
	w_79_reload { ap_none {  { w_79_reload in_data 0 32 } } }
	w_78_reload { ap_none {  { w_78_reload in_data 0 32 } } }
	w_77_reload { ap_none {  { w_77_reload in_data 0 32 } } }
	w_76_reload { ap_none {  { w_76_reload in_data 0 32 } } }
	w_75_reload { ap_none {  { w_75_reload in_data 0 32 } } }
	w_74_reload { ap_none {  { w_74_reload in_data 0 32 } } }
	w_73_reload { ap_none {  { w_73_reload in_data 0 32 } } }
	w_72_reload { ap_none {  { w_72_reload in_data 0 32 } } }
	w_71_reload { ap_none {  { w_71_reload in_data 0 32 } } }
	w_70_reload { ap_none {  { w_70_reload in_data 0 32 } } }
	w_69_reload { ap_none {  { w_69_reload in_data 0 32 } } }
	w_68_reload { ap_none {  { w_68_reload in_data 0 32 } } }
	w_67_reload { ap_none {  { w_67_reload in_data 0 32 } } }
	w_66_reload { ap_none {  { w_66_reload in_data 0 32 } } }
	w_reload { ap_none {  { w_reload in_data 0 32 } } }
	state_read { ap_none {  { state_read in_data 0 32 } } }
	state_read_8 { ap_none {  { state_read_8 in_data 0 32 } } }
	state_read_9 { ap_none {  { state_read_9 in_data 0 32 } } }
	state_read_10 { ap_none {  { state_read_10 in_data 0 32 } } }
	state_read_11 { ap_none {  { state_read_11 in_data 0 32 } } }
	state_read_12 { ap_none {  { state_read_12 in_data 0 32 } } }
	state_read_13 { ap_none {  { state_read_13 in_data 0 32 } } }
	state_read_14 { ap_none {  { state_read_14 in_data 0 32 } } }
	a_4_out { ap_vld {  { a_4_out out_data 1 32 }  { a_4_out_ap_vld out_vld 1 1 } } }
	b_out { ap_vld {  { b_out out_data 1 32 }  { b_out_ap_vld out_vld 1 1 } } }
	c_out { ap_vld {  { c_out out_data 1 32 }  { c_out_ap_vld out_vld 1 1 } } }
	d_out { ap_vld {  { d_out out_data 1 32 }  { d_out_ap_vld out_vld 1 1 } } }
	e_4_out { ap_vld {  { e_4_out out_data 1 32 }  { e_4_out_ap_vld out_vld 1 1 } } }
	f_out { ap_vld {  { f_out out_data 1 32 }  { f_out_ap_vld out_vld 1 1 } } }
	g_out { ap_vld {  { g_out out_data 1 32 }  { g_out_ap_vld out_vld 1 1 } } }
	h_01_out { ap_vld {  { h_01_out out_data 1 32 }  { h_01_out_ap_vld out_vld 1 1 } } }
}
