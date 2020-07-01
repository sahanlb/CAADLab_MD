///////////////////////////////////////////////////////////////////////////////////////////////
// Take all the available data for granted, connects the force pipeline with other components
// Determine all the valid signals (ref_not_read_yet and ref_valid)
// Extract useful data from the broadcasted data
///////////////////////////////////////////////////////////////////////////////////////////////
module PE_wrapper
#(
	// Data width
	parameter OFFSET_WIDTH = 29, 
	parameter DATA_WIDTH = 32,
	parameter CELL_ID_WIDTH = 3,
	parameter DECIMAL_ADDR_WIDTH = 2, 
	parameter PARTICLE_ID_WIDTH = 7, 
	parameter BODY_BITS = 8, 
	parameter ID_WIDTH = 3*CELL_ID_WIDTH+PARTICLE_ID_WIDTH,
	parameter FULL_CELL_ID_WIDTH = 3*CELL_ID_WIDTH, 
	parameter FILTER_BUFFER_DATA_WIDTH = PARTICLE_ID_WIDTH+3*DATA_WIDTH, 
	parameter FORCE_BUFFER_WIDTH = 3*DATA_WIDTH+PARTICLE_ID_WIDTH+1, 
	
	// Constants
	parameter SQRT_2 = 10'b0101101011,
	parameter SQRT_3 = 10'b0110111100,
	parameter NUM_FILTER = 7, 
	parameter ARBITER_MSB = 64, 				// 2^(NUM_FILTER-1)
	parameter NUM_NEIGHBOR_CELLS = 13,
	parameter EXP_0 = 8'b01111111, 
	
	// Force evaluation
	parameter SEGMENT_NUM					= 9,
	parameter SEGMENT_WIDTH					= 4,
	parameter BIN_NUM							= 256,
	parameter BIN_WIDTH						= 8,
	parameter LOOKUP_NUM						= SEGMENT_NUM * BIN_NUM,		// SEGMENT_NUM * BIN_NUM
	parameter LOOKUP_ADDR_WIDTH			= SEGMENT_WIDTH + BIN_WIDTH	// log LOOKUP_NUM / log 2
)
(
	input clk, 
	input rst, 
	// All PEs have a synchronized phase, so use a global phase
	input phase, 
	input pause_reading, 
	input reading_particle_num, 
	// From data source
	input [(NUM_NEIGHBOR_CELLS+1)*3*OFFSET_WIDTH-1:0] rd_nb_position, 
	input [NUM_NEIGHBOR_CELLS:0] broadcast_done, 
	input [PARTICLE_ID_WIDTH-1:0] particle_id, 
	input [PARTICLE_ID_WIDTH-1:0] ref_particle_id, 
	input [NUM_FILTER-1:0] write_success, 
	
	// From preprocessor
	output reading_done, 
	output [PARTICLE_ID_WIDTH-1:0] ref_particle_num, 
	// From force evaluation
	output back_pressure,
	output all_buffer_empty,
	output [NUM_FILTER*FORCE_BUFFER_WIDTH-1:0] force_data_out, 
	output [NUM_FILTER-1:0] output_force_valid
);

// Raw success signal is 14-bit long, merge so it becomes 7-bit long
//wire [NUM_FILTER-1:0] write_success;
//genvar i;
//generate
//	for (i = 0; i < NUM_FILTER; i = i + 1)
//		begin: write_success_merge
//		assign write_success[i] = full_write_success[i] | full_write_success[i+NUM_FILTER];
//		end
//endgenerate

wire [DATA_WIDTH-1:0] ref_x;
wire [DATA_WIDTH-1:0] ref_y;
wire [DATA_WIDTH-1:0] ref_z;
wire [PARTICLE_ID_WIDTH-1:0] delay_particle_id;
wire [PARTICLE_ID_WIDTH-1:0] delay_ref_id;
wire [NUM_FILTER-1:0] pair_valid;
wire [NUM_FILTER*3*DATA_WIDTH-1:0] assembled_position;

// Back pressure status of each filter
wire [NUM_FILTER-1:0] filter_back_pressure;
assign back_pressure = (filter_back_pressure == 0) ? 1'b0 : 1'b1;

//wire all_buffer_empty;
// Do not need cell id because it's 222
wire [PARTICLE_ID_WIDTH-1:0] out_ref_particle_id;
wire [DATA_WIDTH-1:0] ref_force_x;
wire [DATA_WIDTH-1:0] ref_force_y;
wire [DATA_WIDTH-1:0] ref_force_z;
wire ref_force_valid;
wire [ID_WIDTH-1:0] out_neighbor_particle_id;
wire [DATA_WIDTH-1:0] nb_force_x;
wire [DATA_WIDTH-1:0] nb_force_y;
wire [DATA_WIDTH-1:0] nb_force_z;
wire nb_force_valid;

