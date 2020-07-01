	RAM_DualPort u0 (
		.data      (_connected_to_data_),      //   input,  width = 12288,  ram_input.datain
		.wraddress (_connected_to_wraddress_), //   input,      width = 5,           .wraddress
		.rdaddress (_connected_to_rdaddress_), //   input,     width = 10,           .rdaddress
		.wren      (_connected_to_wren_),      //   input,      width = 1,           .wren
		.clock     (_connected_to_clock_),     //   input,      width = 1,           .clock
		.q         (_connected_to_q_)          //  output,    width = 384, ram_output.dataout
	);

