# This script segment is generated automatically by AutoPilot

# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 6 \
    name hdr \
    reset_level 1 \
    sync_rst true \
    dir I \
    corename hdr \
    op interface \
    ports { hdr_address0 { O 5 vector } hdr_ce0 { O 1 bit } hdr_q0 { I 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'hdr'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 7 \
    name or7_i_i37_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_or7_i_i37_out \
    op interface \
    ports { or7_i_i37_out { O 32 vector } or7_i_i37_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 8 \
    name or7_i_i35_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_or7_i_i35_out \
    op interface \
    ports { or7_i_i35_out { O 32 vector } or7_i_i35_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 9 \
    name or7_i_i33_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_or7_i_i33_out \
    op interface \
    ports { or7_i_i33_out { O 32 vector } or7_i_i33_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10 \
    name or7_i_i31_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_or7_i_i31_out \
    op interface \
    ports { or7_i_i31_out { O 32 vector } or7_i_i31_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 11 \
    name or7_i_i29_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_or7_i_i29_out \
    op interface \
    ports { or7_i_i29_out { O 32 vector } or7_i_i29_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 12 \
    name or7_i_i27_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_or7_i_i27_out \
    op interface \
    ports { or7_i_i27_out { O 32 vector } or7_i_i27_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 13 \
    name or7_i_i25_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_or7_i_i25_out \
    op interface \
    ports { or7_i_i25_out { O 32 vector } or7_i_i25_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 14 \
    name or7_i_i23_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_or7_i_i23_out \
    op interface \
    ports { or7_i_i23_out { O 32 vector } or7_i_i23_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 15 \
    name or7_i_i21_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_or7_i_i21_out \
    op interface \
    ports { or7_i_i21_out { O 32 vector } or7_i_i21_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 16 \
    name or7_i_i19_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_or7_i_i19_out \
    op interface \
    ports { or7_i_i19_out { O 32 vector } or7_i_i19_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 17 \
    name or7_i_i17_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_or7_i_i17_out \
    op interface \
    ports { or7_i_i17_out { O 32 vector } or7_i_i17_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 18 \
    name or7_i_i15_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_or7_i_i15_out \
    op interface \
    ports { or7_i_i15_out { O 32 vector } or7_i_i15_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 19 \
    name or7_i_i13_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_or7_i_i13_out \
    op interface \
    ports { or7_i_i13_out { O 32 vector } or7_i_i13_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 20 \
    name or7_i_i11_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_or7_i_i11_out \
    op interface \
    ports { or7_i_i11_out { O 32 vector } or7_i_i11_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 21 \
    name or7_i_i9_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_or7_i_i9_out \
    op interface \
    ports { or7_i_i9_out { O 32 vector } or7_i_i9_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 22 \
    name or7_i_i7_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_or7_i_i7_out \
    op interface \
    ports { or7_i_i7_out { O 32 vector } or7_i_i7_out_ap_vld { O 1 bit } } \
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


