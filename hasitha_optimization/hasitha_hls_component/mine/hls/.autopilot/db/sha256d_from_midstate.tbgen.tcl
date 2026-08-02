set moduleName sha256d_from_midstate
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
set C_modelName {sha256d_from_midstate}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict header_tail { MEM_WIDTH 32 MEM_SIZE 80 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict out_r { MEM_WIDTH 8 MEM_SIZE 32 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
set C_modelArgList {
	{ midstate_read int 32 regular  }
	{ midstate_read_15 int 32 regular  }
	{ midstate_read_16 int 32 regular  }
	{ midstate_read_17 int 32 regular  }
	{ midstate_read_18 int 32 regular  }
	{ midstate_read_19 int 32 regular  }
	{ midstate_read_20 int 32 regular  }
	{ midstate_read_21 int 32 regular  }
	{ header_tail int 32 regular {array 20 { 1 1 } 1 1 }  }
	{ out_r int 8 regular {array 32 { 0 0 } 0 1 }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "midstate_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "midstate_read_15", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "midstate_read_16", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "midstate_read_17", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "midstate_read_18", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "midstate_read_19", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "midstate_read_20", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "midstate_read_21", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "header_tail", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "out_r", "interface" : "memory", "bitwidth" : 8, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 28
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ midstate_read sc_in sc_lv 32 signal 0 } 
	{ midstate_read_15 sc_in sc_lv 32 signal 1 } 
	{ midstate_read_16 sc_in sc_lv 32 signal 2 } 
	{ midstate_read_17 sc_in sc_lv 32 signal 3 } 
	{ midstate_read_18 sc_in sc_lv 32 signal 4 } 
	{ midstate_read_19 sc_in sc_lv 32 signal 5 } 
	{ midstate_read_20 sc_in sc_lv 32 signal 6 } 
	{ midstate_read_21 sc_in sc_lv 32 signal 7 } 
	{ header_tail_address0 sc_out sc_lv 5 signal 8 } 
	{ header_tail_ce0 sc_out sc_logic 1 signal 8 } 
	{ header_tail_q0 sc_in sc_lv 32 signal 8 } 
	{ header_tail_address1 sc_out sc_lv 5 signal 8 } 
	{ header_tail_ce1 sc_out sc_logic 1 signal 8 } 
	{ header_tail_q1 sc_in sc_lv 32 signal 8 } 
	{ out_r_address0 sc_out sc_lv 5 signal 9 } 
	{ out_r_ce0 sc_out sc_logic 1 signal 9 } 
	{ out_r_we0 sc_out sc_logic 1 signal 9 } 
	{ out_r_d0 sc_out sc_lv 8 signal 9 } 
	{ out_r_address1 sc_out sc_lv 5 signal 9 } 
	{ out_r_ce1 sc_out sc_logic 1 signal 9 } 
	{ out_r_we1 sc_out sc_logic 1 signal 9 } 
	{ out_r_d1 sc_out sc_lv 8 signal 9 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "midstate_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "midstate_read", "role": "default" }} , 
 	{ "name": "midstate_read_15", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "midstate_read_15", "role": "default" }} , 
 	{ "name": "midstate_read_16", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "midstate_read_16", "role": "default" }} , 
 	{ "name": "midstate_read_17", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "midstate_read_17", "role": "default" }} , 
 	{ "name": "midstate_read_18", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "midstate_read_18", "role": "default" }} , 
 	{ "name": "midstate_read_19", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "midstate_read_19", "role": "default" }} , 
 	{ "name": "midstate_read_20", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "midstate_read_20", "role": "default" }} , 
 	{ "name": "midstate_read_21", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "midstate_read_21", "role": "default" }} , 
 	{ "name": "header_tail_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "header_tail", "role": "address0" }} , 
 	{ "name": "header_tail_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "header_tail", "role": "ce0" }} , 
 	{ "name": "header_tail_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "header_tail", "role": "q0" }} , 
 	{ "name": "header_tail_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "header_tail", "role": "address1" }} , 
 	{ "name": "header_tail_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "header_tail", "role": "ce1" }} , 
 	{ "name": "header_tail_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "header_tail", "role": "q1" }} , 
 	{ "name": "out_r_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "out_r", "role": "address0" }} , 
 	{ "name": "out_r_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_r", "role": "ce0" }} , 
 	{ "name": "out_r_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_r", "role": "we0" }} , 
 	{ "name": "out_r_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "out_r", "role": "d0" }} , 
 	{ "name": "out_r_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "out_r", "role": "address1" }} , 
 	{ "name": "out_r_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_r", "role": "ce1" }} , 
 	{ "name": "out_r_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "out_r", "role": "we1" }} , 
 	{ "name": "out_r_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "out_r", "role": "d1" }}  ]}

set ArgLastReadFirstWriteLatency {
	sha256d_from_midstate {
		midstate_read {Type I LastRead 2 FirstWrite -1}
		midstate_read_15 {Type I LastRead 2 FirstWrite -1}
		midstate_read_16 {Type I LastRead 2 FirstWrite -1}
		midstate_read_17 {Type I LastRead 2 FirstWrite -1}
		midstate_read_18 {Type I LastRead 2 FirstWrite -1}
		midstate_read_19 {Type I LastRead 2 FirstWrite -1}
		midstate_read_20 {Type I LastRead 2 FirstWrite -1}
		midstate_read_21 {Type I LastRead 2 FirstWrite -1}
		header_tail {Type I LastRead 2 FirstWrite -1}
		out_r {Type O LastRead -1 FirstWrite 4}
		K {Type I LastRead -1 FirstWrite -1}}
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
	{"Name" : "Latency", "Min" : "199", "Max" : "199"}
	, {"Name" : "Interval", "Min" : "199", "Max" : "199"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	midstate_read { ap_none {  { midstate_read in_data 0 32 } } }
	midstate_read_15 { ap_none {  { midstate_read_15 in_data 0 32 } } }
	midstate_read_16 { ap_none {  { midstate_read_16 in_data 0 32 } } }
	midstate_read_17 { ap_none {  { midstate_read_17 in_data 0 32 } } }
	midstate_read_18 { ap_none {  { midstate_read_18 in_data 0 32 } } }
	midstate_read_19 { ap_none {  { midstate_read_19 in_data 0 32 } } }
	midstate_read_20 { ap_none {  { midstate_read_20 in_data 0 32 } } }
	midstate_read_21 { ap_none {  { midstate_read_21 in_data 0 32 } } }
	header_tail { ap_memory {  { header_tail_address0 mem_address 1 5 }  { header_tail_ce0 mem_ce 1 1 }  { header_tail_q0 mem_dout 0 32 }  { header_tail_address1 MemPortADDR2 1 5 }  { header_tail_ce1 MemPortCE2 1 1 }  { header_tail_q1 MemPortDOUT2 0 32 } } }
	out_r { ap_memory {  { out_r_address0 mem_address 1 5 }  { out_r_ce0 mem_ce 1 1 }  { out_r_we0 mem_we 1 1 }  { out_r_d0 mem_din 1 8 }  { out_r_address1 MemPortADDR2 1 5 }  { out_r_ce1 MemPortCE2 1 1 }  { out_r_we1 MemPortWE2 1 1 }  { out_r_d1 MemPortDIN2 1 8 } } }
}
