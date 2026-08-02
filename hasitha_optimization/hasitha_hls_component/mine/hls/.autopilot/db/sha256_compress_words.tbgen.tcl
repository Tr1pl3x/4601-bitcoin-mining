set moduleName sha256_compress_words
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
set C_modelName {sha256_compress_words}
set C_modelType { int 256 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ state_read int 32 regular  }
	{ state_read_30 int 32 regular  }
	{ state_read_31 int 32 regular  }
	{ state_read_32 int 32 regular  }
	{ state_read_33 int 32 regular  }
	{ state_read_34 int 32 regular  }
	{ state_read_35 int 32 regular  }
	{ state_read_36 int 32 regular  }
	{ block_words_read int 32 regular  }
	{ block_words_read_38 int 32 regular  }
	{ block_words_read_39 int 32 regular  }
	{ block_words_read_40 int 32 regular  }
	{ block_words_read_41 int 32 regular  }
	{ block_words_read_42 int 32 regular  }
	{ block_words_read_43 int 32 regular  }
	{ block_words_read_44 int 32 regular  }
	{ block_words_read_45 int 32 regular  }
	{ block_words_read_46 int 32 regular  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "state_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "state_read_30", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "state_read_31", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "state_read_32", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "state_read_33", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "state_read_34", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "state_read_35", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "state_read_36", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_read_38", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_read_39", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_read_40", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_read_41", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_read_42", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_read_43", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_read_44", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_read_45", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_read_46", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "ap_return", "interface" : "wire", "bitwidth" : 256} ]}
