import md_pkg::*;


module RL_top
#(
	parameter NUM_CELLS = 125, 
	parameter NUM_PARTICLE_PER_CELL = 100, 
	parameter OFFSET_WIDTH = 29, 
	parameter DATA_WIDTH = 32,
	parameter CELL_ID_WIDTH = 3,
	parameter DECIMAL_ADDR_WIDTH = 2, 
	parameter PARTICLE_ID_WIDTH = 7, 
	parameter X_DIM = 5, 
	parameter Y_DIM = 5, 
	parameter Z_DIM = 5, 
	parameter BODY_BITS = 8, 
	parameter ID_WIDTH = 3*CELL_ID_WIDTH+PARTICLE_ID_WIDTH,
  parameter NODE_ID_WIDTH     = $clog2(NUM_CELLS),
	parameter FULL_CELL_ID_WIDTH = 3*CELL_ID_WIDTH, 
	parameter FILTER_BUFFER_DATA_WIDTH = PARTICLE_ID_WIDTH+3*DATA_WIDTH, 
	parameter FORCE_BUFFER_WIDTH = 3*DATA_WIDTH+PARTICLE_ID_WIDTH+1, 
	parameter FORCE_DATA_WIDTH = FORCE_BUFFER_WIDTH-1, 
	parameter FORCE_CACHE_WIDTH = 3*DATA_WIDTH, 
  parameter FORCE_WB_WIDTH     = ID_WIDTH + 3*DATA_WIDTH,
  parameter PACKET_WIDTH      = FORCE_DATA_WIDTH + NODE_ID_WIDTH,
	parameter POS_CACHE_WIDTH = 3*OFFSET_WIDTH, 
	parameter VELOCITY_CACHE_WIDTH = 3*DATA_WIDTH, 
	parameter NUM_FILTER = 7, 
	parameter ARBITER_MSB = 64, 				// 2^(NUM_FILTER-1)
	parameter NUM_NEIGHBOR_CELLS = 13, 
	parameter ALL_POSITION_WIDTH = (NUM_NEIGHBOR_CELLS+1)*POS_CACHE_WIDTH
)
(
	input clk, 
	input rst, 
	input start, 
	
  output [NUM_CELLS-1:0] reading_done,
  output [NUM_CELLS-1:0] back_pressure,
  output [NUM_CELLS-1:0] filter_buffer_empty,
  output [NUM_CELLS-1:0] force_valid,
	output force_valid_and
);

assign force_valid_and = &force_valid;

// Output from PE
wire [NUM_CELLS-1:0][PARTICLE_ID_WIDTH-1:0] particle_num;
force_wb_t [NUM_CELLS-1:0] force_data;
wire [NUM_CELLS-1:0] ref_wb_issued;

// Input for broadcast controller

// Output from broadcast controller, before splitted
wire all_reading_done;
wire all_filter_buffer_empty;

// Input for PE
wire phase;
wire pause_reading;
wire reading_particle_num;
wire [PARTICLE_ID_WIDTH-1:0] particle_id;
wire [PARTICLE_ID_WIDTH-1:0] ref_particle_id;
offset_tuple_t [NUM_CELLS-1:0][NUM_NEIGHBOR_CELLS:0] rd_nb_position_splitted;
wire [NUM_CELLS-1:0] interconnect_ready;

// Force writeback
force_data_t [NUM_CELLS-1:0] force_to_caches;
wire [NUM_CELLS-1:0] force_wr_enable;
packet_t [NUM_CELLS-1:0] packets_to_ring;

// MU inputs
wire motion_update_start;
data_tuple_t   [NUM_CELLS-1:0] force_to_MU;
data_tuple_t   [NUM_CELLS-1:0] velocity_data_out;
offset_tuple_t [NUM_CELLS-1:0] rd_nb_position;

wire all_force_wr_issued;		// all force writings are issued
wire force_cache_input_buffer_empty;		// all force_wb_controller buffers are empty


// MU outputs
wire MU_out_rd_enable;
wire MU_out_data_valid;
wire [PARTICLE_ID_WIDTH-1:0] MU_out_rd_addr;
offset_tuple_t MU_out_position_data;
data_tuple_t MU_out_velocity_data;
full_cell_id_t MU_dst_cell;
wire [NUM_CELLS-1:0] MU_force_rd_request;
wire Motion_Update_enable;
wire MU_done;

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

// Capture all ref_wb_issued signals and wait for the packets to leave the interconnect
integer k;
reg [NUM_CELLS-1:0] r_ref_wb_issued;
reg all_ref_wb_issued;
reg [$clog2(NUM_CELLS):0] drain_counter;
wire interconnect_empty;
wire goto_next_ref;

assign interconnect_empty = (drain_counter == NUM_CELLS);

