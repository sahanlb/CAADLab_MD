module single_cell_reading_test
#(
	parameter NUM_CELLS = 14, 
	parameter PARTICLE_NUM = 100, 
	
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
	
	// Constants
	parameter SQRT_2 = 8'b10110110,
	parameter SQRT_3 = 8'b11011110, 
	parameter BACK_PRESSURE_THRESHOLD = 27, 
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
	input iter_start, 
	
	// From preprocessor
	output reading_done, 
	output [PARTICLE_ID_WIDTH-1:0] ref_particle_num, 
	// From force evaluation
	output back_pressure,
	output filter_buffer_empty,
	output [ID_WIDTH-1:0] out_ref_particle_id,
	output [DATA_WIDTH-1:0] ref_force_x,
	output [DATA_WIDTH-1:0] ref_force_y,
	output [DATA_WIDTH-1:0] ref_force_z,
	output ref_force_valid,
	output [ID_WIDTH-1:0] out_neighbor_particle_id,
	output [DATA_WIDTH-1:0] nb_force_x,
	output [DATA_WIDTH-1:0] nb_force_y,
	output [DATA_WIDTH-1:0] nb_force_z,
	output nb_force_valid
);

// From broadcast controller
wire [NUM_CELLS-1:0] broadcast_done;
wire [PARTICLE_ID_WIDTH-1:0] particle_id;
wire [PARTICLE_ID_WIDTH-1:0] ref_id;
wire [(NUM_NEIGHBOR_CELLS+1)*3*OFFSET_WIDTH-1:0] pos_data;
wire phase;
wire reading_particle_num;
wire pause_reading;

reg [NUM_CELLS-1:0] reg_broadcast_done;
reg [NUM_CELLS-1:0] delay_broadcast_done;

reg [PARTICLE_ID_WIDTH-1:0] reg_particle_id;
reg [PARTICLE_ID_WIDTH-1:0] delay_particle_id;

reg [PARTICLE_ID_WIDTH-1:0] reg_ref_id;
reg [PARTICLE_ID_WIDTH-1:0] delay_ref_id;

reg reg_phase;
reg delay_phase;

reg reg_reading_particle_num;
reg delay_reading_particle_num;

reg reg_pause_reading;
reg delay_pause_reading;


// From PE
wire [NUM_CELLS*PARTICLE_ID_WIDTH-1:0] particle_number;
assign particle_number = ref_particle_num;


// Delay the signals coming from broadcast controller because of reading (2 cycles delay)
always@(posedge clk)
	begin
	reg_broadcast_done <= broadcast_done;
	delay_broadcast_done <= reg_broadcast_done;
	
	reg_particle_id <= particle_id;
	delay_particle_id <= reg_particle_id;
	
	reg_ref_id <= ref_id;
	delay_ref_id <= reg_ref_id;
	
	reg_phase <= phase;
	delay_phase <= reg_phase;
	
	reg_reading_particle_num <= reading_particle_num;
	delay_reading_particle_num <= reg_reading_particle_num;
	
	reg_pause_reading <= pause_reading;
	delay_pause_reading <= reg_pause_reading;
	end

single_cell_reading_pos_caches
#(
	.OFFSET_WIDTH(OFFSET_WIDTH), 
	.PARTICLE_NUM(PARTICLE_NUM), 
	.NUM_NEIGHBOR_CELLS(NUM_NEIGHBOR_CELLS), 
	.ADDR_WIDTH(PARTICLE_ID_WIDTH)
)
pos_caches
(
	.clk(clk), 
	.particle_id(particle_id), 
	.pos_data(pos_data)
);

broadcast_controller
#(
	.NUM_CELLS(NUM_CELLS), 
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH)
)
broadcast_controller
(
	.clk(clk), 
	.rst(rst), 
	.iter_start(iter_start), 
	.particle_number(particle_number),
	.back_pressure(back_pressure),
	.filter_buffer_empty(filter_buffer_empty),
	.reading_done(reading_done),
	
	.broadcast_done(broadcast_done),
	.particle_id(particle_id),
	.ref_id(ref_id), 
	.phase(phase),
	.reading_particle_num(reading_particle_num),
	.pause_reading(pause_reading)
);

PE_wrapper
#(
	.OFFSET_WIDTH(OFFSET_WIDTH),
	.DATA_WIDTH(DATA_WIDTH),
	.CELL_ID_WIDTH(CELL_ID_WIDTH),
	.DECIMAL_ADDR_WIDTH(DECIMAL_ADDR_WIDTH),
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH),
	.BODY_BITS(BODY_BITS),
	.ID_WIDTH(ID_WIDTH),
	.FULL_CELL_ID_WIDTH(FULL_CELL_ID_WIDTH),
	.FILTER_BUFFER_DATA_WIDTH(FILTER_BUFFER_DATA_WIDTH), 
	.NUM_NEIGHBOR_CELLS(NUM_NEIGHBOR_CELLS)
)
PE_wrapper
(
	.clk(clk),
	.rst(rst),
	.phase(delay_phase),
	.pause_reading(delay_pause_reading),
	.reading_particle_num(delay_reading_particle_num),
	.rd_nb_position(pos_data),
	.broadcast_done(delay_broadcast_done),
	.particle_id(delay_particle_id),
	.ref_particle_id(delay_ref_id),
	
	.back_pressure(back_pressure),
	.all_buffer_empty(filter_buffer_empty),
	.reading_done(reading_done),
	.ref_particle_num(ref_particle_num), 
	.out_ref_particle_id(out_ref_particle_id),
	.ref_force_x(ref_force_x),
	.ref_force_y(ref_force_y),
	.ref_force_z(ref_force_z),
	.ref_force_valid(ref_force_valid),
	.out_neighbor_particle_id(out_neighbor_particle_id),
	.nb_force_x(nb_force_x),
	.nb_force_y(nb_force_y),
	.nb_force_z(nb_force_z),
	.nb_force_valid(nb_force_valid)
);
endmodule