# RTL Port declarations: 
set portNum 32
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ state_read sc_in sc_lv 32 signal 0 } 
	{ state_read_30 sc_in sc_lv 32 signal 1 } 
	{ state_read_31 sc_in sc_lv 32 signal 2 } 
	{ state_read_32 sc_in sc_lv 32 signal 3 } 
	{ state_read_33 sc_in sc_lv 32 signal 4 } 
	{ state_read_34 sc_in sc_lv 32 signal 5 } 
	{ state_read_35 sc_in sc_lv 32 signal 6 } 
	{ state_read_36 sc_in sc_lv 32 signal 7 } 
	{ block_words_read sc_in sc_lv 32 signal 8 } 
	{ block_words_read_38 sc_in sc_lv 32 signal 9 } 
	{ block_words_read_39 sc_in sc_lv 32 signal 10 } 
	{ block_words_read_40 sc_in sc_lv 32 signal 11 } 
	{ block_words_read_41 sc_in sc_lv 32 signal 12 } 
	{ block_words_read_42 sc_in sc_lv 32 signal 13 } 
	{ block_words_read_43 sc_in sc_lv 32 signal 14 } 
	{ block_words_read_44 sc_in sc_lv 32 signal 15 } 
	{ block_words_read_45 sc_in sc_lv 32 signal 16 } 
	{ block_words_read_46 sc_in sc_lv 32 signal 17 } 
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
 	{ "name": "state_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "state_read", "role": "default" }} , 
 	{ "name": "state_read_30", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "state_read_30", "role": "default" }} , 
 	{ "name": "state_read_31", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "state_read_31", "role": "default" }} , 
 	{ "name": "state_read_32", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "state_read_32", "role": "default" }} , 
 	{ "name": "state_read_33", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "state_read_33", "role": "default" }} , 
 	{ "name": "state_read_34", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "state_read_34", "role": "default" }} , 
 	{ "name": "state_read_35", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "state_read_35", "role": "default" }} , 
 	{ "name": "state_read_36", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "state_read_36", "role": "default" }} , 
 	{ "name": "block_words_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_read", "role": "default" }} , 
 	{ "name": "block_words_read_38", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_read_38", "role": "default" }} , 
 	{ "name": "block_words_read_39", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_read_39", "role": "default" }} , 
 	{ "name": "block_words_read_40", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_read_40", "role": "default" }} , 
 	{ "name": "block_words_read_41", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_read_41", "role": "default" }} , 
 	{ "name": "block_words_read_42", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_read_42", "role": "default" }} , 
 	{ "name": "block_words_read_43", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_read_43", "role": "default" }} , 
 	{ "name": "block_words_read_44", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_read_44", "role": "default" }} , 
 	{ "name": "block_words_read_45", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_read_45", "role": "default" }} , 
 	{ "name": "block_words_read_46", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_read_46", "role": "default" }} , 
 	{ "name": "ap_return_0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_0", "role": "default" }} , 
 	{ "name": "ap_return_1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_1", "role": "default" }} , 
 	{ "name": "ap_return_2", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_2", "role": "default" }} , 
 	{ "name": "ap_return_3", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_3", "role": "default" }} , 
 	{ "name": "ap_return_4", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_4", "role": "default" }} , 
 	{ "name": "ap_return_5", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_5", "role": "default" }} , 
 	{ "name": "ap_return_6", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_6", "role": "default" }} , 
 	{ "name": "ap_return_7", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return_7", "role": "default" }}  ]}

set ArgLastReadFirstWriteLatency {
	sha256_compress_words {
		state_read {Type I LastRead 2 FirstWrite -1}
		state_read_30 {Type I LastRead 2 FirstWrite -1}
		state_read_31 {Type I LastRead 2 FirstWrite -1}
		state_read_32 {Type I LastRead 2 FirstWrite -1}
		state_read_33 {Type I LastRead 2 FirstWrite -1}
		state_read_34 {Type I LastRead 2 FirstWrite -1}
		state_read_35 {Type I LastRead 2 FirstWrite -1}
		state_read_36 {Type I LastRead 2 FirstWrite -1}
		block_words_read {Type I LastRead 0 FirstWrite -1}
		block_words_read_38 {Type I LastRead 0 FirstWrite -1}
		block_words_read_39 {Type I LastRead 0 FirstWrite -1}
		block_words_read_40 {Type I LastRead 0 FirstWrite -1}
		block_words_read_41 {Type I LastRead 0 FirstWrite -1}
		block_words_read_42 {Type I LastRead 0 FirstWrite -1}
		block_words_read_43 {Type I LastRead 0 FirstWrite -1}
		block_words_read_44 {Type I LastRead 0 FirstWrite -1}
		block_words_read_45 {Type I LastRead 0 FirstWrite -1}
		block_words_read_46 {Type I LastRead 0 FirstWrite -1}
		K {Type I LastRead -1 FirstWrite -1}}
	sha256_compress_words_Pipeline_LOAD_INITIAL_WORDS {
		block_words_read {Type I LastRead 0 FirstWrite -1}
		block_words_read_10 {Type I LastRead 0 FirstWrite -1}
		block_words_read_11 {Type I LastRead 0 FirstWrite -1}
		block_words_read_12 {Type I LastRead 0 FirstWrite -1}
		block_words_read_13 {Type I LastRead 0 FirstWrite -1}
		block_words_read_14 {Type I LastRead 0 FirstWrite -1}
		block_words_read_15 {Type I LastRead 0 FirstWrite -1}
		block_words_read_16 {Type I LastRead 0 FirstWrite -1}
		block_words_read_17 {Type I LastRead 0 FirstWrite -1}
		block_words_read_18 {Type I LastRead 0 FirstWrite -1}
		w_80_out {Type O LastRead -1 FirstWrite 0}
		w_79_out {Type O LastRead -1 FirstWrite 0}
		w_78_out {Type O LastRead -1 FirstWrite 0}
		w_77_out {Type O LastRead -1 FirstWrite 0}
		w_76_out {Type O LastRead -1 FirstWrite 0}
		w_75_out {Type O LastRead -1 FirstWrite 0}
		w_74_out {Type O LastRead -1 FirstWrite 0}
		w_73_out {Type O LastRead -1 FirstWrite 0}
		w_72_out {Type O LastRead -1 FirstWrite 0}
		w_71_out {Type O LastRead -1 FirstWrite 0}
		w_70_out {Type O LastRead -1 FirstWrite 0}
		w_69_out {Type O LastRead -1 FirstWrite 0}
		w_68_out {Type O LastRead -1 FirstWrite 0}
		w_67_out {Type O LastRead -1 FirstWrite 0}
		w_66_out {Type O LastRead -1 FirstWrite 0}
		w_out {Type O LastRead -1 FirstWrite 0}}
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
	{"Name" : "Latency", "Min" : "90", "Max" : "90"}
	, {"Name" : "Interval", "Min" : "90", "Max" : "90"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	state_read { ap_none {  { state_read in_data 0 32 } } }
	state_read_30 { ap_none {  { state_read_30 in_data 0 32 } } }
	state_read_31 { ap_none {  { state_read_31 in_data 0 32 } } }
	state_read_32 { ap_none {  { state_read_32 in_data 0 32 } } }
	state_read_33 { ap_none {  { state_read_33 in_data 0 32 } } }
	state_read_34 { ap_none {  { state_read_34 in_data 0 32 } } }
	state_read_35 { ap_none {  { state_read_35 in_data 0 32 } } }
	state_read_36 { ap_none {  { state_read_36 in_data 0 32 } } }
	block_words_read { ap_none {  { block_words_read in_data 0 32 } } }
	block_words_read_38 { ap_none {  { block_words_read_38 in_data 0 32 } } }
	block_words_read_39 { ap_none {  { block_words_read_39 in_data 0 32 } } }
	block_words_read_40 { ap_none {  { block_words_read_40 in_data 0 32 } } }
	block_words_read_41 { ap_none {  { block_words_read_41 in_data 0 32 } } }
	block_words_read_42 { ap_none {  { block_words_read_42 in_data 0 32 } } }
	block_words_read_43 { ap_none {  { block_words_read_43 in_data 0 32 } } }
	block_words_read_44 { ap_none {  { block_words_read_44 in_data 0 32 } } }
	block_words_read_45 { ap_none {  { block_words_read_45 in_data 0 32 } } }
	block_words_read_46 { ap_none {  { block_words_read_46 in_data 0 32 } } }
}
