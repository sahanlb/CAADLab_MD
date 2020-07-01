module RAM_DualPort (
		input  wire [12287:0] data,      //  ram_input.datain
		input  wire [4:0]     wraddress, //           .wraddress
		input  wire [9:0]     rdaddress, //           .rdaddress
		input  wire           wren,      //           .wren
		input  wire           clock,     //           .clock
		output wire [383:0]   q          // ram_output.dataout
	);
endmodule

