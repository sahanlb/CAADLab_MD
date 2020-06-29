module cell_select_mux_tree
#(
	parameter DATA_WIDTH = 32, 
	parameter NUM_CELLS = 64, 
	parameter FORCE_CACHE_WIDTH = 96, 
	parameter VELOCITY_CACHE_WIDTH = 96, 
	parameter POS_CACHE_WIDTH = 87, 
	parameter GLOBAL_CELL_ID_WIDTH = 6
)
(
	input clk, 
	input [NUM_CELLS*FORCE_CACHE_WIDTH-1:0] in_all_force_data,
	input [NUM_CELLS*VELOCITY_CACHE_WIDTH-1:0] in_all_velocity_data,
	input [NUM_CELLS*POS_CACHE_WIDTH-1:0] in_all_position_data,
	input [GLOBAL_CELL_ID_WIDTH-1:0] cell_counter, 
	output [FORCE_CACHE_WIDTH-1:0] in_force_data, 
	output [VELOCITY_CACHE_WIDTH-1:0] in_velocity_data, 
	output [POS_CACHE_WIDTH-1:0] in_position_data
);

reg [32*FORCE_CACHE_WIDTH-1:0] in_force_data_lv0;
reg [16*FORCE_CACHE_WIDTH-1:0] in_force_data_lv1;
reg [8*FORCE_CACHE_WIDTH-1:0] in_force_data_lv2;
reg [4*FORCE_CACHE_WIDTH-1:0] in_force_data_lv3;
reg [2*FORCE_CACHE_WIDTH-1:0] in_force_data_lv4;

reg [32*VELOCITY_CACHE_WIDTH-1:0] in_velocity_data_lv0;
reg [16*VELOCITY_CACHE_WIDTH-1:0] in_velocity_data_lv1;
reg [8*VELOCITY_CACHE_WIDTH-1:0] in_velocity_data_lv2;
reg [4*VELOCITY_CACHE_WIDTH-1:0] in_velocity_data_lv3;
reg [2*VELOCITY_CACHE_WIDTH-1:0] in_velocity_data_lv4;

reg [32*POS_CACHE_WIDTH-1:0] in_position_data_lv0;
reg [16*POS_CACHE_WIDTH-1:0] in_position_data_lv1;
reg [8*POS_CACHE_WIDTH-1:0] in_position_data_lv2;
reg [4*POS_CACHE_WIDTH-1:0] in_position_data_lv3;
reg [2*POS_CACHE_WIDTH-1:0] in_position_data_lv4;

reg [31:0] cell_counter_0;
reg [15:0] cell_counter_1;
reg [7:0] cell_counter_2;
reg [3:0] cell_counter_3;
reg [1:0] cell_counter_4;

always@(posedge clk)
	begin
	cell_counter_0 <= {32{cell_counter[0]}};
	cell_counter_1 <= {16{cell_counter[1]}};
	cell_counter_2 <= {8{cell_counter[2]}};
	cell_counter_3 <= {4{cell_counter[3]}};
	cell_counter_4 <= {2{cell_counter[4]}};
	end
//reg cell_counter_0_1;
//reg cell_counter_0_2;
//reg cell_counter_0_3;
//reg cell_counter_0_4;
//always@(posedge clk)
//	begin
//	cell_counter_0_1 <= cell_counter[0];
//	cell_counter_0_2 <= cell_counter[0];
//	cell_counter_0_3 <= cell_counter[0];
//	cell_counter_0_4 <= cell_counter[0];
//	end
	
	
genvar i;

// level 0: select 32 from 64
generate
	for (i = 0; i < 32; i = i + 1)
		begin: mux_lv0_force
		always@(posedge clk)
			begin
			if (cell_counter_0[i])		// odd
				begin
				in_force_data_lv0[(i+1)*FORCE_CACHE_WIDTH-1:i*FORCE_CACHE_WIDTH] <= in_all_force_data[2*(i+1)*FORCE_CACHE_WIDTH-1:(2*i+1)*FORCE_CACHE_WIDTH];
				in_velocity_data_lv0[(i+1)*VELOCITY_CACHE_WIDTH-1:i*VELOCITY_CACHE_WIDTH] <= in_all_velocity_data[2*(i+1)*VELOCITY_CACHE_WIDTH-1:(2*i+1)*VELOCITY_CACHE_WIDTH];
				in_position_data_lv0[(i+1)*POS_CACHE_WIDTH-1:i*POS_CACHE_WIDTH] <= in_all_position_data[2*(i+1)*POS_CACHE_WIDTH-1:(2*i+1)*POS_CACHE_WIDTH];
				end
			else							// even
				begin
				in_force_data_lv0[(i+1)*FORCE_CACHE_WIDTH-1:i*FORCE_CACHE_WIDTH] <= in_all_force_data[(2*i+1)*FORCE_CACHE_WIDTH-1:2*i*FORCE_CACHE_WIDTH];
				in_velocity_data_lv0[(i+1)*VELOCITY_CACHE_WIDTH-1:i*VELOCITY_CACHE_WIDTH] <= in_all_velocity_data[(2*i+1)*VELOCITY_CACHE_WIDTH-1:2*i*VELOCITY_CACHE_WIDTH];
				in_position_data_lv0[(i+1)*POS_CACHE_WIDTH-1:i*POS_CACHE_WIDTH] <= in_all_position_data[(2*i+1)*POS_CACHE_WIDTH-1:2*i*POS_CACHE_WIDTH];
				end
			end
		end