always @(posedge clk)begin
  if(rst)begin
    r_ref_wb_issued   <= {NUM_CELLS{1'b0}};
    all_ref_wb_issued <= 1'b0;
    drain_counter     <= 0;
  end
  else begin
    case(all_ref_wb_issued)
      1'b0:begin
        if(&r_ref_wb_issued)begin // All PEs are done writing back ref particle forces
          all_ref_wb_issued <= 1'b1;
          drain_counter     <= 0;
        end
        else begin
          for(k=0; k<NUM_CELLS; k=k+1)begin
            r_ref_wb_issued[k] <= ref_wb_issued[k] ? 1'b1 : r_ref_wb_issued[k];
          end 
        end
      end
      1'b1:begin
        if((drain_counter == NUM_CELLS) | goto_next_ref)begin
          drain_counter     <= 0;
          all_ref_wb_issued <= 1'b0; 
          r_ref_wb_issued   <= {NUM_CELLS{1'b0}};
        end
        else begin
          drain_counter     <= drain_counter + 1'b1;
        end
      end
    endcase
  end
end



assign all_force_wr_issued = (force_wr_enable == 0) & force_cache_input_buffer_empty & all_filter_buffer_empty & all_ref_wb_issued & interconnect_empty;
// all_ref_wb_issued captures captures the relevant signals from all PEs. interconnect_empty is set after waiting for NUM_CELLS cycles after the final writeback is issued.
assign motion_update_start = all_reading_done & all_force_wr_issued;



// Delay the signals coming from broadcast controller because of reading (2 cycles delay)
always@(posedge clk)
	begin
	reg_broadcast_done <= 0;
	delay_broadcast_done <= reg_broadcast_done;
	
	reg_particle_id <= particle_id;
	delay_particle_id <= reg_particle_id;
	
	reg_ref_id <= ref_particle_id;
	delay_ref_id <= reg_ref_id;
	
	reg_phase <= phase;
	delay_phase <= reg_phase;
	
	reg_reading_particle_num <= reading_particle_num;
	delay_reading_particle_num <= reg_reading_particle_num;
	
	reg_pause_reading <= pause_reading;
	delay_pause_reading <= reg_pause_reading;
	end

genvar i;
generate
	for (i = 0; i < NUM_CELLS; i = i + 1)
		begin: PE_collection
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
			.FORCE_BUFFER_WIDTH(FORCE_BUFFER_WIDTH),
			.NUM_FILTER(NUM_FILTER),
			.ARBITER_MSB(ARBITER_MSB),
			.NUM_NEIGHBOR_CELLS(NUM_NEIGHBOR_CELLS)
		)
		single_PE
		(
			.clk(clk),
			.rst(rst),
			.phase(delay_phase),
			.pause_reading(delay_pause_reading),
			.reading_particle_num(delay_reading_particle_num),
			// All PEs share the same id's
			.particle_id(delay_particle_id),
			.ref_particle_id(delay_ref_id),
			.rd_nb_position(rd_nb_position_splitted[i]),
      .ready(interconnect_ready[i]),
			
			.reading_done(reading_done[i]),
			.ref_particle_num(particle_num[i]),
			.back_pressure(back_pressure[i]),
			.all_buffer_empty(filter_buffer_empty[i]),
			.force_data_out(force_data[i]),
			.output_force_valid(force_valid[i]),
      .all_ref_wb_issued(ref_wb_issued[i])
		);
		end
endgenerate
	
broadcast_controller
#(
	.NUM_CELLS(NUM_CELLS),
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH)
)
broadcast_controller
(
	.clk(clk),
	.rst(rst),
	.iter_start(start || MU_done),
	.particle_num(particle_num),
	.back_pressure(back_pressure),
	.filter_buffer_empty(filter_buffer_empty),
	.reading_done(reading_done),
	.all_force_wr_issued(all_force_wr_issued), 
  .all_ref_wb_issued(all_ref_wb_issued),
  .drain_counter(drain_counter),
	
	.all_reading_done(all_reading_done), 
	.all_filter_buffer_empty(all_filter_buffer_empty), 
	.particle_id(particle_id),
	.ref_id(ref_particle_id),
	.phase(phase),
	.reading_particle_num(reading_particle_num),
	.pause_reading(pause_reading),
  .goto_next_ref(goto_next_ref)
);

position_cache_to_PE_mapping_half_shell
#(
	.NUM_CELLS(NUM_CELLS),
	.OFFSET_WIDTH(OFFSET_WIDTH),
	.NUM_NEIGHBOR_CELLS(NUM_NEIGHBOR_CELLS),
  .X_DIM(X_DIM),
  .Y_DIM(Y_DIM),
  .Z_DIM(Z_DIM)
)
position_cache_to_PE_mapping
(
	.rd_nb_position(rd_nb_position),
	
	.rd_nb_position_splitted(rd_nb_position_splitted)
);


