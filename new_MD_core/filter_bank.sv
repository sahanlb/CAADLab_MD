import md_pkg::*;

module filter_bank(
	input clk, 
	input rst, 
  input phase,
	input [NUM_FILTER-1:0] input_valid,
	input particle_id_t nb_id_in,
  input data_tuple_t [NUM_FILTER-1:0] ref_pos,
  input data_tuple_t nb_pos,
	
  output full_id_t nb_id_out,
  output full_cell_id_t ref_cell_id_out,
	output [DATA_WIDTH-1:0] r2_out,
  output data_tuple_t d_out,
	output out_valid,
	output [NUM_FILTER-1:0] back_pressure, // If one of the FIFO is full, then set the back_pressure flag to stop more incoming particle pairs
	output all_buffer_empty
);

wire [NUM_FILTER-1:0] buffer_empty;
position_data_t [NUM_FILTER-1:0] buffer_rd_data;
wire [NUM_FILTER-1:0] arbitration_result;

reg raw_data_valid;
position_data_t data_out;

data_tuple_t curr_ref_data;

full_id_t nb_id;
full_cell_id_t ref_cell_id;

// Fixed point format
fixed_position_t x1, y1, z1, x2, y2, z2;

// Floating point format
wire [DATA_WIDTH-1:0] x1_f, y1_f, z1_f, x2_f, y2_f, z2_f;

full_id_t reg_nb_id_1;
full_id_t reg_nb_id_2;
full_id_t reg_nb_id_3;
full_id_t reg_nb_id_4;
full_id_t reg_nb_id_5;
full_id_t reg_nb_id_6;
full_id_t reg_nb_id_7;
full_id_t reg_nb_id_8;
full_id_t reg_nb_id_9;
full_id_t reg_nb_id_10;
full_id_t reg_nb_id_11;
full_id_t reg_nb_id_12;
full_id_t reg_nb_id_13;
full_id_t reg_nb_id_14;
full_id_t reg_nb_id_15;
full_id_t reg_nb_id_16;
full_id_t reg_nb_id_delay;

full_cell_id_t reg_ref_cell_id_1;
full_cell_id_t reg_ref_cell_id_2;
full_cell_id_t reg_ref_cell_id_3;
full_cell_id_t reg_ref_cell_id_4;
full_cell_id_t reg_ref_cell_id_5;
full_cell_id_t reg_ref_cell_id_6;
full_cell_id_t reg_ref_cell_id_7;
full_cell_id_t reg_ref_cell_id_8;
full_cell_id_t reg_ref_cell_id_9;
full_cell_id_t reg_ref_cell_id_10;
full_cell_id_t reg_ref_cell_id_11;
full_cell_id_t reg_ref_cell_id_12;
full_cell_id_t reg_ref_cell_id_13;
full_cell_id_t reg_ref_cell_id_14;
full_cell_id_t reg_ref_cell_id_15;
full_cell_id_t reg_ref_cell_id_16;
full_cell_id_t reg_ref_cell_id_delay;

// Disassemble data_out
assign x1 = curr_ref_data.data_x;
assign y1 = curr_ref_data.data_y;
assign z1 = curr_ref_data.data_z;
assign x2 = data_out.position.data_x;
assign y2 = data_out.position.data_y;
assign z2 = data_out.position.data_z;

// Combine cell id and particle id for later mapping. The cell id data is lost after subtraction, so save it here
// ref data is the same as the input, because the ref data will not change before all filter buffers are empty,
// so no need to save the ref data
assign nb_id = {z2.cell_id, y2.cell_id, x2.cell_id, data_out.particle_id};
assign nb_id_out = reg_nb_id_delay;

assign ref_cell_id_out = reg_ref_cell_id_delay;