endgenerate



generate
	for (i = 0; i < 16; i = i + 1)
		begin: mux_lv1_force
		always@(posedge clk)
			begin
			if (cell_counter_1[i])		// odd
				begin
				in_force_data_lv1[(i+1)*FORCE_CACHE_WIDTH-1:i*FORCE_CACHE_WIDTH] <= in_force_data_lv0[2*(i+1)*FORCE_CACHE_WIDTH-1:(2*i+1)*FORCE_CACHE_WIDTH];
				in_velocity_data_lv1[(i+1)*VELOCITY_CACHE_WIDTH-1:i*VELOCITY_CACHE_WIDTH] <= in_velocity_data_lv0[2*(i+1)*VELOCITY_CACHE_WIDTH-1:(2*i+1)*VELOCITY_CACHE_WIDTH];
				in_position_data_lv1[(i+1)*POS_CACHE_WIDTH-1:i*POS_CACHE_WIDTH] <= in_position_data_lv0[2*(i+1)*POS_CACHE_WIDTH-1:(2*i+1)*POS_CACHE_WIDTH];
				end
			else							// even
				begin
				in_force_data_lv1[(i+1)*FORCE_CACHE_WIDTH-1:i*FORCE_CACHE_WIDTH] <= in_force_data_lv0[(2*i+1)*FORCE_CACHE_WIDTH-1:2*i*FORCE_CACHE_WIDTH];
				in_velocity_data_lv1[(i+1)*VELOCITY_CACHE_WIDTH-1:i*VELOCITY_CACHE_WIDTH] <= in_velocity_data_lv0[(2*i+1)*VELOCITY_CACHE_WIDTH-1:2*i*VELOCITY_CACHE_WIDTH];
				in_position_data_lv1[(i+1)*POS_CACHE_WIDTH-1:i*POS_CACHE_WIDTH] <= in_position_data_lv0[(2*i+1)*POS_CACHE_WIDTH-1:2*i*POS_CACHE_WIDTH];
				end
			end
		end
endgenerate


generate
	for (i = 0; i < 8; i = i + 1)
		begin: mux_lv2_force
		always@(posedge clk)
			begin
			if (cell_counter_2[i])		// odd
				begin
				in_force_data_lv2[(i+1)*FORCE_CACHE_WIDTH-1:i*FORCE_CACHE_WIDTH] <= in_force_data_lv1[2*(i+1)*FORCE_CACHE_WIDTH-1:(2*i+1)*FORCE_CACHE_WIDTH];
				in_velocity_data_lv2[(i+1)*VELOCITY_CACHE_WIDTH-1:i*VELOCITY_CACHE_WIDTH] <= in_velocity_data_lv1[2*(i+1)*VELOCITY_CACHE_WIDTH-1:(2*i+1)*VELOCITY_CACHE_WIDTH];
				in_position_data_lv2[(i+1)*POS_CACHE_WIDTH-1:i*POS_CACHE_WIDTH] <= in_position_data_lv1[2*(i+1)*POS_CACHE_WIDTH-1:(2*i+1)*POS_CACHE_WIDTH];
				end
			else							// even
				begin
				in_force_data_lv2[(i+1)*FORCE_CACHE_WIDTH-1:i*FORCE_CACHE_WIDTH] <= in_force_data_lv1[(2*i+1)*FORCE_CACHE_WIDTH-1:2*i*FORCE_CACHE_WIDTH];
				in_velocity_data_lv2[(i+1)*VELOCITY_CACHE_WIDTH-1:i*VELOCITY_CACHE_WIDTH] <= in_velocity_data_lv1[(2*i+1)*VELOCITY_CACHE_WIDTH-1:2*i*VELOCITY_CACHE_WIDTH];
				in_position_data_lv2[(i+1)*POS_CACHE_WIDTH-1:i*POS_CACHE_WIDTH] <= in_position_data_lv1[(2*i+1)*POS_CACHE_WIDTH-1:2*i*POS_CACHE_WIDTH];
				end
			end
		end
endgenerate

