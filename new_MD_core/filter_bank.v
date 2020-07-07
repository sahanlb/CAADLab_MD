module filter_bank
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
  parameter CELL_1      = 3'b001
  parameter CELL_2      = 3'b010
  parameter CELL_3      = 3'b011
	parameter SQRT_2      = 10'b0101101011,
	parameter SQRT_3      = 10'b0110111100,
	parameter NUM_FILTER  = 7, 
	parameter ARBITER_MSB = 64, 
	parameter EXP_0       = 8'b01111111
)
(
	input clk, 
	input rst, 
  input phase,
	input [NUM_FILTER-1:0] input_valid,
	input [PARTICLE_ID_WIDTH-1:0] nb_id_in,
	input [NUM_FILTER-1:0][DATA_WIDTH-1:0] ref_x,
	input [NUM_FILTER-1:0][DATA_WIDTH-1:0] ref_y,
	input [NUM_FILTER-1:0][DATA_WIDTH-1:0] ref_z,
	input [NUM_FILTER*DATA_WIDTH-1:0] nb_x,
	input [NUM_FILTER*DATA_WIDTH-1:0] nb_y,
	input [NUM_FILTER*DATA_WIDTH-1:0] nb_z,
	
	output [ID_WIDTH-1:0] nb_id_out,
  output [2:0][CELL_ID_WIDTH-1:0] ref_cell_id_out, //{Z,Y,X}
	output [DATA_WIDTH-1:0] r2_out,
	output [DATA_WIDTH-1:0] dx_out,
	output [DATA_WIDTH-1:0] dy_out,
	output [DATA_WIDTH-1:0] dz_out,
	output out_valid,
	output [NUM_FILTER-1:0] back_pressure,				// If one of the FIFO is full, then set the back_pressure flag to stop more incoming particle pairs
	output all_buffer_empty
);

wire [NUM_FILTER-1:0] buffer_empty;
wire [NUM_FILTER*FILTER_BUFFER_DATA_WIDTH-1:0] buffer_rd_data;
wire [NUM_FILTER-1:0] arbitration_result;

reg raw_data_valid;
reg [FILTER_BUFFER_DATA_WIDTH-1:0] data_out;

struct packed{
  logic [DATA_WIDTH-1:0] z,
  logic [DATA_WIDTH-1:0] y,
  logic [DATA_WIDTH-1:0] x,
}curr_ref_data;

wire [ID_WIDTH-1:0] nb_id;
reg [2:0][CELL_ID_WIDTH-1:0] ref_cell_id;

// Fixed point format
wire [DATA_WIDTH-1:0] x1, y1, z1, x2, y2, z2;

// Floating point format
wire [DATA_WIDTH-1:0] x1_f, y1_f, z1_f, x2_f, y2_f, z2_f;

reg [ID_WIDTH-1:0] reg_nb_id_1;
reg [ID_WIDTH-1:0] reg_nb_id_2;
reg [ID_WIDTH-1:0] reg_nb_id_3;
reg [ID_WIDTH-1:0] reg_nb_id_4;
reg [ID_WIDTH-1:0] reg_nb_id_5;
reg [ID_WIDTH-1:0] reg_nb_id_6;
reg [ID_WIDTH-1:0] reg_nb_id_7;
reg [ID_WIDTH-1:0] reg_nb_id_8;
reg [ID_WIDTH-1:0] reg_nb_id_9;
reg [ID_WIDTH-1:0] reg_nb_id_10;
reg [ID_WIDTH-1:0] reg_nb_id_11;
reg [ID_WIDTH-1:0] reg_nb_id_12;
reg [ID_WIDTH-1:0] reg_nb_id_13;
reg [ID_WIDTH-1:0] reg_nb_id_14;
reg [ID_WIDTH-1:0] reg_nb_id_15;
reg [ID_WIDTH-1:0] reg_nb_id_16;
reg [ID_WIDTH-1:0] reg_nb_id_delay;

