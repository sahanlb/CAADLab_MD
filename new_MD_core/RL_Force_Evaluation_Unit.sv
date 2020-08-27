import md_pkg::*;

module RL_Force_Evaluation_Unit(
	input clk,
	input rst,
  input phase,
	input [NUM_FILTER-1:0] pair_valid,
	input particle_id_t ref_particle_id,
	input particle_id_t nb_particle_id,
  input data_tuple_t[NUM_FILTER-1:0] ref_pos,
  input data_tuple_t nb_pos,
	
	output full_id_t out_ref_particle_id, //{CELLL_ID_Z, CELL_ID_Y, CELL_ID_X, PARTICLE_ID}
	output full_id_t out_neighbor_particle_id,
  output data_tuple_t out_RL_Force,
	output out_forceoutput_valid,
	output [NUM_FILTER-1:0] out_back_pressure_to_input,			// If one of the FIFO is full, then set the back_pressure flag to stop more incoming particle pairs
	output out_all_buffer_empty_to_input								// Output to FSM that generate particle pairs. Only when all the filter buffers are empty, then the FSM will move on to the next reference particle
																					// Avoid the cases when the force pipelines are evaluating for 2 different reference particles when switching after one reference particle, this will lead to the accumulation error for the reference particle
);

localparam REF_DELAY = 31;

	// Assign parameters for A, B, QQ (currently not used)
	wire [DATA_WIDTH-1:0] p_a;
	wire [DATA_WIDTH-1:0] p_b;
	wire [DATA_WIDTH-1:0] p_qq;
	assign p_a  = 32'h40000000;				// p_a = 2, in IEEE floating point format
	assign p_b  = 32'h40800000;				// p_b = 4, in IEEE floating point format
	assign p_qq = 32'h41000000;				// p_qq = 8, in IEEE floating point format

	// Wires connect Filter_Bank and RL_LJ_Evaluate_Pairs_1st_Order
	wire [DATA_WIDTH-1:0] filter_bank_out_r2;
  data_tuple_t filter_bank_out_d;
	wire filter_bank_out_r2_valid;

	// Delay registers for reference particles' cell IDs from filter_bank to force output
  full_cell_id_t  filter_bank_out_ref_cell_id;
	full_cell_id_t  ref_cell_id_reg0;
	full_cell_id_t  ref_cell_id_reg1;
	full_cell_id_t  ref_cell_id_reg2;
	full_cell_id_t  ref_cell_id_reg3;
	full_cell_id_t  ref_cell_id_reg4;
	full_cell_id_t  ref_cell_id_reg5;
	full_cell_id_t  ref_cell_id_reg6;
	full_cell_id_t  ref_cell_id_reg7;
	full_cell_id_t  ref_cell_id_reg8;
	full_cell_id_t  ref_cell_id_reg9;
	full_cell_id_t  ref_cell_id_reg10;
	full_cell_id_t  ref_cell_id_reg11;
	full_cell_id_t  ref_cell_id_reg12;
	full_cell_id_t  ref_cell_id_reg13;
	full_cell_id_t  ref_cell_id_reg14;
	full_cell_id_t  ref_cell_id_reg15;
	full_cell_id_t  ref_cell_id_delayed;
	
	// Delay registers for particle IDs from r2_compute to force output
	full_id_t  filter_bank_out_neighbor_particle_id;
	full_id_t  neighbor_particle_id_reg0;
	full_id_t  neighbor_particle_id_reg1;
	full_id_t  neighbor_particle_id_reg2;
	full_id_t  neighbor_particle_id_reg3;
	full_id_t  neighbor_particle_id_reg4;
	full_id_t  neighbor_particle_id_reg5;
	full_id_t  neighbor_particle_id_reg6;
	full_id_t  neighbor_particle_id_reg7;
	full_id_t  neighbor_particle_id_reg8;
	full_id_t  neighbor_particle_id_reg9;
	full_id_t  neighbor_particle_id_reg10;
	full_id_t  neighbor_particle_id_reg11;
	full_id_t  neighbor_particle_id_reg12;
	full_id_t  neighbor_particle_id_reg13;
	full_id_t  neighbor_particle_id_reg14;
	full_id_t  neighbor_particle_id_reg15;
	full_id_t  neighbor_particle_id_delayed;
	
	particle_id_t reg_ref_id;
	reg [5:0] ref_delay_counter;
	// Assign output port
	assign out_ref_particle_id = {ref_cell_id_delayed, reg_ref_id}; 
  //ref ID does not change every cycle. Therefore, only the cell ID fields are assigned in the filter bank 
  //alongside neighbor particle ID.
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
			neighbor_particle_id_reg0    <= 0;
			neighbor_particle_id_reg1    <= 0;
			neighbor_particle_id_reg2    <= 0;
			neighbor_particle_id_reg3    <= 0;
			neighbor_particle_id_reg4    <= 0;
			neighbor_particle_id_reg5    <= 0;
			neighbor_particle_id_reg6    <= 0;
			neighbor_particle_id_reg7    <= 0;
			neighbor_particle_id_reg8    <= 0;
			neighbor_particle_id_reg9    <= 0;
			neighbor_particle_id_reg10   <= 0;
			neighbor_particle_id_reg11   <= 0;
			neighbor_particle_id_reg12   <= 0;
			neighbor_particle_id_reg13   <= 0;
			neighbor_particle_id_reg14   <= 0;
			neighbor_particle_id_reg15   <= 0;
			neighbor_particle_id_delayed <= 0;
			ref_cell_id_reg0    <= 0;
			ref_cell_id_reg1    <= 0;
			ref_cell_id_reg2    <= 0;
			ref_cell_id_reg3    <= 0;
			ref_cell_id_reg4    <= 0;
			ref_cell_id_reg5    <= 0;
			ref_cell_id_reg6    <= 0;
			ref_cell_id_reg7    <= 0;
			ref_cell_id_reg8    <= 0;
			ref_cell_id_reg9    <= 0;
			ref_cell_id_reg10   <= 0;
			ref_cell_id_reg11   <= 0;
			ref_cell_id_reg12   <= 0;
			ref_cell_id_reg13   <= 0;
			ref_cell_id_reg14   <= 0;
			ref_cell_id_reg15   <= 0;
			ref_cell_id_delayed <= 0;
			end
		else
			begin
			neighbor_particle_id_reg0    <= filter_bank_out_neighbor_particle_id;
			neighbor_particle_id_reg1    <= neighbor_particle_id_reg0;
			neighbor_particle_id_reg2    <= neighbor_particle_id_reg1;
			neighbor_particle_id_reg3    <= neighbor_particle_id_reg2;
			neighbor_particle_id_reg4    <= neighbor_particle_id_reg3;
			neighbor_particle_id_reg5    <= neighbor_particle_id_reg4;
			neighbor_particle_id_reg6    <= neighbor_particle_id_reg5;
			neighbor_particle_id_reg7    <= neighbor_particle_id_reg6;
			neighbor_particle_id_reg8    <= neighbor_particle_id_reg7;
			neighbor_particle_id_reg9    <= neighbor_particle_id_reg8;
			neighbor_particle_id_reg10   <= neighbor_particle_id_reg9;
			neighbor_particle_id_reg11   <= neighbor_particle_id_reg10;
			neighbor_particle_id_reg12   <= neighbor_particle_id_reg11;
			neighbor_particle_id_delayed <= neighbor_particle_id_reg12;
			ref_cell_id_reg0    <= filter_bank_out_ref_cell_id;
			ref_cell_id_reg1    <= ref_cell_id_reg0;
			ref_cell_id_reg2    <= ref_cell_id_reg1;
			ref_cell_id_reg3    <= ref_cell_id_reg2;
			ref_cell_id_reg4    <= ref_cell_id_reg3;
			ref_cell_id_reg5    <= ref_cell_id_reg4;
			ref_cell_id_reg6    <= ref_cell_id_reg5;
			ref_cell_id_reg7    <= ref_cell_id_reg6;
			ref_cell_id_reg8    <= ref_cell_id_reg7;
			ref_cell_id_reg9    <= ref_cell_id_reg8;
			ref_cell_id_reg10   <= ref_cell_id_reg9;
			ref_cell_id_reg11   <= ref_cell_id_reg10;
			ref_cell_id_reg12   <= ref_cell_id_reg11;
			ref_cell_id_delayed <= ref_cell_id_reg12;
			end
		end

	// Filters
	filter_bank
	Filter_Bank(
		.clk(clk),
		.rst(rst),
    .phase(phase),
		.input_valid(pair_valid),
		.nb_id_in(nb_particle_id),
    .ref_pos(ref_pos),
    .nb_pos(nb_pos),
		
		.nb_id_out(filter_bank_out_neighbor_particle_id),
    .ref_cell_id_out(filter_bank_out_ref_cell_id),
		.r2_out(filter_bank_out_r2),
    .d_out(filter_bank_out_d),
		.out_valid(filter_bank_out_r2_valid),
		.back_pressure(out_back_pressure_to_input),						// If one of the FIFO is full, then set the back_pressure flag to stop more incoming particle pairs
		.all_buffer_empty(out_all_buffer_empty_to_input)
	);

	// Evaluate Pair-wise Range Limited forces
	// Latency 17 cycles
	RL_LJ_Evaluate_Pairs_1st_Order_normalized
	RL_LJ_Evaluate_Pairs(
		.clk(clk),
		.rst(rst),
		.r2_valid(filter_bank_out_r2_valid),
		.r2(filter_bank_out_r2),
    .d_in(filter_bank_out_d),
		.p_a(p_a),
		.p_b(p_b),
		.p_qq(p_qq),
		
    .LJ_Force_out(out_RL_Force),
		.LJ_force_valid(out_forceoutput_valid)
	);



endmodule