always@(posedge clk)
	begin
	if (rst)
		begin
		reg_nb_id_1           <= 0;
		reg_nb_id_2           <= 0;
		reg_nb_id_3           <= 0;
		reg_nb_id_4           <= 0;
		reg_nb_id_5           <= 0;
		reg_nb_id_6           <= 0;
		reg_nb_id_7           <= 0;
		reg_nb_id_8           <= 0;
		reg_nb_id_9           <= 0;
		reg_nb_id_10          <= 0;
		reg_nb_id_11          <= 0;
		reg_nb_id_12          <= 0;
		reg_nb_id_13          <= 0;
		reg_nb_id_14          <= 0;
		reg_nb_id_15          <= 0;
		reg_nb_id_16          <= 0;
		reg_nb_id_delay       <= 0;
		reg_ref_cell_id_1     <= 0;
		reg_ref_cell_id_2     <= 0;
		reg_ref_cell_id_3     <= 0;
		reg_ref_cell_id_4     <= 0;
		reg_ref_cell_id_5     <= 0;
		reg_ref_cell_id_6     <= 0;
		reg_ref_cell_id_7     <= 0;
		reg_ref_cell_id_8     <= 0;
		reg_ref_cell_id_9     <= 0;
		reg_ref_cell_id_10    <= 0;
		reg_ref_cell_id_11    <= 0;
		reg_ref_cell_id_12    <= 0;
		reg_ref_cell_id_13    <= 0;
		reg_ref_cell_id_14    <= 0;
		reg_ref_cell_id_15    <= 0;
		reg_ref_cell_id_16    <= 0;
		reg_ref_cell_id_delay <= 0;
		end
	else
		begin
		reg_nb_id_1           <= nb_id;
		reg_nb_id_2           <= reg_nb_id_1;
		reg_nb_id_3           <= reg_nb_id_2;
		reg_nb_id_4           <= reg_nb_id_3;
		reg_nb_id_5           <= reg_nb_id_4;
		reg_nb_id_6           <= reg_nb_id_5;
		reg_nb_id_7           <= reg_nb_id_6;
		reg_nb_id_8           <= reg_nb_id_7;
		reg_nb_id_9           <= reg_nb_id_8;
		reg_nb_id_10          <= reg_nb_id_9;
		reg_nb_id_11          <= reg_nb_id_10;
		reg_nb_id_12          <= reg_nb_id_11;
		reg_nb_id_13          <= reg_nb_id_12;
		reg_nb_id_14          <= reg_nb_id_13;
		reg_nb_id_15          <= reg_nb_id_14;
		reg_nb_id_16          <= reg_nb_id_15;
		reg_nb_id_delay       <= reg_nb_id_16;
		reg_ref_cell_id_1     <= ref_cell_id;
		reg_ref_cell_id_2     <= reg_ref_cell_id_1;
		reg_ref_cell_id_3     <= reg_ref_cell_id_2;
		reg_ref_cell_id_4     <= reg_ref_cell_id_3;
		reg_ref_cell_id_5     <= reg_ref_cell_id_4;
		reg_ref_cell_id_6     <= reg_ref_cell_id_5;
		reg_ref_cell_id_7     <= reg_ref_cell_id_6;
		reg_ref_cell_id_8     <= reg_ref_cell_id_7;
		reg_ref_cell_id_9     <= reg_ref_cell_id_8;
		reg_ref_cell_id_10    <= reg_ref_cell_id_9;
		reg_ref_cell_id_11    <= reg_ref_cell_id_10;
		reg_ref_cell_id_12    <= reg_ref_cell_id_11;
		reg_ref_cell_id_13    <= reg_ref_cell_id_12;
		reg_ref_cell_id_14    <= reg_ref_cell_id_13;
		reg_ref_cell_id_15    <= reg_ref_cell_id_14;
		reg_ref_cell_id_16    <= reg_ref_cell_id_15;
		reg_ref_cell_id_delay <= reg_ref_cell_id_16;
		end
	end

// save the arbitration result for further use
reg  [NUM_FILTER-1:0] prev_arbitration_result;	
always@(posedge clk)begin
	prev_arbitration_result <= arbitration_result;
end

assign all_buffer_empty = &buffer_empty;


