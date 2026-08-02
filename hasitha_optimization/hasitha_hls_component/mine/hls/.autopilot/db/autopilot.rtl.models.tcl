set SynModuleInfo {
  {SRCNAME mine_Pipeline_VITIS_LOOP_448_1 MODELNAME mine_Pipeline_VITIS_LOOP_448_1 RTLNAME mine_mine_Pipeline_VITIS_LOOP_448_1
    SUBMODULES {
      {MODELNAME mine_flow_control_loop_pipe_sequential_init RTLNAME mine_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME mine_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME mine_Pipeline_VITIS_LOOP_453_2 MODELNAME mine_Pipeline_VITIS_LOOP_453_2 RTLNAME mine_mine_Pipeline_VITIS_LOOP_453_2}
  {SRCNAME mine_Pipeline_BUILD_FIRST_BLOCK MODELNAME mine_Pipeline_BUILD_FIRST_BLOCK RTLNAME mine_mine_Pipeline_BUILD_FIRST_BLOCK}
  {SRCNAME sha256_compress_words.1_Pipeline_LOAD_INITIAL_WORDS MODELNAME sha256_compress_words_1_Pipeline_LOAD_INITIAL_WORDS RTLNAME mine_sha256_compress_words_1_Pipeline_LOAD_INITIAL_WORDS
    SUBMODULES {
      {MODELNAME mine_sparsemux_33_4_32_1_1 RTLNAME mine_sparsemux_33_4_32_1_1 BINDTYPE op TYPE sparsemux IMPL compactencoding_dontcare}
    }
  }
  {SRCNAME sha256_compress_words.1_Pipeline_SHA256_ROUNDS MODELNAME sha256_compress_words_1_Pipeline_SHA256_ROUNDS RTLNAME mine_sha256_compress_words_1_Pipeline_SHA256_ROUNDS
    SUBMODULES {
      {MODELNAME mine_sparsemux_33_4_32_1_1_x RTLNAME mine_sparsemux_33_4_32_1_1_x BINDTYPE op TYPE sparsemux IMPL compactencoding_dontcare}
      {MODELNAME mine_sha256_compress_words_1_Pipeline_SHA256_ROUNDS_K_ROM_AUTO_1R RTLNAME mine_sha256_compress_words_1_Pipeline_SHA256_ROUNDS_K_ROM_AUTO_1R BINDTYPE storage TYPE rom IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME sha256_compress_words.1 MODELNAME sha256_compress_words_1 RTLNAME mine_sha256_compress_words_1}
  {SRCNAME sha256_compress_words_Pipeline_LOAD_INITIAL_WORDS MODELNAME sha256_compress_words_Pipeline_LOAD_INITIAL_WORDS RTLNAME mine_sha256_compress_words_Pipeline_LOAD_INITIAL_WORDS}
  {SRCNAME sha256_compress_words_Pipeline_SHA256_ROUNDS MODELNAME sha256_compress_words_Pipeline_SHA256_ROUNDS RTLNAME mine_sha256_compress_words_Pipeline_SHA256_ROUNDS}
  {SRCNAME sha256_compress_words MODELNAME sha256_compress_words RTLNAME mine_sha256_compress_words}
  {SRCNAME sha256d_from_midstate MODELNAME sha256d_from_midstate RTLNAME mine_sha256d_from_midstate}
  {SRCNAME mine_Pipeline_COMPARE_HASH MODELNAME mine_Pipeline_COMPARE_HASH RTLNAME mine_mine_Pipeline_COMPARE_HASH}
  {SRCNAME mine MODELNAME mine RTLNAME mine IS_TOP 1
    SUBMODULES {
      {MODELNAME mine_hdr_RAM_AUTO_1R1W RTLNAME mine_hdr_RAM_AUTO_1R1W BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME mine_tgt_RAM_AUTO_1R1W RTLNAME mine_tgt_RAM_AUTO_1R1W BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME mine_h_RAM_AUTO_1R1W RTLNAME mine_h_RAM_AUTO_1R1W BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME mine_gmem0_m_axi RTLNAME mine_gmem0_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME mine_gmem1_m_axi RTLNAME mine_gmem1_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME mine_gmem2_m_axi RTLNAME mine_gmem2_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME mine_control_s_axi RTLNAME mine_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
    }
  }
}