// Prepare the data for force evaluation unit
pos_data_preprocessor
#(
	.OFFSET_WIDTH(OFFSET_WIDTH),
	.DATA_WIDTH(DATA_WIDTH),
	.NUM_NEIGHBOR_CELLS(NUM_NEIGHBOR_CELLS),
	.NUM_FILTER(NUM_FILTER),
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH), 
	.CELL_ID_WIDTH(CELL_ID_WIDTH),
	.FULL_CELL_ID_WIDTH(FULL_CELL_ID_WIDTH)
)
pos_data_preprocessor
(
	.clk(clk),
	.rst(rst),
	.phase(phase),
	.pause_reading(pause_reading), 
	.reading_particle_num(reading_particle_num),
	.rd_nb_position(rd_nb_position),
	.broadcast_done(broadcast_done),
	.particle_id(particle_id),
	.ref_id(ref_particle_id),
	
	.reading_done(reading_done), 
	.ref_x(ref_x),
	.ref_y(ref_y),
	.ref_z(ref_z),
	.prev_ref_id(delay_ref_id), 
	.ref_particle_num(ref_particle_num), 
	.prev_particle_id(delay_particle_id), 
	.pair_valid(pair_valid),
	.assembled_position(assembled_position)
);

RL_LJ_Evaluation_Unit
#(
	.DATA_WIDTH(DATA_WIDTH),
	.CELL_ID_WIDTH(CELL_ID_WIDTH),
	.DECIMAL_ADDR_WIDTH(DECIMAL_ADDR_WIDTH),
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH),
	.BODY_BITS(BODY_BITS),
	.ID_WIDTH(ID_WIDTH),
	.FILTER_BUFFER_DATA_WIDTH(FILTER_BUFFER_DATA_WIDTH),
	.NUM_FILTER(NUM_FILTER),
	.ARBITER_MSB(ARBITER_MSB), 
	.SEGMENT_NUM(SEGMENT_NUM),
	.SEGMENT_WIDTH(SEGMENT_WIDTH),
	.BIN_NUM(BIN_NUM),
	.BIN_WIDTH(BIN_WIDTH)
)
RL_LJ_Evaluation_Unit
(
	.clk(clk),
	.rst(rst),
	.pair_valid(pair_valid),
	.ref_particle_id(delay_ref_id),
	.nb_particle_id(delay_particle_id),
	.ref_x(ref_x), 
	.ref_y(ref_y), 
	.ref_z(ref_z), 
	.nb_position(assembled_position),
	
	.out_back_pressure_to_input(filter_back_pressure),
	.out_all_buffer_empty_to_input(all_buffer_empty),
	.out_ref_particle_id(out_ref_particle_id),
	.out_ref_LJ_Force_X(ref_force_x),
	.out_ref_LJ_Force_Y(ref_force_y),
	.out_ref_LJ_Force_Z(ref_force_z),
	.out_ref_force_valid(ref_force_valid),
	.out_neighbor_particle_id(out_neighbor_particle_id),
	.out_neighbor_LJ_Force_X(nb_force_x),
	.out_neighbor_LJ_Force_Y(nb_force_y),
	.out_neighbor_LJ_Force_Z(nb_force_z),
	.out_neighbor_force_valid(nb_force_valid)
);

// Contains force buffers
force_distributor
#(
	.DATA_WIDTH(DATA_WIDTH),
	.CELL_ID_WIDTH(CELL_ID_WIDTH),
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH),
	.NUM_FILTER(NUM_FILTER),
	.ID_WIDTH(ID_WIDTH),
	.FORCE_BUFFER_WIDTH(FORCE_BUFFER_WIDTH)
)
force_distributor
(
	.clk(clk), 
	.rst(rst), 
	.ref_force_x(ref_force_x),
	.ref_force_y(ref_force_y),
	.ref_force_z(ref_force_z),
	.ref_id(out_ref_particle_id),
	.ref_force_valid(ref_force_valid),
	.force_x(nb_force_x),
	.force_y(nb_force_y),
	.force_z(nb_force_z),
	.nb_id(out_neighbor_particle_id),
	.force_valid(nb_force_valid),
	.write_success(write_success),
	
	.force_buffer_data_out(force_data_out),
	.output_force_valid(output_force_valid), 
	.force_buffer_usedw()
);

endmodule