// Choose the data out
always@(posedge clk)
	begin
	case(prev_arbitration_result)
		7'b0000001:
			begin
			data_out       <= buffer_rd_data[0];
      curr_ref_data  <= ref_pos[0];
			raw_data_valid <= 1'b1;
      ref_cell_id    <= phase ? {CELL_3, CELL_1, CELL_3} : {CELL_2, CELL_2, CELL_2};
			end
		7'b0000010:
			begin
			data_out       <= buffer_rd_data[1];
      curr_ref_data  <= ref_pos[1];
			raw_data_valid <= 1'b1;
      ref_cell_id    <= phase ? {CELL_3, CELL_2, CELL_1} : {CELL_2, CELL_2, CELL_3};
			end
		7'b0000100:
			begin
			data_out       <= buffer_rd_data[2];
      curr_ref_data  <= ref_pos[2];
			raw_data_valid <= 1'b1;
      ref_cell_id    <= phase ? {CELL_3, CELL_2, CELL_2} : {CELL_2, CELL_3, CELL_1};
			end
		7'b0001000:
			begin
			data_out       <= buffer_rd_data[3];
      curr_ref_data  <= ref_pos[3];
			raw_data_valid <= 1'b1;
      ref_cell_id    <= phase ? {CELL_3, CELL_2, CELL_3} : {CELL_2, CELL_3, CELL_2};
			end
		7'b0010000:
			begin
			data_out       <= buffer_rd_data[4];
      curr_ref_data  <= ref_pos[4];
			raw_data_valid <= 1'b1;
      ref_cell_id    <= phase ? {CELL_3, CELL_3, CELL_1} : {CELL_2, CELL_3, CELL_3};
			end
		7'b0100000:
			begin
			data_out       <= buffer_rd_data[5];
      curr_ref_data  <= ref_pos[5];
			raw_data_valid <= 1'b1;
      ref_cell_id    <= phase ? {CELL_3, CELL_3, CELL_2} : {CELL_3, CELL_1, CELL_1};
			end
		7'b1000000:
			begin
			data_out       <= buffer_rd_data[6];
      curr_ref_data  <= ref_pos[6];
			raw_data_valid <= 1'b1;
      ref_cell_id    <= phase ? {CELL_3, CELL_3, CELL_3} : {CELL_3, CELL_1, CELL_2};
			end
		default:
			begin
			data_out       <= 0;
      curr_ref_data  <= ref_pos[0];
			raw_data_valid <= 1'b0;
      ref_cell_id    <= phase ? {CELL_3, CELL_1, CELL_3} : {CELL_2, CELL_2, CELL_2};
			end
	endcase
	end
	
	
// 7 filters
genvar i;
generate 
	for(i = 0; i < NUM_FILTER-1; i = i + 1) begin: Filter_Unit
	filter_logic
	#(
		.FILTER_BUFFER_DEPTH(32), 
		.BACK_PRESSURE_THRESHOLD(27)
	)
	filter_logic
	(
		.clk(clk),
		.rst(rst),
		.x1(ref_pos[i+1].data_x),
		.y1(ref_pos[i+1].data_y),
		.z1(ref_pos[i+1].data_z), 
		.x2(nb_pos.data_x),
		.y2(nb_pos.data_y),
		.z2(nb_pos.data_z), 
		.cell_id_2(nb_id_in), 
		.buffer_rd_en(arbitration_result[i+1]), 
		.input_valid(input_valid[i+1]), 
		
		.buffer_rd_data(buffer_rd_data[i+1]),
		.buffer_empty(buffer_empty[i+1]),
		.back_pressure(back_pressure[i+1])
	);
	end
endgenerate

// home filter buffer is deeper (64)
filter_logic
#(
	.FILTER_BUFFER_DEPTH(64), 
	.BACK_PRESSURE_THRESHOLD(59)
)
filter_logic_home
(
	.clk(clk),
	.rst(rst),
	.x1(ref_pos[0].data_x),
	.y1(ref_pos[0].data_y),
	.z1(ref_pos[0].data_z), 
	.x2(nb_pos.data_x),
	.y2(nb_pos.data_y),
	.z2(nb_pos.data_z), 
	.cell_id_2(nb_id_in), 
	.buffer_rd_en(arbitration_result[0]), 
	.input_valid(input_valid[0]), 
	
	.buffer_rd_data(buffer_rd_data[0]),
	.buffer_empty(buffer_empty[0]),
	.back_pressure(back_pressure[0])
);

// Filter arbiter
filter_arbiter
filter_arbiter(
	.clk(clk),
	.rst(rst),
	.Filter_Available_Flag(~buffer_empty),
	.Arbitration_Result(arbitration_result)
);

// Convert fixed point to floating point
// The initial values are 0 for fixed point numbers but 1 for float, it shouldn't matter
fixed2float
fixed2float_x1(
	.a(x1), 
	.q(x1_f)
);

fixed2float
fixed2float_y1(
	.a(y1), 
	.q(y1_f)
);

fixed2float
fixed2float_z1(
	.a(z1), 
	.q(z1_f)
);

fixed2float
fixed2float_x2(
	.a(x2), 
	.q(x2_f)
);

fixed2float
fixed2float_y2(
	.a(y2), 
	.q(y2_f)
);

fixed2float
fixed2float_z2(
	.a(z2), 
	.q(z2_f)
);


r2_compute
r2_compute(
	.clk(clk),
	.rst(rst),
	.enable(raw_data_valid),
	.refx(x1_f),
	.refy(y1_f),
	.refz(z1_f),
	.neighborx(x2_f),
	.neighbory(y2_f),
	.neighborz(z2_f),
	.r2(r2_out),
	.d_out(d_out),
	.r2_valid(out_valid)
);


endmodule