generate
	for (i = 0; i < 4; i = i + 1)
		begin: mux_lv3_force
		always@(posedge clk)
			begin
			if (cell_counter_3[i])		// odd
				begin
				in_force_data_lv3[(i+1)*FORCE_CACHE_WIDTH-1:i*FORCE_CACHE_WIDTH] <= in_force_data_lv2[2*(i+1)*FORCE_CACHE_WIDTH-1:(2*i+1)*FORCE_CACHE_WIDTH];
				in_velocity_data_lv3[(i+1)*VELOCITY_CACHE_WIDTH-1:i*VELOCITY_CACHE_WIDTH] <= in_velocity_data_lv2[2*(i+1)*VELOCITY_CACHE_WIDTH-1:(2*i+1)*VELOCITY_CACHE_WIDTH];
				in_position_data_lv3[(i+1)*POS_CACHE_WIDTH-1:i*POS_CACHE_WIDTH] <= in_position_data_lv2[2*(i+1)*POS_CACHE_WIDTH-1:(2*i+1)*POS_CACHE_WIDTH];
				end
			else							// even
				begin
				in_force_data_lv3[(i+1)*FORCE_CACHE_WIDTH-1:i*FORCE_CACHE_WIDTH] <= in_force_data_lv2[(2*i+1)*FORCE_CACHE_WIDTH-1:2*i*FORCE_CACHE_WIDTH];
				in_velocity_data_lv3[(i+1)*VELOCITY_CACHE_WIDTH-1:i*VELOCITY_CACHE_WIDTH] <= in_velocity_data_lv2[(2*i+1)*VELOCITY_CACHE_WIDTH-1:2*i*VELOCITY_CACHE_WIDTH];
				in_position_data_lv3[(i+1)*POS_CACHE_WIDTH-1:i*POS_CACHE_WIDTH] <= in_position_data_lv2[(2*i+1)*POS_CACHE_WIDTH-1:2*i*POS_CACHE_WIDTH];
				end
			end
		end
endgenerate


generate
	for (i = 0; i < 2; i = i + 1)
		begin: mux_lv4_force
		always@(posedge clk)
			begin
			if (cell_counter_4[i])	 	// odd
				begin
				in_force_data_lv4[(i+1)*FORCE_CACHE_WIDTH-1:i*FORCE_CACHE_WIDTH] <= in_force_data_lv3[2*(i+1)*FORCE_CACHE_WIDTH-1:(2*i+1)*FORCE_CACHE_WIDTH];
				in_velocity_data_lv4[(i+1)*VELOCITY_CACHE_WIDTH-1:i*VELOCITY_CACHE_WIDTH] <= in_velocity_data_lv3[2*(i+1)*VELOCITY_CACHE_WIDTH-1:(2*i+1)*VELOCITY_CACHE_WIDTH];
				in_position_data_lv4[(i+1)*POS_CACHE_WIDTH-1:i*POS_CACHE_WIDTH] <= in_position_data_lv3[2*(i+1)*POS_CACHE_WIDTH-1:(2*i+1)*POS_CACHE_WIDTH];
				end
			else							// even
				begin
				in_force_data_lv4[(i+1)*FORCE_CACHE_WIDTH-1:i*FORCE_CACHE_WIDTH] <= in_force_data_lv3[(2*i+1)*FORCE_CACHE_WIDTH-1:2*i*FORCE_CACHE_WIDTH];
				in_velocity_data_lv4[(i+1)*VELOCITY_CACHE_WIDTH-1:i*VELOCITY_CACHE_WIDTH] <= in_velocity_data_lv3[(2*i+1)*VELOCITY_CACHE_WIDTH-1:2*i*VELOCITY_CACHE_WIDTH];
				in_position_data_lv4[(i+1)*POS_CACHE_WIDTH-1:i*POS_CACHE_WIDTH] <= in_position_data_lv3[(2*i+1)*POS_CACHE_WIDTH-1:2*i*POS_CACHE_WIDTH];
				end
			end
		end
endgenerate

assign in_force_data = (cell_counter[5]) ? in_force_data_lv4[2*FORCE_CACHE_WIDTH-1:FORCE_CACHE_WIDTH] : in_force_data_lv4[FORCE_CACHE_WIDTH-1:0];
assign in_velocity_data = (cell_counter[5]) ? in_velocity_data_lv4[2*VELOCITY_CACHE_WIDTH-1:VELOCITY_CACHE_WIDTH] : in_velocity_data_lv4[VELOCITY_CACHE_WIDTH-1:0];
assign in_position_data = (cell_counter[5]) ? in_position_data_lv4[2*POS_CACHE_WIDTH-1:POS_CACHE_WIDTH] : in_position_data_lv4[POS_CACHE_WIDTH-1:0];

endmodule