reg [2:0][CELL_ID_WIDTH-1:0] reg_ref_cell_id_1;
reg [2:0][CELL_ID_WIDTH-1:0] reg_ref_cell_id_2;
reg [2:0][CELL_ID_WIDTH-1:0] reg_ref_cell_id_3;
reg [2:0][CELL_ID_WIDTH-1:0] reg_ref_cell_id_4;
reg [2:0][CELL_ID_WIDTH-1:0] reg_ref_cell_id_5;
reg [2:0][CELL_ID_WIDTH-1:0] reg_ref_cell_id_6;
reg [2:0][CELL_ID_WIDTH-1:0] reg_ref_cell_id_7;
reg [2:0][CELL_ID_WIDTH-1:0] reg_ref_cell_id_8;
reg [2:0][CELL_ID_WIDTH-1:0] reg_ref_cell_id_9;
reg [2:0][CELL_ID_WIDTH-1:0] reg_ref_cell_id_10;
reg [2:0][CELL_ID_WIDTH-1:0] reg_ref_cell_id_11;
reg [2:0][CELL_ID_WIDTH-1:0] reg_ref_cell_id_12;
reg [2:0][CELL_ID_WIDTH-1:0] reg_ref_cell_id_13;
reg [2:0][CELL_ID_WIDTH-1:0] reg_ref_cell_id_14;
reg [2:0][CELL_ID_WIDTH-1:0] reg_ref_cell_id_15;
reg [2:0][CELL_ID_WIDTH-1:0] reg_ref_cell_id_16;
reg [2:0][CELL_ID_WIDTH-1:0] reg_ref_cell_id_delay;

// Combine cell id and particle id for later mapping. The cell id data is lost after subtraction, so save it here
// ref data is the same as the input, because the ref data will not change before all filter buffers are empty,
// so no need to save the ref data
assign nb_id = {z2[DATA_WIDTH-1:DATA_WIDTH-CELL_ID_WIDTH], 
					  y2[DATA_WIDTH-1:DATA_WIDTH-CELL_ID_WIDTH], 
					  x2[DATA_WIDTH-1:DATA_WIDTH-CELL_ID_WIDTH], 
					  data_out[FILTER_BUFFER_DATA_WIDTH-1:FILTER_BUFFER_DATA_WIDTH-PARTICLE_ID_WIDTH]};
assign nb_id_out = reg_nb_id_delay;

assign ref_cell_id_out = reg_ref_cell_id_delay;

// Disassemble data_out
assign x1 = curr_ref_data.x;
assign y1 = curr_ref_data.y;
assign z1 = curr_ref_data.z;
assign x2 = data_out[DATA_WIDTH-1:0];
assign y2 = data_out[2*DATA_WIDTH-1:DATA_WIDTH];
assign z2 = data_out[3*DATA_WIDTH-1:2*DATA_WIDTH];

always@(posedge clk)
	begin
	if (rst)
		begin
		reg_nb_id_1 <= 0;
		reg_nb_id_2 <= 0;
		reg_nb_id_3 <= 0;
		reg_nb_id_4 <= 0;
		reg_nb_id_5 <= 0;
		reg_nb_id_6 <= 0;
		reg_nb_id_7 <= 0;
		reg_nb_id_8 <= 0;
		reg_nb_id_9 <= 0;
		reg_nb_id_10 <= 0;
		reg_nb_id_11 <= 0;
		reg_nb_id_12 <= 0;
		reg_nb_id_13 <= 0;
		reg_nb_id_14 <= 0;
		reg_nb_id_15 <= 0;
		reg_nb_id_16 <= 0;
		reg_nb_id_delay <= 0;
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
		reg_nb_id_1 <= nb_id;
		reg_nb_id_2 <= reg_nb_id_1;
		reg_nb_id_3 <= reg_nb_id_2;
		reg_nb_id_4 <= reg_nb_id_3;
		reg_nb_id_5 <= reg_nb_id_4;
		reg_nb_id_6 <= reg_nb_id_5;
		reg_nb_id_7 <= reg_nb_id_6;
		reg_nb_id_8 <= reg_nb_id_7;
		reg_nb_id_9 <= reg_nb_id_8;
		reg_nb_id_10 <= reg_nb_id_9;
		reg_nb_id_11 <= reg_nb_id_10;
		reg_nb_id_12 <= reg_nb_id_11;
		reg_nb_id_13 <= reg_nb_id_12;
		reg_nb_id_14 <= reg_nb_id_13;
		reg_nb_id_15 <= reg_nb_id_14;
		reg_nb_id_16 <= reg_nb_id_15;
		reg_nb_id_delay <= reg_nb_id_16;
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
always@(posedge clk)
	begin
	prev_arbitration_result <= arbitration_result;
	end

