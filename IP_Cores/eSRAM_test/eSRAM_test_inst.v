	eSRAM_test u0 (
		.c0_data_0       (_connected_to_c0_data_0_),       //   input,  width = 36,  ram_input.s2c0_da_0
		.c0_rdaddress_0  (_connected_to_c0_rdaddress_0_),  //   input,  width = 15,           .s2c0_adrb_0
		.c0_rden_n_0     (_connected_to_c0_rden_n_0_),     //   input,   width = 1,           .s2c0_meb_n_0
		.c0_sd_n_0       (_connected_to_c0_sd_n_0_),       //   input,   width = 1,           .s2c0_sd_n_0
		.c0_wraddress_0  (_connected_to_c0_wraddress_0_),  //   input,  width = 15,           .s2c0_adra_0
		.c0_wren_n_0     (_connected_to_c0_wren_n_0_),     //   input,   width = 1,           .s2c0_mea_n_0
		.c1_data_0       (_connected_to_c1_data_0_),       //   input,  width = 36,           .s2c1_da_0
		.c1_rdaddress_0  (_connected_to_c1_rdaddress_0_),  //   input,  width = 15,           .s2c1_adrb_0
		.c1_rden_n_0     (_connected_to_c1_rden_n_0_),     //   input,   width = 1,           .s2c1_meb_n_0
		.c1_sd_n_0       (_connected_to_c1_sd_n_0_),       //   input,   width = 1,           .s2c1_sd_n_0
		.c1_wraddress_0  (_connected_to_c1_wraddress_0_),  //   input,  width = 15,           .s2c1_adra_0
		.c1_wren_n_0     (_connected_to_c1_wren_n_0_),     //   input,   width = 1,           .s2c1_mea_n_0
		.c2_data_0       (_connected_to_c2_data_0_),       //   input,  width = 36,           .s2c2_da_0
		.c2_rdaddress_0  (_connected_to_c2_rdaddress_0_),  //   input,  width = 15,           .s2c2_adrb_0
		.c2_rden_n_0     (_connected_to_c2_rden_n_0_),     //   input,   width = 1,           .s2c2_meb_n_0
		.c2_sd_n_0       (_connected_to_c2_sd_n_0_),       //   input,   width = 1,           .s2c2_sd_n_0
		.c2_wraddress_0  (_connected_to_c2_wraddress_0_),  //   input,  width = 15,           .s2c2_adra_0
		.c2_wren_n_0     (_connected_to_c2_wren_n_0_),     //   input,   width = 1,           .s2c2_mea_n_0
		.refclk          (_connected_to_refclk_),          //   input,   width = 1,           .clock
		.c0_q_0          (_connected_to_c0_q_0_),          //  output,  width = 36, ram_output.s2c0_qb_0
		.c1_q_0          (_connected_to_c1_q_0_),          //  output,  width = 36,           .s2c1_qb_0
		.c2_q_0          (_connected_to_c2_q_0_),          //  output,  width = 36,           .s2c2_qb_0
		.esram2f_clk     (_connected_to_esram2f_clk_),     //  output,   width = 1,           .esram2f_clk
		.iopll_lock2core (_connected_to_iopll_lock2core_)  //  output,   width = 1,           .iopll_lock2core
	);

