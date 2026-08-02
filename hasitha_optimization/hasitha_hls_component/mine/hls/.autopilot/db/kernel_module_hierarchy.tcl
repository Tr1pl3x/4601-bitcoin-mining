set ModuleHierarchy {[{
"Name" : "mine", "RefName" : "mine","ID" : "0","Type" : "sequential",
"SubInsts" : [
	{"Name" : "grp_mine_Pipeline_VITIS_LOOP_448_1_fu_341", "RefName" : "mine_Pipeline_VITIS_LOOP_448_1","ID" : "1","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "VITIS_LOOP_448_1","RefName" : "VITIS_LOOP_448_1","ID" : "2","Type" : "pipeline"},]},
	{"Name" : "grp_mine_Pipeline_VITIS_LOOP_453_2_fu_349", "RefName" : "mine_Pipeline_VITIS_LOOP_453_2","ID" : "3","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "VITIS_LOOP_453_2","RefName" : "VITIS_LOOP_453_2","ID" : "4","Type" : "pipeline"},]},
	{"Name" : "grp_mine_Pipeline_BUILD_FIRST_BLOCK_fu_355", "RefName" : "mine_Pipeline_BUILD_FIRST_BLOCK","ID" : "5","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "BUILD_FIRST_BLOCK","RefName" : "BUILD_FIRST_BLOCK","ID" : "6","Type" : "pipeline"},]},
	{"Name" : "grp_sha256_compress_words_1_fu_376", "RefName" : "sha256_compress_words_1","ID" : "7","Type" : "sequential",
		"SubInsts" : [
		{"Name" : "grp_sha256_compress_words_1_Pipeline_LOAD_INITIAL_WORDS_fu_252", "RefName" : "sha256_compress_words_1_Pipeline_LOAD_INITIAL_WORDS","ID" : "8","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "LOAD_INITIAL_WORDS","RefName" : "LOAD_INITIAL_WORDS","ID" : "9","Type" : "pipeline"},]},
		{"Name" : "grp_sha256_compress_words_1_Pipeline_SHA256_ROUNDS_fu_304", "RefName" : "sha256_compress_words_1_Pipeline_SHA256_ROUNDS","ID" : "10","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "SHA256_ROUNDS","RefName" : "SHA256_ROUNDS","ID" : "11","Type" : "pipeline"},]},]},],
"SubLoops" : [
	{"Name" : "VITIS_LOOP_468_3","RefName" : "VITIS_LOOP_468_3","ID" : "12","Type" : "no",
	"SubInsts" : [
	{"Name" : "grp_sha256d_from_midstate_fu_398", "RefName" : "sha256d_from_midstate","ID" : "13","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_sha256_compress_words_fu_526", "RefName" : "sha256_compress_words","ID" : "14","Type" : "sequential",
				"SubInsts" : [
				{"Name" : "grp_sha256_compress_words_Pipeline_LOAD_INITIAL_WORDS_fu_252", "RefName" : "sha256_compress_words_Pipeline_LOAD_INITIAL_WORDS","ID" : "15","Type" : "sequential",
					"SubLoops" : [
					{"Name" : "LOAD_INITIAL_WORDS","RefName" : "LOAD_INITIAL_WORDS","ID" : "16","Type" : "pipeline"},]},
				{"Name" : "grp_sha256_compress_words_Pipeline_SHA256_ROUNDS_fu_291", "RefName" : "sha256_compress_words_Pipeline_SHA256_ROUNDS","ID" : "17","Type" : "sequential",
					"SubLoops" : [
					{"Name" : "SHA256_ROUNDS","RefName" : "SHA256_ROUNDS","ID" : "18","Type" : "pipeline"},]},]},]},
	{"Name" : "grp_mine_Pipeline_COMPARE_HASH_fu_414", "RefName" : "mine_Pipeline_COMPARE_HASH","ID" : "19","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "COMPARE_HASH","RefName" : "COMPARE_HASH","ID" : "20","Type" : "pipeline"},]},]},]
}]}