// destination ID map
destination_id_map #(
  .NUM_CELLS(NUM_CELLS),
  .DATA_WIDTH(DATA_WIDTH),
	.CELL_ID_WIDTH(CELL_ID_WIDTH), 
  .PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH),
  .XSIZE(X_DIM),
  .YSIZE(Y_DIM),
  .ZSIZE(Z_DIM)
) dest_map (
  .wb_in(force_data),
  
  .pkt_out(packets_to_ring) 
);


// Ring interconnect
ring #(
  .NUM_CELLS(NUM_CELLS),
  .DATA_WIDTH(DATA_WIDTH),
  .PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH)
) ring_interconnect (
  .clk(clk),
  .rst(rst),
  .packet_in(packets_to_ring),
  .packet_valid(force_valid),

  .ready(interconnect_ready),
  .data_valid(force_wr_enable),
  .data_out(force_to_caches)
);


all_force_caches
#(
	.NUM_CELLS(NUM_CELLS),
	.DATA_WIDTH(DATA_WIDTH),
	.FORCE_CACHE_WIDTH(FORCE_CACHE_WIDTH),
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH),
	.FORCE_CACHE_DEPTH(NUM_PARTICLE_PER_CELL),
	.FORCE_DATA_WIDTH(FORCE_DATA_WIDTH)
)
all_force_caches
(
	.clk(clk),
	.rst(rst),
	.motion_updata_rd_request(MU_force_rd_request),
	.motion_update_rd_addr(MU_out_rd_addr),
	.force_and_addr_in(force_to_caches),
	.force_wr_enable(force_wr_enable),
	
	.all_force_input_buffer_empty(force_cache_input_buffer_empty), 
	.force_to_MU(force_to_MU),
	.force_id_to_MU(),
	.force_valid_to_MU()
);

all_position_caches
#(
	.NUM_CELLS(NUM_CELLS),
	.DATA_WIDTH(OFFSET_WIDTH),
	.CELL_ID_WIDTH(CELL_ID_WIDTH),
	.NUM_PARTICLE_PER_CELL(NUM_PARTICLE_PER_CELL),
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH)
)
all_position_caches
(
	.clk(clk),
	.rst(rst),
	.rd_addr(particle_id),
	.Motion_Update_enable(Motion_Update_enable),
	.MU_rd_addr(MU_out_rd_addr),
	.MU_rden(MU_out_rd_enable),
	.MU_wr_data(MU_out_position_data),
	.MU_dst_cell(MU_dst_cell),
	.MU_wr_data_valid(MU_out_data_valid),
	
	.pos_data_out(rd_nb_position)
);

all_velocity_caches
#(
	.NUM_CELLS(NUM_CELLS),
	.DATA_WIDTH(DATA_WIDTH),
	.CELL_ID_WIDTH(CELL_ID_WIDTH),
	.NUM_PARTICLE_PER_CELL(NUM_PARTICLE_PER_CELL),
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH)
)
all_velocity_caches
(
	.clk(clk),
	.rst(rst),
	.Motion_Update_enable(Motion_Update_enable),
	.MU_rd_addr(MU_out_rd_addr),
	.MU_rden(MU_out_rd_enable),
	.MU_wr_data(MU_out_velocity_data),
	.MU_dst_cell(MU_dst_cell),
	.MU_wr_data_valid(MU_out_data_valid),
	
	.velocity_data_out(velocity_data_out)
);

motion_update_control
#(
	.OFFSET_WIDTH(OFFSET_WIDTH),
	.DATA_WIDTH(DATA_WIDTH),
  .GLOBAL_CELL_ID_WIDTH($clog2(NUM_CELLS)),
	.FORCE_CACHE_WIDTH(FORCE_CACHE_WIDTH),
	.POS_CACHE_WIDTH(POS_CACHE_WIDTH), 
	.VELOCITY_CACHE_WIDTH(VELOCITY_CACHE_WIDTH), 
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH),
	.CELL_ID_WIDTH(CELL_ID_WIDTH), 
	.NUM_CELLS(NUM_CELLS), 
	.X_DIM(X_DIM), 
	.Y_DIM(Y_DIM), 
	.Z_DIM(Z_DIM)
)
motion_update_control
(
	.clk(clk),
	.rst(rst),
	.motion_update_start(motion_update_start),
	.in_all_force_data(force_to_MU),
	.in_all_velocity_data(velocity_data_out), 
	.in_all_position_data(rd_nb_position), 
	
	.out_position_data(MU_out_position_data),
	.out_velocity_data(MU_out_velocity_data),
	.out_rd_addr(MU_out_rd_addr),
	.out_rd_enable(MU_out_rd_enable),
	.out_data_valid(MU_out_data_valid),
	.out_force_rd_request(MU_force_rd_request), 
	.out_dst_cell(MU_dst_cell), 
	.out_motion_update_enable(Motion_Update_enable), 
	.out_motion_update_done(MU_done)
);

endmodule
