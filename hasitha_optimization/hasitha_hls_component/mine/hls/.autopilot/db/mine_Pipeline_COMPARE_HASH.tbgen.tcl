set moduleName mine_Pipeline_COMPARE_HASH
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
set C_modelName {mine_Pipeline_COMPARE_HASH}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict h { MEM_WIDTH 8 MEM_SIZE 32 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict tgt { MEM_WIDTH 32 MEM_SIZE 32 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ h int 8 regular {array 32 { 1 3 } 1 1 }  }
	{ tgt int 32 regular {array 8 { 1 3 } 1 1 }  }
	{ retval_1_i35_ce_out int 1 regular {pointer 1}  }
	{ cleanup_dest_slot_1_i_ce_out int 1 regular {pointer 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "h", "interface" : "memory", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "tgt", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "retval_1_i35_ce_out", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "cleanup_dest_slot_1_i_ce_out", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 16
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ h_address0 sc_out sc_lv 5 signal 0 } 
	{ h_ce0 sc_out sc_logic 1 signal 0 } 
	{ h_q0 sc_in sc_lv 8 signal 0 } 
	{ tgt_address0 sc_out sc_lv 3 signal 1 } 
	{ tgt_ce0 sc_out sc_logic 1 signal 1 } 
	{ tgt_q0 sc_in sc_lv 32 signal 1 } 
	{ retval_1_i35_ce_out sc_out sc_lv 1 signal 2 } 
	{ retval_1_i35_ce_out_ap_vld sc_out sc_logic 1 outvld 2 } 
	{ cleanup_dest_slot_1_i_ce_out sc_out sc_lv 1 signal 3 } 
	{ cleanup_dest_slot_1_i_ce_out_ap_vld sc_out sc_logic 1 outvld 3 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "h_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "h", "role": "address0" }} , 
 	{ "name": "h_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "h", "role": "ce0" }} , 
 	{ "name": "h_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "h", "role": "q0" }} , 
 	{ "name": "tgt_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "tgt", "role": "address0" }} , 
 	{ "name": "tgt_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "tgt", "role": "ce0" }} , 
 	{ "name": "tgt_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tgt", "role": "q0" }} , 
 	{ "name": "retval_1_i35_ce_out", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "retval_1_i35_ce_out", "role": "default" }} , 
 	{ "name": "retval_1_i35_ce_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "retval_1_i35_ce_out", "role": "ap_vld" }} , 
 	{ "name": "cleanup_dest_slot_1_i_ce_out", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "cleanup_dest_slot_1_i_ce_out", "role": "default" }} , 
 	{ "name": "cleanup_dest_slot_1_i_ce_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "cleanup_dest_slot_1_i_ce_out", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	mine_Pipeline_COMPARE_HASH {
		h {Type I LastRead 0 FirstWrite -1}
		tgt {Type I LastRead 0 FirstWrite -1}
		retval_1_i35_ce_out {Type O LastRead -1 FirstWrite 1}
		cleanup_dest_slot_1_i_ce_out {Type O LastRead -1 FirstWrite 1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "3", "Max" : "67"}
	, {"Name" : "Interval", "Min" : "2", "Max" : "66"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	h { ap_memory {  { h_address0 mem_address 1 5 }  { h_ce0 mem_ce 1 1 }  { h_q0 mem_dout 0 8 } } }
	tgt { ap_memory {  { tgt_address0 mem_address 1 3 }  { tgt_ce0 mem_ce 1 1 }  { tgt_q0 mem_dout 0 32 } } }
	retval_1_i35_ce_out { ap_vld {  { retval_1_i35_ce_out out_data 1 1 }  { retval_1_i35_ce_out_ap_vld out_vld 1 1 } } }
	cleanup_dest_slot_1_i_ce_out { ap_vld {  { cleanup_dest_slot_1_i_ce_out out_data 1 1 }  { cleanup_dest_slot_1_i_ce_out_ap_vld out_vld 1 1 } } }
}
