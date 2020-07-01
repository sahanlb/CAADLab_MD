module DualPort_RAM_Test (
		input  wire [95:0] data,      //  ram_input.datain
		input  wire [8:0]  wraddress, //           .wraddress
		input  wire [8:0]  rdaddress, //           .rdaddress
		input  wire        wren,      //           .wren
		input  wire        clock,     //           .clock
		output wire [95:0] q          // ram_output.dataout
	);
endmodule

