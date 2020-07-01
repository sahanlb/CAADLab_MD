module RL_Force_Evaluation_Unit
#(
	// Data width
	parameter DATA_WIDTH = 32,
	parameter CELL_ID_WIDTH = 3,
	parameter DECIMAL_ADDR_WIDTH = 2, 
	parameter PARTICLE_ID_WIDTH = 7, 
	parameter BODY_BITS = 8, 
	parameter ID_WIDTH = 3*CELL_ID_WIDTH+PARTICLE_ID_WIDTH,
	parameter FILTER_BUFFER_DATA_WIDTH = PARTICLE_ID_WIDTH+3*DATA_WIDTH, 
	
	// Constants
	parameter REF_DELAY = 33, 
	parameter SQRT_2 = 10'b0101101011,
	parameter SQRT_3 = 10'b0110111100,
	parameter NUM_FILTER = 7, 
	parameter ARBITER_MSB = 64, 				// 2^(NUM_FILTER-1)
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
	input [NUM_FILTER-1:0] pair_valid,
	input [PARTICLE_ID_WIDTH-1:0] ref_particle_id,
	input [PARTICLE_ID_WIDTH-1:0] nb_particle_id,
	input [DATA_WIDTH-1:0] ref_x,
	input [DATA_WIDTH-1:0] ref_y,
	input [DATA_WIDTH-1:0] ref_z,
	input [NUM_FILTER*DATA_WIDTH-1:0] nb_x,
	input [NUM_FILTER*DATA_WIDTH-1:0] nb_y,
	input [NUM_FILTER*DATA_WIDTH-1:0] nb_z,
	
	output [PARTICLE_ID_WIDTH-1:0] out_ref_particle_id,
	output [ID_WIDTH-1:0] out_neighbor_particle_id,
	output [DATA_WIDTH-1:0] out_RL_Force_X,
	output [DATA_WIDTH-1:0] out_RL_Force_Y,
	output [DATA_WIDTH-1:0] out_RL_Force_Z,
	output out_forceoutput_valid,
	output [NUM_FILTER-1:0] out_back_pressure_to_input,			// If one of the FIFO is full, then set the back_pressure flag to stop more incoming particle pairs
	output out_all_buffer_empty_to_input								// Output to FSM that generate particle pairs. Only when all the filter buffers are empty, then the FSM will move on to the next reference particle
																					// Avoid the cases when the force pipelines are evaluating for 2 different reference particles when switching after one reference particle, this will lead to the accumulation error for the reference particle
);

	// Assign parameters for A, B, QQ (currently not used)
	wire [DATA_WIDTH-1:0] p_a;
	wire [DATA_WIDTH-1:0] p_b;
	wire [DATA_WIDTH-1:0] p_qq;
	assign p_a  = 32'h40000000;				// p_a = 2, in IEEE floating point format
	assign p_b  = 32'h40800000;				// p_b = 4, in IEEE floating point format
	assign p_qq = 32'h41000000;				// p_qq = 8, in IEEE floating point format

	// Wires connect Filter_Bank and RL_LJ_Evaluate_Pairs_1st_Order
	wire [DATA_WIDTH-1:0] filter_bank_out_r2;
	wire [DATA_WIDTH-1:0] filter_bank_out_dx;
	wire [DATA_WIDTH-1:0] filter_bank_out_dy;
	wire [DATA_WIDTH-1:0] filter_bank_out_dz;
	wire filter_bank_out_r2_valid;
	
	// Delay registers for particle IDs from r2_compute to force output
	wire [ID_WIDTH-1:0] filter_bank_out_neighbor_particle_id;
	reg [ID_WIDTH-1:0] neighbor_particle_id_reg0;
	reg [ID_WIDTH-1:0] neighbor_particle_id_reg1;
	reg [ID_WIDTH-1:0] neighbor_particle_id_reg2;
	reg [ID_WIDTH-1:0] neighbor_particle_id_reg3;
	reg [ID_WIDTH-1:0] neighbor_particle_id_reg4;
	reg [ID_WIDTH-1:0] neighbor_particle_id_reg5;
	reg [ID_WIDTH-1:0] neighbor_particle_id_reg6;
	reg [ID_WIDTH-1:0] neighbor_particle_id_reg7;
	reg [ID_WIDTH-1:0] neighbor_particle_id_reg8;
	reg [ID_WIDTH-1:0] neighbor_particle_id_reg9;
	reg [ID_WIDTH-1:0] neighbor_particle_id_reg10;
	reg [ID_WIDTH-1:0] neighbor_particle_id_reg11;
	reg [ID_WIDTH-1:0] neighbor_particle_id_reg12;
	reg [ID_WIDTH-1:0] neighbor_particle_id_reg13;
	reg [ID_WIDTH-1:0] neighbor_particle_id_reg14;
	reg [ID_WIDTH-1:0] neighbor_particle_id_reg15;
	reg [ID_WIDTH-1:0] neighbor_particle_id_delayed;
	
	reg [PARTICLE_ID_WIDTH-1:0] reg_ref_id;
	reg [5:0] ref_delay_counter;
	// Assign output port
	assign out_ref_particle_id = reg_ref_id;
	assign out_neighbor_particle_id = neighbor_particle_id_delayed;
	
	always@(posedge clk)
		begin
		if (rst)
			begin
			reg_ref_id <= 0;
			ref_delay_counter <= 0;
			end
		else
			begin
			// If input ref particle id changes, keep the previous ref id for REF_DELAY cycles
			if (reg_ref_id != ref_particle_id)
				begin
				ref_delay_counter <= ref_delay_counter + 1'b1;
				if (ref_delay_counter == REF_DELAY)
					begin
					reg_ref_id <= ref_particle_id;
					end
				else
					begin
					reg_ref_id <= reg_ref_id;
					end
				end
			else
				begin
				ref_delay_counter <= 0;
				reg_ref_id <= reg_ref_id;
				end
			end
		end
	
	// Delay register
	always@(posedge clk)
		begin
		if(rst)
			begin
			neighbor_particle_id_reg0 <= 0;
			neighbor_particle_id_reg1 <= 0;
			neighbor_particle_id_reg2 <= 0;
			neighbor_particle_id_reg3 <= 0;
			neighbor_particle_id_reg4 <= 0;
			neighbor_particle_id_reg5 <= 0;
			neighbor_particle_id_reg6 <= 0;
			neighbor_particle_id_reg7 <= 0;
			neighbor_particle_id_reg8 <= 0;
			neighbor_particle_id_reg9 <= 0;
			neighbor_particle_id_reg10 <= 0;
			neighbor_particle_id_reg11 <= 0;
			neighbor_particle_id_reg12 <= 0;
			neighbor_particle_id_reg13 <= 0;
			neighbor_particle_id_reg14 <= 0;
			neighbor_particle_id_reg15 <= 0;
			neighbor_particle_id_delayed <= 0;
			end
		else
			begin
			neighbor_particle_id_reg0 <= filter_bank_out_neighbor_particle_id;
			neighbor_particle_id_reg1 <= neighbor_particle_id_reg0;
			neighbor_particle_id_reg2 <= neighbor_particle_id_reg1;
			neighbor_particle_id_reg3 <= neighbor_particle_id_reg2;
			neighbor_particle_id_reg4 <= neighbor_particle_id_reg3;
			neighbor_particle_id_reg5 <= neighbor_particle_id_reg4;
			neighbor_particle_id_reg6 <= neighbor_particle_id_reg5;
			neighbor_particle_id_reg7 <= neighbor_particle_id_reg6;
			neighbor_particle_id_reg8 <= neighbor_particle_id_reg7;
			neighbor_particle_id_reg9 <= neighbor_particle_id_reg8;
			neighbor_particle_id_reg10 <= neighbor_particle_id_reg9;
			neighbor_particle_id_reg11 <= neighbor_particle_id_reg10;
			neighbor_particle_id_reg12 <= neighbor_particle_id_reg11;
			neighbor_particle_id_delayed <= neighbor_particle_id_reg12;
			end
		end

	// Filters
	filter_bank
	#(
		
		.DATA_WIDTH(DATA_WIDTH),
		.CELL_ID_WIDTH(CELL_ID_WIDTH),
		.DECIMAL_ADDR_WIDTH(DECIMAL_ADDR_WIDTH),
		.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH),
		.BODY_BITS(BODY_BITS),
		.ID_WIDTH(ID_WIDTH),
		.FILTER_BUFFER_DATA_WIDTH(FILTER_BUFFER_DATA_WIDTH),
		.SQRT_2(SQRT_2),
		.SQRT_3(SQRT_3),
		.NUM_FILTER(NUM_FILTER),
		.ARBITER_MSB(ARBITER_MSB),
		.EXP_0(EXP_0)
	)
	Filter_Bank
	(
		.clk(clk),
		.rst(rst),
		.input_valid(pair_valid),
		.nb_id_in(nb_particle_id),
		.ref_x(ref_x),
		.ref_y(ref_y),
		.ref_z(ref_z),
		.nb_x(nb_x),
		.nb_y(nb_y),
		.nb_z(nb_z),
		
		.nb_id_out(filter_bank_out_neighbor_particle_id),
		.r2_out(filter_bank_out_r2),
		.dx_out(filter_bank_out_dx),
		.dy_out(filter_bank_out_dy),
		.dz_out(filter_bank_out_dz),
		.out_valid(filter_bank_out_r2_valid),
		.back_pressure(out_back_pressure_to_input),						// If one of the FIFO is full, then set the back_pressure flag to stop more incoming particle pairs
		.all_buffer_empty(out_all_buffer_empty_to_input)
	);

	// Evaluate Pair-wise Range Limited forces
	// Latency 17 cycles
	RL_LJ_Evaluate_Pairs_1st_Order_normalized #(
		.DATA_WIDTH(DATA_WIDTH),
		.SEGMENT_NUM(SEGMENT_NUM),
		.SEGMENT_WIDTH(SEGMENT_WIDTH),
		.BIN_WIDTH(BIN_WIDTH),
		.BIN_NUM(BIN_NUM),
		.LOOKUP_NUM(LOOKUP_NUM),
		.LOOKUP_ADDR_WIDTH(LOOKUP_ADDR_WIDTH)
	)
	RL_LJ_Evaluate_Pairs(
		.clk(clk),
		.rst(rst),
		.r2_valid(filter_bank_out_r2_valid),
		.r2(filter_bank_out_r2),
		.dx(filter_bank_out_dx),
		.dy(filter_bank_out_dy),
		.dz(filter_bank_out_dz),
		.p_a(p_a),
		.p_b(p_b),
		.p_qq(p_qq),
		
		.LJ_Force_X(out_RL_Force_X),
		.LJ_Force_Y(out_RL_Force_Y),
		.LJ_Force_Z(out_RL_Force_Z),
		.LJ_force_valid(out_forceoutput_valid)
	);



endmodule