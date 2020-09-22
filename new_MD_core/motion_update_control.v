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
always@(*)
	begin
	case(cell_counter)
		0:
			begin
			in_force_data = in_all_force_data[1*FORCE_CACHE_WIDTH-1:0*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[1*VELOCITY_CACHE_WIDTH-1:0*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[1*POS_CACHE_WIDTH-1:0*POS_CACHE_WIDTH];
			end
		1:
			begin
			in_force_data = in_all_force_data[2*FORCE_CACHE_WIDTH-1:1*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[2*VELOCITY_CACHE_WIDTH-1:1*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[2*POS_CACHE_WIDTH-1:1*POS_CACHE_WIDTH];
			end
		2:
			begin
			in_force_data = in_all_force_data[3*FORCE_CACHE_WIDTH-1:2*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[3*VELOCITY_CACHE_WIDTH-1:2*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[3*POS_CACHE_WIDTH-1:2*POS_CACHE_WIDTH];
			end
		3:
			begin
			in_force_data = in_all_force_data[4*FORCE_CACHE_WIDTH-1:3*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[4*VELOCITY_CACHE_WIDTH-1:3*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[4*POS_CACHE_WIDTH-1:3*POS_CACHE_WIDTH];
			end
		4:
			begin
			in_force_data = in_all_force_data[5*FORCE_CACHE_WIDTH-1:4*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[5*VELOCITY_CACHE_WIDTH-1:4*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[5*POS_CACHE_WIDTH-1:4*POS_CACHE_WIDTH];
			end
		5:
			begin
			in_force_data = in_all_force_data[6*FORCE_CACHE_WIDTH-1:5*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[6*VELOCITY_CACHE_WIDTH-1:5*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[6*POS_CACHE_WIDTH-1:5*POS_CACHE_WIDTH];
			end
		6:
			begin
			in_force_data = in_all_force_data[7*FORCE_CACHE_WIDTH-1:6*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[7*VELOCITY_CACHE_WIDTH-1:6*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[7*POS_CACHE_WIDTH-1:6*POS_CACHE_WIDTH];
			end
		7:
			begin
			in_force_data = in_all_force_data[8*FORCE_CACHE_WIDTH-1:7*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[8*VELOCITY_CACHE_WIDTH-1:7*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[8*POS_CACHE_WIDTH-1:7*POS_CACHE_WIDTH];
			end
		8:
			begin
			in_force_data = in_all_force_data[9*FORCE_CACHE_WIDTH-1:8*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[9*VELOCITY_CACHE_WIDTH-1:8*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[9*POS_CACHE_WIDTH-1:8*POS_CACHE_WIDTH];
			end
		9:
			begin
			in_force_data = in_all_force_data[10*FORCE_CACHE_WIDTH-1:9*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[10*VELOCITY_CACHE_WIDTH-1:9*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[10*POS_CACHE_WIDTH-1:9*POS_CACHE_WIDTH];
			end
		10:
			begin
			in_force_data = in_all_force_data[11*FORCE_CACHE_WIDTH-1:10*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[11*VELOCITY_CACHE_WIDTH-1:10*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[11*POS_CACHE_WIDTH-1:10*POS_CACHE_WIDTH];
			end
		11:
			begin
			in_force_data = in_all_force_data[12*FORCE_CACHE_WIDTH-1:11*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[12*VELOCITY_CACHE_WIDTH-1:11*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[12*POS_CACHE_WIDTH-1:11*POS_CACHE_WIDTH];
			end
		12:
			begin
			in_force_data = in_all_force_data[13*FORCE_CACHE_WIDTH-1:12*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[13*VELOCITY_CACHE_WIDTH-1:12*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[13*POS_CACHE_WIDTH-1:12*POS_CACHE_WIDTH];
			end
		13:
			begin
			in_force_data = in_all_force_data[14*FORCE_CACHE_WIDTH-1:13*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[14*VELOCITY_CACHE_WIDTH-1:13*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[14*POS_CACHE_WIDTH-1:13*POS_CACHE_WIDTH];
			end
		14:
			begin
			in_force_data = in_all_force_data[15*FORCE_CACHE_WIDTH-1:14*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[15*VELOCITY_CACHE_WIDTH-1:14*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[15*POS_CACHE_WIDTH-1:14*POS_CACHE_WIDTH];
			end
		15:
			begin
			in_force_data = in_all_force_data[16*FORCE_CACHE_WIDTH-1:15*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[16*VELOCITY_CACHE_WIDTH-1:15*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[16*POS_CACHE_WIDTH-1:15*POS_CACHE_WIDTH];
			end
		16:
			begin
			in_force_data = in_all_force_data[17*FORCE_CACHE_WIDTH-1:16*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[17*VELOCITY_CACHE_WIDTH-1:16*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[17*POS_CACHE_WIDTH-1:16*POS_CACHE_WIDTH];
			end
		17:
			begin
			in_force_data = in_all_force_data[18*FORCE_CACHE_WIDTH-1:17*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[18*VELOCITY_CACHE_WIDTH-1:17*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[18*POS_CACHE_WIDTH-1:17*POS_CACHE_WIDTH];
			end
		18:
			begin
			in_force_data = in_all_force_data[19*FORCE_CACHE_WIDTH-1:18*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[19*VELOCITY_CACHE_WIDTH-1:18*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[19*POS_CACHE_WIDTH-1:18*POS_CACHE_WIDTH];
			end
		19:
			begin
			in_force_data = in_all_force_data[20*FORCE_CACHE_WIDTH-1:19*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[20*VELOCITY_CACHE_WIDTH-1:19*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[20*POS_CACHE_WIDTH-1:19*POS_CACHE_WIDTH];
			end
		20:
			begin
			in_force_data = in_all_force_data[21*FORCE_CACHE_WIDTH-1:20*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[21*VELOCITY_CACHE_WIDTH-1:20*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[21*POS_CACHE_WIDTH-1:20*POS_CACHE_WIDTH];
			end
		21:
			begin
			in_force_data = in_all_force_data[22*FORCE_CACHE_WIDTH-1:21*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[22*VELOCITY_CACHE_WIDTH-1:21*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[22*POS_CACHE_WIDTH-1:21*POS_CACHE_WIDTH];
			end
		22:
			begin
			in_force_data = in_all_force_data[23*FORCE_CACHE_WIDTH-1:22*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[23*VELOCITY_CACHE_WIDTH-1:22*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[23*POS_CACHE_WIDTH-1:22*POS_CACHE_WIDTH];
			end
		23:
			begin
			in_force_data = in_all_force_data[24*FORCE_CACHE_WIDTH-1:23*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[24*VELOCITY_CACHE_WIDTH-1:23*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[24*POS_CACHE_WIDTH-1:23*POS_CACHE_WIDTH];
			end
		24:
			begin
			in_force_data = in_all_force_data[25*FORCE_CACHE_WIDTH-1:24*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[25*VELOCITY_CACHE_WIDTH-1:24*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[25*POS_CACHE_WIDTH-1:24*POS_CACHE_WIDTH];
			end
		25:
			begin
			in_force_data = in_all_force_data[26*FORCE_CACHE_WIDTH-1:25*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[26*VELOCITY_CACHE_WIDTH-1:25*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[26*POS_CACHE_WIDTH-1:25*POS_CACHE_WIDTH];
			end
		26:
			begin
			in_force_data = in_all_force_data[27*FORCE_CACHE_WIDTH-1:26*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[27*VELOCITY_CACHE_WIDTH-1:26*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[27*POS_CACHE_WIDTH-1:26*POS_CACHE_WIDTH];
			end
		27:
			begin
			in_force_data = in_all_force_data[28*FORCE_CACHE_WIDTH-1:27*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[28*VELOCITY_CACHE_WIDTH-1:27*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[28*POS_CACHE_WIDTH-1:27*POS_CACHE_WIDTH];
			end
		28:
			begin
			in_force_data = in_all_force_data[29*FORCE_CACHE_WIDTH-1:28*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[29*VELOCITY_CACHE_WIDTH-1:28*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[29*POS_CACHE_WIDTH-1:28*POS_CACHE_WIDTH];
			end
		29:
			begin
			in_force_data = in_all_force_data[30*FORCE_CACHE_WIDTH-1:29*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[30*VELOCITY_CACHE_WIDTH-1:29*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[30*POS_CACHE_WIDTH-1:29*POS_CACHE_WIDTH];
			end
		30:
			begin
			in_force_data = in_all_force_data[31*FORCE_CACHE_WIDTH-1:30*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[31*VELOCITY_CACHE_WIDTH-1:30*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[31*POS_CACHE_WIDTH-1:30*POS_CACHE_WIDTH];
			end
		31:
			begin
			in_force_data = in_all_force_data[32*FORCE_CACHE_WIDTH-1:31*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[32*VELOCITY_CACHE_WIDTH-1:31*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[32*POS_CACHE_WIDTH-1:31*POS_CACHE_WIDTH];
			end
		32:
			begin
			in_force_data = in_all_force_data[33*FORCE_CACHE_WIDTH-1:32*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[33*VELOCITY_CACHE_WIDTH-1:32*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[33*POS_CACHE_WIDTH-1:32*POS_CACHE_WIDTH];
			end
		33:
			begin
			in_force_data = in_all_force_data[34*FORCE_CACHE_WIDTH-1:33*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[34*VELOCITY_CACHE_WIDTH-1:33*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[34*POS_CACHE_WIDTH-1:33*POS_CACHE_WIDTH];
			end
		34:
			begin
			in_force_data = in_all_force_data[35*FORCE_CACHE_WIDTH-1:34*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[35*VELOCITY_CACHE_WIDTH-1:34*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[35*POS_CACHE_WIDTH-1:34*POS_CACHE_WIDTH];
			end
		35:
			begin
			in_force_data = in_all_force_data[36*FORCE_CACHE_WIDTH-1:35*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[36*VELOCITY_CACHE_WIDTH-1:35*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[36*POS_CACHE_WIDTH-1:35*POS_CACHE_WIDTH];
			end
		36:
			begin
			in_force_data = in_all_force_data[37*FORCE_CACHE_WIDTH-1:36*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[37*VELOCITY_CACHE_WIDTH-1:36*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[37*POS_CACHE_WIDTH-1:36*POS_CACHE_WIDTH];
			end
		37:
			begin
			in_force_data = in_all_force_data[38*FORCE_CACHE_WIDTH-1:37*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[38*VELOCITY_CACHE_WIDTH-1:37*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[38*POS_CACHE_WIDTH-1:37*POS_CACHE_WIDTH];
			end
		38:
			begin
			in_force_data = in_all_force_data[39*FORCE_CACHE_WIDTH-1:38*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[39*VELOCITY_CACHE_WIDTH-1:38*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[39*POS_CACHE_WIDTH-1:38*POS_CACHE_WIDTH];
			end
		39:
			begin
			in_force_data = in_all_force_data[40*FORCE_CACHE_WIDTH-1:39*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[40*VELOCITY_CACHE_WIDTH-1:39*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[40*POS_CACHE_WIDTH-1:39*POS_CACHE_WIDTH];
			end
		40:
			begin
			in_force_data = in_all_force_data[41*FORCE_CACHE_WIDTH-1:40*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[41*VELOCITY_CACHE_WIDTH-1:40*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[41*POS_CACHE_WIDTH-1:40*POS_CACHE_WIDTH];
			end
		41:
			begin
			in_force_data = in_all_force_data[42*FORCE_CACHE_WIDTH-1:41*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[42*VELOCITY_CACHE_WIDTH-1:41*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[42*POS_CACHE_WIDTH-1:41*POS_CACHE_WIDTH];
			end
		42:
			begin
			in_force_data = in_all_force_data[43*FORCE_CACHE_WIDTH-1:42*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[43*VELOCITY_CACHE_WIDTH-1:42*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[43*POS_CACHE_WIDTH-1:42*POS_CACHE_WIDTH];
			end
		43:
			begin
			in_force_data = in_all_force_data[44*FORCE_CACHE_WIDTH-1:43*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[44*VELOCITY_CACHE_WIDTH-1:43*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[44*POS_CACHE_WIDTH-1:43*POS_CACHE_WIDTH];
			end
		44:
			begin
			in_force_data = in_all_force_data[45*FORCE_CACHE_WIDTH-1:44*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[45*VELOCITY_CACHE_WIDTH-1:44*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[45*POS_CACHE_WIDTH-1:44*POS_CACHE_WIDTH];
			end
		45:
			begin
			in_force_data = in_all_force_data[46*FORCE_CACHE_WIDTH-1:45*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[46*VELOCITY_CACHE_WIDTH-1:45*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[46*POS_CACHE_WIDTH-1:45*POS_CACHE_WIDTH];
			end
		46:
			begin
			in_force_data = in_all_force_data[47*FORCE_CACHE_WIDTH-1:46*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[47*VELOCITY_CACHE_WIDTH-1:46*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[47*POS_CACHE_WIDTH-1:46*POS_CACHE_WIDTH];
			end
		47:
			begin
			in_force_data = in_all_force_data[48*FORCE_CACHE_WIDTH-1:47*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[48*VELOCITY_CACHE_WIDTH-1:47*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[48*POS_CACHE_WIDTH-1:47*POS_CACHE_WIDTH];
			end
		48:
			begin
			in_force_data = in_all_force_data[49*FORCE_CACHE_WIDTH-1:48*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[49*VELOCITY_CACHE_WIDTH-1:48*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[49*POS_CACHE_WIDTH-1:48*POS_CACHE_WIDTH];
			end
		49:
			begin
			in_force_data = in_all_force_data[50*FORCE_CACHE_WIDTH-1:49*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[50*VELOCITY_CACHE_WIDTH-1:49*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[50*POS_CACHE_WIDTH-1:49*POS_CACHE_WIDTH];
			end
		50:
			begin
			in_force_data = in_all_force_data[51*FORCE_CACHE_WIDTH-1:50*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[51*VELOCITY_CACHE_WIDTH-1:50*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[51*POS_CACHE_WIDTH-1:50*POS_CACHE_WIDTH];
			end
		51:
			begin
			in_force_data = in_all_force_data[52*FORCE_CACHE_WIDTH-1:51*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[52*VELOCITY_CACHE_WIDTH-1:51*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[52*POS_CACHE_WIDTH-1:51*POS_CACHE_WIDTH];
			end
		52:
			begin
			in_force_data = in_all_force_data[53*FORCE_CACHE_WIDTH-1:52*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[53*VELOCITY_CACHE_WIDTH-1:52*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[53*POS_CACHE_WIDTH-1:52*POS_CACHE_WIDTH];
			end
		53:
			begin
			in_force_data = in_all_force_data[54*FORCE_CACHE_WIDTH-1:53*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[54*VELOCITY_CACHE_WIDTH-1:53*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[54*POS_CACHE_WIDTH-1:53*POS_CACHE_WIDTH];
			end
		54:
			begin
			in_force_data = in_all_force_data[55*FORCE_CACHE_WIDTH-1:54*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[55*VELOCITY_CACHE_WIDTH-1:54*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[55*POS_CACHE_WIDTH-1:54*POS_CACHE_WIDTH];
			end
		55:
			begin
			in_force_data = in_all_force_data[56*FORCE_CACHE_WIDTH-1:55*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[56*VELOCITY_CACHE_WIDTH-1:55*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[56*POS_CACHE_WIDTH-1:55*POS_CACHE_WIDTH];
			end
		56:
			begin
			in_force_data = in_all_force_data[57*FORCE_CACHE_WIDTH-1:56*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[57*VELOCITY_CACHE_WIDTH-1:56*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[57*POS_CACHE_WIDTH-1:56*POS_CACHE_WIDTH];
			end
		57:
			begin
			in_force_data = in_all_force_data[58*FORCE_CACHE_WIDTH-1:57*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[58*VELOCITY_CACHE_WIDTH-1:57*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[58*POS_CACHE_WIDTH-1:57*POS_CACHE_WIDTH];
			end
		58:
			begin
			in_force_data = in_all_force_data[59*FORCE_CACHE_WIDTH-1:58*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[59*VELOCITY_CACHE_WIDTH-1:58*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[59*POS_CACHE_WIDTH-1:58*POS_CACHE_WIDTH];
			end
		59:
			begin
			in_force_data = in_all_force_data[60*FORCE_CACHE_WIDTH-1:59*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[60*VELOCITY_CACHE_WIDTH-1:59*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[60*POS_CACHE_WIDTH-1:59*POS_CACHE_WIDTH];
			end
		60:
			begin
			in_force_data = in_all_force_data[61*FORCE_CACHE_WIDTH-1:60*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[61*VELOCITY_CACHE_WIDTH-1:60*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[61*POS_CACHE_WIDTH-1:60*POS_CACHE_WIDTH];
			end
		61:
			begin
			in_force_data = in_all_force_data[62*FORCE_CACHE_WIDTH-1:61*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[62*VELOCITY_CACHE_WIDTH-1:61*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[62*POS_CACHE_WIDTH-1:61*POS_CACHE_WIDTH];
			end
		62:
			begin
			in_force_data = in_all_force_data[63*FORCE_CACHE_WIDTH-1:62*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[63*VELOCITY_CACHE_WIDTH-1:62*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[63*POS_CACHE_WIDTH-1:62*POS_CACHE_WIDTH];
			end
		63:
			begin
			in_force_data = in_all_force_data[64*FORCE_CACHE_WIDTH-1:63*FORCE_CACHE_WIDTH];
			in_velocity_data = in_all_velocity_data[64*VELOCITY_CACHE_WIDTH-1:63*VELOCITY_CACHE_WIDTH];
			in_position_data = in_all_position_data[64*POS_CACHE_WIDTH-1:63*POS_CACHE_WIDTH];
			end
	endcase
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
