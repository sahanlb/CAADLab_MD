module eSRAM_test (
		input  wire [35:0] c0_data_0,       //  ram_input.s2c0_da_0
		input  wire [14:0] c0_rdaddress_0,  //           .s2c0_adrb_0
		input  wire        c0_rden_n_0,     //           .s2c0_meb_n_0
		input  wire        c0_sd_n_0,       //           .s2c0_sd_n_0
		input  wire [14:0] c0_wraddress_0,  //           .s2c0_adra_0
		input  wire        c0_wren_n_0,     //           .s2c0_mea_n_0
		input  wire [35:0] c1_data_0,       //           .s2c1_da_0
		input  wire [14:0] c1_rdaddress_0,  //           .s2c1_adrb_0
		input  wire        c1_rden_n_0,     //           .s2c1_meb_n_0
		input  wire        c1_sd_n_0,       //           .s2c1_sd_n_0
		input  wire [14:0] c1_wraddress_0,  //           .s2c1_adra_0
		input  wire        c1_wren_n_0,     //           .s2c1_mea_n_0
		input  wire [35:0] c2_data_0,       //           .s2c2_da_0
		input  wire [14:0] c2_rdaddress_0,  //           .s2c2_adrb_0
		input  wire        c2_rden_n_0,     //           .s2c2_meb_n_0
		input  wire        c2_sd_n_0,       //           .s2c2_sd_n_0
		input  wire [14:0] c2_wraddress_0,  //           .s2c2_adra_0
		input  wire        c2_wren_n_0,     //           .s2c2_mea_n_0
		input  wire        refclk,          //           .clock
		output wire [35:0] c0_q_0,          // ram_output.s2c0_qb_0
		output wire [35:0] c1_q_0,          //           .s2c1_qb_0
		output wire [35:0] c2_q_0,          //           .s2c2_qb_0
		output wire        esram2f_clk,     //           .esram2f_clk
		output wire        iopll_lock2core  //           .iopll_lock2core
	);
endmodule

