///////////////////////////////////
// Assemble the input raw data
// Determine the valid bits
///////////////////////////////////

module pos_data_preprocessor
#(
	parameter OFFSET_WIDTH = 29, 
	parameter DATA_WIDTH = 32,
	parameter NUM_NEIGHBOR_CELLS = 13,
	parameter NUM_FILTER = 7,
	parameter PARTICLE_ID_WIDTH = 7, 
	parameter CELL_ID_WIDTH = 3, 
	parameter FULL_CELL_ID_WIDTH = 3*CELL_ID_WIDTH
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
	input [PARTICLE_ID_WIDTH-1:0] ref_id, 
	input [PARTICLE_ID_WIDTH-1:0] particle_id, 
	
	output reading_done, 
	output [DATA_WIDTH-1:0] ref_x,
	output [DATA_WIDTH-1:0] ref_y,
	output [DATA_WIDTH-1:0] ref_z,
	output reg [PARTICLE_ID_WIDTH-1:0] prev_particle_id, 
	output reg [PARTICLE_ID_WIDTH-1:0] prev_ref_id, 
	output [PARTICLE_ID_WIDTH-1:0] ref_particle_num, 
	output [NUM_FILTER-1:0] pair_valid,
	output [NUM_FILTER*3*DATA_WIDTH-1:0] assembled_position
);

reg prev_phase;
reg prev_pause_reading;
reg prev_reading_particle_num;
reg [NUM_NEIGHBOR_CELLS:0] prev_broadcast_done;
reg [(NUM_NEIGHBOR_CELLS+1)*3*OFFSET_WIDTH-1:0] prev_rd_nb_position;

wire ref_not_read_yet;
wire ref_valid;


always@(posedge clk)
	begin
	prev_phase <= phase;
	prev_pause_reading <= pause_reading;
	prev_reading_particle_num <= reading_particle_num;
	prev_particle_id <= particle_id;
	prev_ref_id <= ref_id;
	prev_broadcast_done <= broadcast_done;
	prev_rd_nb_position <= rd_nb_position;
	end

// 1 cycle delay
ref_data_extractor
#(
	.OFFSET_WIDTH(OFFSET_WIDTH), 
	.DATA_WIDTH(DATA_WIDTH),
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH)
)
ref_data_extractor
(
	.clk(clk),
	.rst(rst),
	.phase(phase), 
	.prev_phase(prev_phase), 
	.reading_particle_num(reading_particle_num), 
	.raw_home_pos_x(rd_nb_position[OFFSET_WIDTH-1:0]),
	.raw_home_pos_y(rd_nb_position[2*OFFSET_WIDTH-1:OFFSET_WIDTH]),
	.raw_home_pos_z(rd_nb_position[3*OFFSET_WIDTH-1:2*OFFSET_WIDTH]),
	.particle_id(particle_id),
	.ref_id(ref_id),
	
	.ref_particle_num(ref_particle_num), 
	.ref_x(ref_x),
	.ref_y(ref_y),
	.ref_z(ref_z)
);

pos_data_valid_checker
#(
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH)
)
pos_data_valid_checker
(
	.phase(prev_phase),
	.reading_particle_num(prev_reading_particle_num), 
	.ref_id(prev_ref_id),
	.particle_id(prev_particle_id),
	.ref_particle_num(ref_particle_num),
	
	.ref_not_read_yet(ref_not_read_yet),
	.reading_done(reading_done), 
	.ref_valid(ref_valid)
);
	
// All except for the valid bits are delayed because it takes 1 cycle to get ref_id, 
// so it takes 1 cycle to get valid bits
pos_data_distributor_disorder
#(
	.OFFSET_WIDTH(OFFSET_WIDTH), 
	.DATA_WIDTH(DATA_WIDTH),
	.NUM_NEIGHBOR_CELLS(NUM_NEIGHBOR_CELLS),
	.NUM_FILTER(NUM_FILTER), 
	.CELL_ID_WIDTH(CELL_ID_WIDTH), 
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH)
)
pos_data_distributor
(
	.clk(clk),
	.phase(prev_phase), 
	.pause_reading(prev_pause_reading), 
	.rd_nb_position(prev_rd_nb_position),
	.broadcast_done(prev_broadcast_done),
	.ref_not_read_yet(ref_not_read_yet),
	.ref_valid(ref_valid),
	
	.pair_valid(pair_valid),
	.assembled_position(assembled_position)
);

endmodule