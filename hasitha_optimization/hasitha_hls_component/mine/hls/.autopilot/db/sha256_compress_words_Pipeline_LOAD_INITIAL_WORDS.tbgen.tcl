set moduleName sha256_compress_words_Pipeline_LOAD_INITIAL_WORDS
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
set C_modelName {sha256_compress_words_Pipeline_LOAD_INITIAL_WORDS}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ block_words_read int 32 regular  }
	{ block_words_read_10 int 32 regular  }
	{ block_words_read_11 int 32 regular  }
	{ block_words_read_12 int 32 regular  }
	{ block_words_read_13 int 32 regular  }
	{ block_words_read_14 int 32 regular  }
	{ block_words_read_15 int 32 regular  }
	{ block_words_read_16 int 32 regular  }
	{ block_words_read_17 int 32 regular  }
	{ block_words_read_18 int 10 regular  }
	{ w_80_out int 32 regular {pointer 1}  }
	{ w_79_out int 32 regular {pointer 1}  }
	{ w_78_out int 32 regular {pointer 1}  }
	{ w_77_out int 32 regular {pointer 1}  }
	{ w_76_out int 32 regular {pointer 1}  }
	{ w_75_out int 32 regular {pointer 1}  }
	{ w_74_out int 32 regular {pointer 1}  }
	{ w_73_out int 32 regular {pointer 1}  }
	{ w_72_out int 32 regular {pointer 1}  }
	{ w_71_out int 32 regular {pointer 1}  }
	{ w_70_out int 32 regular {pointer 1}  }
	{ w_69_out int 32 regular {pointer 1}  }
	{ w_68_out int 32 regular {pointer 1}  }
	{ w_67_out int 32 regular {pointer 1}  }
	{ w_66_out int 32 regular {pointer 1}  }
	{ w_out int 32 regular {pointer 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "block_words_read", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_read_10", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_read_11", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_read_12", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_read_13", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_read_14", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_read_15", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_read_16", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_read_17", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "block_words_read_18", "interface" : "wire", "bitwidth" : 10, "direction" : "READONLY"} , 
 	{ "Name" : "w_80_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_79_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_78_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_77_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_76_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_75_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_74_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_73_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_72_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_71_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_70_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_69_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_68_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_67_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_66_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "w_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 48
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ block_words_read sc_in sc_lv 32 signal 0 } 
	{ block_words_read_10 sc_in sc_lv 32 signal 1 } 
	{ block_words_read_11 sc_in sc_lv 32 signal 2 } 
	{ block_words_read_12 sc_in sc_lv 32 signal 3 } 
	{ block_words_read_13 sc_in sc_lv 32 signal 4 } 
	{ block_words_read_14 sc_in sc_lv 32 signal 5 } 
	{ block_words_read_15 sc_in sc_lv 32 signal 6 } 
	{ block_words_read_16 sc_in sc_lv 32 signal 7 } 
	{ block_words_read_17 sc_in sc_lv 32 signal 8 } 
	{ block_words_read_18 sc_in sc_lv 10 signal 9 } 
	{ w_80_out sc_out sc_lv 32 signal 10 } 
	{ w_80_out_ap_vld sc_out sc_logic 1 outvld 10 } 
	{ w_79_out sc_out sc_lv 32 signal 11 } 
	{ w_79_out_ap_vld sc_out sc_logic 1 outvld 11 } 
	{ w_78_out sc_out sc_lv 32 signal 12 } 
	{ w_78_out_ap_vld sc_out sc_logic 1 outvld 12 } 
	{ w_77_out sc_out sc_lv 32 signal 13 } 
	{ w_77_out_ap_vld sc_out sc_logic 1 outvld 13 } 
	{ w_76_out sc_out sc_lv 32 signal 14 } 
	{ w_76_out_ap_vld sc_out sc_logic 1 outvld 14 } 
	{ w_75_out sc_out sc_lv 32 signal 15 } 
	{ w_75_out_ap_vld sc_out sc_logic 1 outvld 15 } 
	{ w_74_out sc_out sc_lv 32 signal 16 } 
	{ w_74_out_ap_vld sc_out sc_logic 1 outvld 16 } 
	{ w_73_out sc_out sc_lv 32 signal 17 } 
	{ w_73_out_ap_vld sc_out sc_logic 1 outvld 17 } 
	{ w_72_out sc_out sc_lv 32 signal 18 } 
	{ w_72_out_ap_vld sc_out sc_logic 1 outvld 18 } 
	{ w_71_out sc_out sc_lv 32 signal 19 } 
	{ w_71_out_ap_vld sc_out sc_logic 1 outvld 19 } 
	{ w_70_out sc_out sc_lv 32 signal 20 } 
	{ w_70_out_ap_vld sc_out sc_logic 1 outvld 20 } 
	{ w_69_out sc_out sc_lv 32 signal 21 } 
	{ w_69_out_ap_vld sc_out sc_logic 1 outvld 21 } 
	{ w_68_out sc_out sc_lv 32 signal 22 } 
	{ w_68_out_ap_vld sc_out sc_logic 1 outvld 22 } 
	{ w_67_out sc_out sc_lv 32 signal 23 } 
	{ w_67_out_ap_vld sc_out sc_logic 1 outvld 23 } 
	{ w_66_out sc_out sc_lv 32 signal 24 } 
	{ w_66_out_ap_vld sc_out sc_logic 1 outvld 24 } 
	{ w_out sc_out sc_lv 32 signal 25 } 
	{ w_out_ap_vld sc_out sc_logic 1 outvld 25 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "block_words_read", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_read", "role": "default" }} , 
 	{ "name": "block_words_read_10", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_read_10", "role": "default" }} , 
 	{ "name": "block_words_read_11", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_read_11", "role": "default" }} , 
 	{ "name": "block_words_read_12", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_read_12", "role": "default" }} , 
 	{ "name": "block_words_read_13", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_read_13", "role": "default" }} , 
 	{ "name": "block_words_read_14", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_read_14", "role": "default" }} , 
 	{ "name": "block_words_read_15", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_read_15", "role": "default" }} , 
 	{ "name": "block_words_read_16", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_read_16", "role": "default" }} , 
 	{ "name": "block_words_read_17", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "block_words_read_17", "role": "default" }} , 
 	{ "name": "block_words_read_18", "direction": "in", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "block_words_read_18", "role": "default" }} , 
 	{ "name": "w_80_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_80_out", "role": "default" }} , 
 	{ "name": "w_80_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_80_out", "role": "ap_vld" }} , 
 	{ "name": "w_79_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_79_out", "role": "default" }} , 
 	{ "name": "w_79_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_79_out", "role": "ap_vld" }} , 
 	{ "name": "w_78_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_78_out", "role": "default" }} , 
 	{ "name": "w_78_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_78_out", "role": "ap_vld" }} , 
 	{ "name": "w_77_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_77_out", "role": "default" }} , 
 	{ "name": "w_77_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_77_out", "role": "ap_vld" }} , 
 	{ "name": "w_76_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_76_out", "role": "default" }} , 
 	{ "name": "w_76_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_76_out", "role": "ap_vld" }} , 
 	{ "name": "w_75_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_75_out", "role": "default" }} , 
 	{ "name": "w_75_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_75_out", "role": "ap_vld" }} , 
 	{ "name": "w_74_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_74_out", "role": "default" }} , 
 	{ "name": "w_74_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_74_out", "role": "ap_vld" }} , 
 	{ "name": "w_73_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_73_out", "role": "default" }} , 
 	{ "name": "w_73_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_73_out", "role": "ap_vld" }} , 
 	{ "name": "w_72_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_72_out", "role": "default" }} , 
 	{ "name": "w_72_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_72_out", "role": "ap_vld" }} , 
 	{ "name": "w_71_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_71_out", "role": "default" }} , 
 	{ "name": "w_71_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_71_out", "role": "ap_vld" }} , 
 	{ "name": "w_70_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_70_out", "role": "default" }} , 
 	{ "name": "w_70_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_70_out", "role": "ap_vld" }} , 
 	{ "name": "w_69_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_69_out", "role": "default" }} , 
 	{ "name": "w_69_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_69_out", "role": "ap_vld" }} , 
 	{ "name": "w_68_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_68_out", "role": "default" }} , 
 	{ "name": "w_68_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_68_out", "role": "ap_vld" }} , 
 	{ "name": "w_67_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_67_out", "role": "default" }} , 
 	{ "name": "w_67_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_67_out", "role": "ap_vld" }} , 
 	{ "name": "w_66_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_66_out", "role": "default" }} , 
 	{ "name": "w_66_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_66_out", "role": "ap_vld" }} , 
 	{ "name": "w_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "w_out", "role": "default" }} , 
 	{ "name": "w_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "w_out", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
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
		w_out {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "18", "Max" : "18"}
	, {"Name" : "Interval", "Min" : "17", "Max" : "17"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	block_words_read { ap_none {  { block_words_read in_data 0 32 } } }
	block_words_read_10 { ap_none {  { block_words_read_10 in_data 0 32 } } }
	block_words_read_11 { ap_none {  { block_words_read_11 in_data 0 32 } } }
	block_words_read_12 { ap_none {  { block_words_read_12 in_data 0 32 } } }
	block_words_read_13 { ap_none {  { block_words_read_13 in_data 0 32 } } }
	block_words_read_14 { ap_none {  { block_words_read_14 in_data 0 32 } } }
	block_words_read_15 { ap_none {  { block_words_read_15 in_data 0 32 } } }
	block_words_read_16 { ap_none {  { block_words_read_16 in_data 0 32 } } }
	block_words_read_17 { ap_none {  { block_words_read_17 in_data 0 32 } } }
	block_words_read_18 { ap_none {  { block_words_read_18 in_data 0 10 } } }
	w_80_out { ap_vld {  { w_80_out out_data 1 32 }  { w_80_out_ap_vld out_vld 1 1 } } }
	w_79_out { ap_vld {  { w_79_out out_data 1 32 }  { w_79_out_ap_vld out_vld 1 1 } } }
	w_78_out { ap_vld {  { w_78_out out_data 1 32 }  { w_78_out_ap_vld out_vld 1 1 } } }
	w_77_out { ap_vld {  { w_77_out out_data 1 32 }  { w_77_out_ap_vld out_vld 1 1 } } }
	w_76_out { ap_vld {  { w_76_out out_data 1 32 }  { w_76_out_ap_vld out_vld 1 1 } } }
	w_75_out { ap_vld {  { w_75_out out_data 1 32 }  { w_75_out_ap_vld out_vld 1 1 } } }
	w_74_out { ap_vld {  { w_74_out out_data 1 32 }  { w_74_out_ap_vld out_vld 1 1 } } }
	w_73_out { ap_vld {  { w_73_out out_data 1 32 }  { w_73_out_ap_vld out_vld 1 1 } } }
	w_72_out { ap_vld {  { w_72_out out_data 1 32 }  { w_72_out_ap_vld out_vld 1 1 } } }
	w_71_out { ap_vld {  { w_71_out out_data 1 32 }  { w_71_out_ap_vld out_vld 1 1 } } }
	w_70_out { ap_vld {  { w_70_out out_data 1 32 }  { w_70_out_ap_vld out_vld 1 1 } } }
	w_69_out { ap_vld {  { w_69_out out_data 1 32 }  { w_69_out_ap_vld out_vld 1 1 } } }
	w_68_out { ap_vld {  { w_68_out out_data 1 32 }  { w_68_out_ap_vld out_vld 1 1 } } }
	w_67_out { ap_vld {  { w_67_out out_data 1 32 }  { w_67_out_ap_vld out_vld 1 1 } } }
	w_66_out { ap_vld {  { w_66_out out_data 1 32 }  { w_66_out_ap_vld out_vld 1 1 } } }
	w_out { ap_vld {  { w_out out_data 1 32 }  { w_out_ap_vld out_vld 1 1 } } }
}