assign all_buffer_empty = buffer_empty == {(NUM_FILTER){1'b1}} ? 1'b1 : 1'b0;


// Choose the data out
always@(posedge clk)
	begin
	case(prev_arbitration_result)
		7'b0000001:
			begin
			data_out <= buffer_rd_data[1*FILTER_BUFFER_DATA_WIDTH-1:0];
      curr_ref_data.x <= ref_x[0];
      curr_ref_data.y <= ref_y[0];
      curr_ref_data.z <= ref_z[0];
			raw_data_valid  <= 1'b1;
      ref_cell_id     <= phase ? {CELL_1, CELL_1, CELL_1} : {CELL_2, CELL_2, CELL_2};
			end
		7'b0000010:
			begin
			data_out <= buffer_rd_data[2*FILTER_BUFFER_DATA_WIDTH-1:1*FILTER_BUFFER_DATA_WIDTH];
      curr_ref_data.x <= ref_x[1];
      curr_ref_data.y <= ref_y[1];
      curr_ref_data.z <= ref_z[1];
			raw_data_valid  <= 1'b1;
      ref_cell_id     <= phase ? {CELL_1, CELL_2, CELL_1} : {CELL_3, CELL_2, CELL_1};
			end
		7'b0000100:
			begin
			data_out <= buffer_rd_data[3*FILTER_BUFFER_DATA_WIDTH-1:2*FILTER_BUFFER_DATA_WIDTH];
      curr_ref_data.x <= ref_x[2];
      curr_ref_data.y <= ref_y[2];
      curr_ref_data.z <= ref_z[2];
			raw_data_valid  <= 1'b1;
      ref_cell_id     <= phase ? {CELL_1, CELL_3, CELL_2} : {CELL_2, CELL_3, CELL_3};
			end
		7'b0001000:
			begin
			data_out <= buffer_rd_data[4*FILTER_BUFFER_DATA_WIDTH-1:3*FILTER_BUFFER_DATA_WIDTH];
      curr_ref_data.x <= ref_x[3];
      curr_ref_data.y <= ref_y[3];
      curr_ref_data.z <= ref_z[3];
			raw_data_valid  <= 1'b1;
      ref_cell_id     <= phase ? {CELL_2, CELL_3, CELL_1} : {CELL_1, CELL_1, CELL_2};
			end
		7'b0010000:
			begin
			data_out <= buffer_rd_data[5*FILTER_BUFFER_DATA_WIDTH-1:4*FILTER_BUFFER_DATA_WIDTH];
      curr_ref_data.x <= ref_x[4];
      curr_ref_data.y <= ref_y[4];
      curr_ref_data.z <= ref_z[4];
			raw_data_valid  <= 1'b1;
      ref_cell_id     <= phase ? {CELL_2, CELL_2, CELL_3} : {CELL_1, CELL_3, CELL_1};
			end
		7'b0100000:
			begin
			data_out <= buffer_rd_data[6*FILTER_BUFFER_DATA_WIDTH-1:5*FILTER_BUFFER_DATA_WIDTH];
      curr_ref_data.x <= ref_x[5];
      curr_ref_data.y <= ref_y[5];
      curr_ref_data.z <= ref_z[5];
			raw_data_valid  <= 1'b1;
      ref_cell_id     <= phase ? {CELL_2, CELL_1, CELL_2} : {CELL_1, CELL_3, CELL_3};
			end
		7'b1000000:
			begin
			data_out <= buffer_rd_data[7*FILTER_BUFFER_DATA_WIDTH-1:6*FILTER_BUFFER_DATA_WIDTH];
      curr_ref_data.x <= ref_x[6];
      curr_ref_data.y <= ref_y[6];
      curr_ref_data.z <= ref_z[6];
			raw_data_valid  <= 1'b1;
      ref_cell_id     <= phase ? {CELL_3, CELL_2, CELL_2} : {CELL_1, CELL_1, CELL_3};
			end
		default:
			begin
			data_out <= 0;
      curr_ref_data.x <= ref_x[0];
      curr_ref_data.y <= ref_y[0];
      curr_ref_data.z <= ref_z[0];
			raw_data_valid  <= 1'b0;
      ref_cell_id     <= phase ? {CELL_1, CELL_1, CELL_1} : {CELL_2, CELL_2, CELL_2};
			end
	endcase
	end
	
	
// 7 filters
genvar i;
generate 
	for(i = 0; i < NUM_FILTER-1; i = i + 1) begin: Filter_Unit
	filter_logic
	#(
		.DATA_WIDTH(DATA_WIDTH),
		.CELL_ID_WIDTH(CELL_ID_WIDTH),
		.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH),
		.FILTER_BUFFER_DATA_WIDTH(FILTER_BUFFER_DATA_WIDTH),
		.BODY_BITS(BODY_BITS),
		.FILTER_BUFFER_DEPTH(32), 
		.FILTER_BUFFER_ADDR_WIDTH(5), 
		.BUFFER_USEDW_WIDTH(5), 
		.SQRT_2(SQRT_2),
		.SQRT_3(SQRT_3),
		.BACK_PRESSURE_THRESHOLD(27)
	)
	filter_logic
	(
		.clk(clk),
		.rst(rst),
		.x1(ref_x[i+1]),
		.y1(ref_y[i+1]),
		.z1(ref_z[i+1]), 
		.x2(nb_x[(i+2)*DATA_WIDTH-1:(i+1)*DATA_WIDTH]),
		.y2(nb_y[(i+2)*DATA_WIDTH-1:(i+1)*DATA_WIDTH]),
		.z2(nb_z[(i+2)*DATA_WIDTH-1:(i+1)*DATA_WIDTH]), 
		.cell_id_2(nb_id_in), 
		.buffer_rd_en(arbitration_result[i+1]), 
		.input_valid(input_valid[i+1]), 
		
		.buffer_rd_data(buffer_rd_data[(i+2)*FILTER_BUFFER_DATA_WIDTH-1:(i+1)*FILTER_BUFFER_DATA_WIDTH]),
		.buffer_empty(buffer_empty[i+1]),
		.back_pressure(back_pressure[i+1])
	);
	end
