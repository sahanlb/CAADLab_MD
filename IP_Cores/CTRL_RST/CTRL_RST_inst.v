	CTRL_RST u0 (
		.data    (_connected_to_data_),    //   input,  width = 1,  ram_input.datain
		.address (_connected_to_address_), //   input,  width = 1,           .address
		.wren    (_connected_to_wren_),    //   input,  width = 1,           .wren
		.clock   (_connected_to_clock_),   //   input,  width = 1,           .clk
		.q       (_connected_to_q_)        //  output,  width = 1, ram_output.dataout
	);

