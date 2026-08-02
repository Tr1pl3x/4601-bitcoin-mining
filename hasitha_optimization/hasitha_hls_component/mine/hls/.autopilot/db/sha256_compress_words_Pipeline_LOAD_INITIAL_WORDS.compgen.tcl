# This script segment is generated automatically by AutoPilot

# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 106 \
    name block_words_read \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_block_words_read \
    op interface \
    ports { block_words_read { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 107 \
    name block_words_read_10 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_block_words_read_10 \
    op interface \
    ports { block_words_read_10 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 108 \
    name block_words_read_11 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_block_words_read_11 \
    op interface \
    ports { block_words_read_11 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 109 \
    name block_words_read_12 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_block_words_read_12 \
    op interface \
    ports { block_words_read_12 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 110 \
    name block_words_read_13 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_block_words_read_13 \
    op interface \
    ports { block_words_read_13 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 111 \
    name block_words_read_14 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_block_words_read_14 \
    op interface \
    ports { block_words_read_14 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 112 \
    name block_words_read_15 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_block_words_read_15 \
    op interface \
    ports { block_words_read_15 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 113 \
    name block_words_read_16 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_block_words_read_16 \
    op interface \
    ports { block_words_read_16 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 114 \
    name block_words_read_17 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_block_words_read_17 \
    op interface \
    ports { block_words_read_17 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 115 \
    name block_words_read_18 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_block_words_read_18 \
    op interface \
    ports { block_words_read_18 { I 10 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 116 \
    name w_80_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_w_80_out \
    op interface \
    ports { w_80_out { O 32 vector } w_80_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 117 \
    name w_79_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_w_79_out \
    op interface \
    ports { w_79_out { O 32 vector } w_79_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 118 \
    name w_78_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_w_78_out \
    op interface \
    ports { w_78_out { O 32 vector } w_78_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 119 \
    name w_77_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_w_77_out \
    op interface \
    ports { w_77_out { O 32 vector } w_77_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 120 \
    name w_76_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_w_76_out \
    op interface \
    ports { w_76_out { O 32 vector } w_76_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 121 \
    name w_75_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_w_75_out \
    op interface \
    ports { w_75_out { O 32 vector } w_75_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 122 \
    name w_74_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_w_74_out \
    op interface \
    ports { w_74_out { O 32 vector } w_74_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 123 \
    name w_73_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_w_73_out \
    op interface \
    ports { w_73_out { O 32 vector } w_73_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 124 \
    name w_72_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_w_72_out \
    op interface \
    ports { w_72_out { O 32 vector } w_72_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 125 \
    name w_71_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_w_71_out \
    op interface \
    ports { w_71_out { O 32 vector } w_71_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 126 \
    name w_70_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_w_70_out \
    op interface \
    ports { w_70_out { O 32 vector } w_70_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 127 \
    name w_69_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_w_69_out \
    op interface \
    ports { w_69_out { O 32 vector } w_69_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 128 \
    name w_68_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_w_68_out \
    op interface \
    ports { w_68_out { O 32 vector } w_68_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 129 \
    name w_67_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_w_67_out \
    op interface \
    ports { w_67_out { O 32 vector } w_67_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 130 \
    name w_66_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_w_66_out \
    op interface \
    ports { w_66_out { O 32 vector } w_66_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 131 \
    name w_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_w_out \
    op interface \
    ports { w_out { O 32 vector } w_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -1 \
    name ap_ctrl \
    type ap_ctrl \
    reset_level 1 \
    sync_rst true \
    corename ap_ctrl \
    op interface \
    ports { ap_start { I 1 bit } ap_ready { O 1 bit } ap_done { O 1 bit } ap_idle { O 1 bit } } \
} "
}


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -2 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_clk \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-113\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}


# Adapter definition:
set PortName ap_rst
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_reset] == "cg_default_interface_gen_reset"} {
eval "cg_default_interface_gen_reset { \
    id -3 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_rst \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-114\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}



# merge
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_end
    cg_default_interface_gen_bundle_end
    AESL_LIB_XILADAPTER::native_axis_end
}


# flow_control definition:
set InstName mine_flow_control_loop_pipe_sequential_init_U
set CompName mine_flow_control_loop_pipe_sequential_init
set name flow_control_loop_pipe_sequential_init
if {${::AESL::PGuard_autocg_gen} && ${::AESL::PGuard_autocg_ipmgen}} {
if {[info proc ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control] == "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control"} {
eval "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control { \
    name ${name} \
    prefix mine_ \
}"
} else {
puts "@W \[IMPL-107\] Cannot find ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control, check your platform lib"
}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $CompName BINDTYPE interface TYPE internal_upc_flow_control INSTNAME $InstName
}