endgenerate

// home filter buffer is deeper (64)
filter_logic
#(
	.DATA_WIDTH(DATA_WIDTH),
	.CELL_ID_WIDTH(CELL_ID_WIDTH),
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH),
	.FILTER_BUFFER_DATA_WIDTH(FILTER_BUFFER_DATA_WIDTH),
	.BODY_BITS(BODY_BITS),
	.FILTER_BUFFER_DEPTH(64), 
	.FILTER_BUFFER_ADDR_WIDTH(6), 
	.BUFFER_USEDW_WIDTH(6), 
	.SQRT_2(SQRT_2),
	.SQRT_3(SQRT_3),
	.BACK_PRESSURE_THRESHOLD(59)
)
filter_logic_home
(
	.clk(clk),
	.rst(rst),
	.x1(ref_x[0]),
	.y1(ref_y[0]),
	.z1(ref_z[0]), 
	.x2(nb_x[DATA_WIDTH-1:0]),
	.y2(nb_y[DATA_WIDTH-1:0]),
	.z2(nb_z[DATA_WIDTH-1:0]), 
	.cell_id_2(nb_id_in), 
	.buffer_rd_en(arbitration_result[0]), 
	.input_valid(input_valid[0]), 
	
	.buffer_rd_data(buffer_rd_data[FILTER_BUFFER_DATA_WIDTH-1:0]),
	.buffer_empty(buffer_empty[0]),
	.back_pressure(back_pressure[0])
);

// Filter arbiter
filter_arbiter
#(
	.NUM_FILTER(NUM_FILTER),
	.ARBITER_MSB(ARBITER_MSB)
)
filter_arbiter
(
	.clk(clk),
	.rst(rst),
	.Filter_Available_Flag(~buffer_empty),
	.Arbitration_Result(arbitration_result)
);

// Convert fixed point to floating point
// The initial values are 0 for fixed point numbers but 1 for float, it shouldn't matter
fixed2float
#(
	.CELL_ID_WIDTH(CELL_ID_WIDTH),
	.DECIMAL_ADDR_WIDTH(DECIMAL_ADDR_WIDTH),
	.EXP_0(EXP_0)
)
fixed2float_x1
(
	.a(x1), 
	.q(x1_f)
);

fixed2float
#(
	.CELL_ID_WIDTH(CELL_ID_WIDTH),
	.DECIMAL_ADDR_WIDTH(DECIMAL_ADDR_WIDTH),
	.EXP_0(EXP_0)
)
fixed2float_y1
(
	.a(y1), 
	.q(y1_f)
);

fixed2float
#(
	.CELL_ID_WIDTH(CELL_ID_WIDTH),
	.DECIMAL_ADDR_WIDTH(DECIMAL_ADDR_WIDTH),
	.EXP_0(EXP_0)
)
fixed2float_z1
(
	.a(z1), 
	.q(z1_f)
);

fixed2float
#(
	.CELL_ID_WIDTH(CELL_ID_WIDTH),
	.DECIMAL_ADDR_WIDTH(DECIMAL_ADDR_WIDTH),
	.EXP_0(EXP_0)
)
fixed2float_x2
(
	.a(x2), 
	.q(x2_f)
);

fixed2float
#(
	.CELL_ID_WIDTH(CELL_ID_WIDTH),
	.DECIMAL_ADDR_WIDTH(DECIMAL_ADDR_WIDTH),
	.EXP_0(EXP_0)
)
fixed2float_y2
(
	.a(y2), 
	.q(y2_f)
);

fixed2float
#(
	.CELL_ID_WIDTH(CELL_ID_WIDTH),
	.DECIMAL_ADDR_WIDTH(DECIMAL_ADDR_WIDTH),
	.EXP_0(EXP_0)
)
fixed2float_z2
(
	.a(z2), 
	.q(z2_f)
);


r2_compute
#(
	.DATA_WIDTH(DATA_WIDTH)
)
r2_compute
(
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
	.dx_out(dx_out),
	.dy_out(dy_out),
	.dz_out(dz_out),
	.r2_valid(out_valid)
);


endmodule
