////////////////////////////////////////////////////////////////////////
// Send read address and read request to caches
// Data return
// Process and figure out which cache to write back
// Send data and valid signal to caches
// Caches record data based on their own address counter
////////////////////////////////////////////////////////////////////////

module motion_update_control
#(
	parameter OFFSET_WIDTH = 29, 
	parameter DATA_WIDTH = 32, 
	parameter GLOBAL_CELL_ID_WIDTH = 6, 
	parameter FORCE_CACHE_WIDTH = 3*DATA_WIDTH, 
	parameter VELOCITY_CACHE_WIDTH = 3*DATA_WIDTH, 
	parameter POS_CACHE_WIDTH = 3*OFFSET_WIDTH, 
	parameter PARTICLE_ID_WIDTH = 7, 
	parameter CELL_ID_WIDTH = 3, 
	parameter NUM_CELLS = 64, 
	parameter X_DIM = 4, 
	parameter Y_DIM = 4, 
	parameter Z_DIM = 4
)
(
	input clk, 
	input rst, 
	input motion_update_start,
	input [NUM_CELLS*FORCE_CACHE_WIDTH-1:0] in_all_force_data,
	input [NUM_CELLS*VELOCITY_CACHE_WIDTH-1:0] in_all_velocity_data,
	input [NUM_CELLS*POS_CACHE_WIDTH-1:0] in_all_position_data,
	
	output [NUM_CELLS-1:0] out_force_rd_request, 
	output [POS_CACHE_WIDTH-1:0] out_position_data,
	output [VELOCITY_CACHE_WIDTH-1:0] out_velocity_data,
	output [PARTICLE_ID_WIDTH-1:0] out_rd_addr, 
	output [3*CELL_ID_WIDTH-1:0] out_dst_cell, 
	// Reading control
	output out_rd_enable, 
	// Writing control
	output out_data_valid, 
	output out_motion_update_enable, 
	output out_motion_update_done
);

wire [GLOBAL_CELL_ID_WIDTH-1:0] cell_counter;
assign out_force_rd_request = out_motion_update_enable << cell_counter;
wire [1:0] cell_x_offset;
wire [1:0] cell_y_offset;
wire [1:0] cell_z_offset;
wire [CELL_ID_WIDTH-1:0] cell_x;
wire [CELL_ID_WIDTH-1:0] cell_y;
wire [CELL_ID_WIDTH-1:0] cell_z;
reg [CELL_ID_WIDTH-1:0] dst_cell_x;
reg [CELL_ID_WIDTH-1:0] dst_cell_y;
reg [CELL_ID_WIDTH-1:0] dst_cell_z;
// {x,y,z}, in accordance with pos and velocity caches
assign out_dst_cell[3*CELL_ID_WIDTH-1:2*CELL_ID_WIDTH] = dst_cell_z;
assign out_dst_cell[2*CELL_ID_WIDTH-1:CELL_ID_WIDTH] = dst_cell_y;
assign out_dst_cell[CELL_ID_WIDTH-1:0] = dst_cell_x;

reg [FORCE_CACHE_WIDTH-1:0] in_force_data;
reg [VELOCITY_CACHE_WIDTH-1:0] in_velocity_data;
reg [POS_CACHE_WIDTH-1:0] in_position_data;

// Determine x target cell
always@(*)
	begin
	case(cell_x_offset)
		// x+
		2'b01:
			begin
			if (cell_x < X_DIM)
				begin
				dst_cell_x = cell_x+1'b1;
				end
			else
				begin
				dst_cell_x = 1;
				end
			end
		// x-
		2'b11:
			begin
			if (cell_x > 1)
				begin
				dst_cell_x = cell_x-1'b1;
				end
			else
				begin
				dst_cell_x = X_DIM;
				end
			end
		2'b00:
			begin
			dst_cell_x = cell_x;
			end
		default:
			begin
			dst_cell_x = cell_x;
			end
	endcase
	end

always@(*)
	begin
	case(cell_y_offset)
		// y+
		2'b01:
			begin
			if (cell_y < Y_DIM)
				begin
				dst_cell_y = cell_y+1'b1;
				end
			else
				begin
				dst_cell_y = 1;
				end
			end
		// y-
		2'b11:
			begin
			if (cell_y > 1)
				begin
				dst_cell_y = cell_y-1'b1;
				end
			else
				begin
				dst_cell_y = Y_DIM;
				end
			end
		2'b00:
			begin
			dst_cell_y = cell_y;
			end
		default:
			begin
			dst_cell_y = cell_y;
			end
	endcase
	end

always@(*)
	begin
	case(cell_z_offset)
		// z+
		2'b01:
			begin
			if (cell_z < Z_DIM)
				begin
				dst_cell_z = cell_z+1'b1;
				end
			else
				begin
				dst_cell_z = 1;
				end
			end
		// z-
		2'b11:
			begin
			if (cell_z > 1)
				begin
				dst_cell_z = cell_z-1'b1;
				end
			else
				begin
				dst_cell_z = Z_DIM;
				end
			end
		2'b00:
			begin
			dst_cell_z = cell_z;
			end
		default:
			begin
			dst_cell_z = cell_z;
			end
	endcase
	end
	
// Input arrangement
always @(*)begin
  in_force_data    = in_all_force_data[cell_counter*FORCE_CACHE_WIDTH +: FORCE_CACHE_WIDTH];
  in_velocity_data = in_all_velocity_data[cell_counter*VELOCITY_CACHE_WIDTH +: VELOCITY_CACHE_WIDTH];
  in_position_data = in_all_position_data[cell_counter*POS_CACHE_WIDTH +: POS_CACHE_WIDTH];
end


motion_update
#(
	.NUM_CELLS(NUM_CELLS), 
	.GLOBAL_CELL_ID_WIDTH(GLOBAL_CELL_ID_WIDTH), 
	.CELL_ID_WIDTH(CELL_ID_WIDTH), 
	.OFFSET_WIDTH(OFFSET_WIDTH),
	.DATA_WIDTH(DATA_WIDTH),
	.FORCE_CACHE_WIDTH(FORCE_CACHE_WIDTH),
	.VELOCITY_CACHE_WIDTH(VELOCITY_CACHE_WIDTH),
	.POS_CACHE_WIDTH(POS_CACHE_WIDTH),
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH), 
	.X_DIM(X_DIM), 
	.Y_DIM(Y_DIM), 
	.Z_DIM(Z_DIM)
)
motion_update
(
	.clk(clk),
	.rst(rst),
	.motion_update_start(motion_update_start),
	.in_force_data(in_force_data),
	.in_position_data(in_position_data),
	.in_velocity_data(in_velocity_data),
	
	.out_position_data(out_position_data),
	.out_velocity_data(out_velocity_data),
	.out_rd_addr(out_rd_addr),
	.out_rd_enable(out_rd_enable), 
	.out_data_valid(out_data_valid), 
	.out_motion_update_enable(out_motion_update_enable), 
	.out_motion_update_done(out_motion_update_done), 
	.cell_counter(cell_counter), 
	.cell_x_offset(cell_x_offset),
	.cell_y_offset(cell_y_offset),
	.cell_z_offset(cell_z_offset), 
	.cell_x(cell_x), 
	.cell_y(cell_y), 
	.cell_z(cell_z)
);

endmodule
