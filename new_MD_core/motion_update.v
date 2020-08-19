////////////////////////////////////////////////////////////////////////////////////////
// Read from force caches, pos caches, and velocity caches
// Write to pos caches and velocity caches
////////////////////////////////////////////////////////////////////////////////////////
module motion_update
#(
	parameter NUM_CELLS = 64, 
	parameter GLOBAL_CELL_ID_WIDTH = 6, 
	parameter CELL_ID_WIDTH = 3, 
	parameter OFFSET_WIDTH = 29, 
	parameter DATA_WIDTH = 32,											// Data width of a single force value, 32-bit
	parameter FORCE_CACHE_WIDTH = 3*DATA_WIDTH, 
	parameter VELOCITY_CACHE_WIDTH = 3*DATA_WIDTH, 
	parameter POS_CACHE_WIDTH = 3*OFFSET_WIDTH, 
	parameter TIME_STEP = 32'h27101D7D,							// 2fs time step
	parameter REDUCED_TIME_STEP = 32'h2587a348, 				// 2fs/8.5, to normalize
	parameter PARTICLE_ID_WIDTH = 7, 
	parameter EXP_0 = 8'b01111111, 
	parameter X_DIM = 4, 
	parameter Y_DIM = 4, 
	parameter Z_DIM = 4
)
(
	input clk,
	input rst,
	input motion_update_start,																// Only need to keep high for 1 cycle
	input [POS_CACHE_WIDTH-1:0] in_position_data,
	input [FORCE_CACHE_WIDTH-1:0] in_force_data,
	input [VELOCITY_CACHE_WIDTH-1:0] in_velocity_data,
	
	output [POS_CACHE_WIDTH-1:0] out_position_data,
	output [VELOCITY_CACHE_WIDTH-1:0] out_velocity_data,
	output [PARTICLE_ID_WIDTH-1:0] out_rd_addr, 
	output out_rd_enable, 
	output out_data_valid, 
	output reg out_motion_update_enable, 
	// Only keeps high for 1 cycle
	output reg out_motion_update_done, 
	output reg [GLOBAL_CELL_ID_WIDTH-1:0] cell_counter, 
	
	// Particle migration
	output [1:0] cell_x_offset,
	output [1:0] cell_y_offset,
	output [1:0] cell_z_offset, 
	output reg [CELL_ID_WIDTH-1:0] cell_x, 
	output reg [CELL_ID_WIDTH-1:0] cell_y, 
	output reg [CELL_ID_WIDTH-1:0] cell_z
);
	
	wire [VELOCITY_CACHE_WIDTH-1:0] evaluated_velocity;				// {vz, vy, vx}
	wire [DATA_WIDTH-1:0] evaluated_dx_float;
	wire [DATA_WIDTH-1:0] evaluated_dy_float;
	wire [DATA_WIDTH-1:0] evaluated_dz_float;
	wire [POS_CACHE_WIDTH-1:0] evaluated_position_fixed;
	
	/////////////////////////////////////////////////////////////////////////////////////////////////
	// Delay registers
	/////////////////////////////////////////////////////////////////////////////////////////////////
	// Delay the incoming velocity data by 1 cycle to wait for force data arrive
	reg [VELOCITY_CACHE_WIDTH-1:0] delay_in_velocity_data;
	// Delay the incoming valid signal to generate the output valid signal (14 cycles for the entire datapath)
	// Full datapath has 14 cycles, but the initial incoming_valid signal is assigned in FSM, already including 1 cycle delay, should delay for 13 cycles
	// However there is an extra delay for conpensate for the force cache's 3 cycle read delay instead of 2 from other caches
	// Thus a total of 14 cycles delay
	reg incoming_data_valid_reg1;
	reg incoming_data_valid_reg2;
	reg incoming_data_valid_reg3;
	reg incoming_data_valid_reg4;
	reg incoming_data_valid_reg5;
	reg incoming_data_valid_reg6;
	reg incoming_data_valid_reg7;
	reg incoming_data_valid_reg8;
	reg incoming_data_valid_reg9;
	reg delay_incoming_data_valid;
	// Delay registers conpensating the 6 cycle delay between position data arrival and evaluating velocity finish
	// 5 cycles for velocity evaluation
	// 1 cycle for conpensating the 1 more cycle read delay from force cache
	reg [POS_CACHE_WIDTH-1:0] in_position_data_reg1;
	reg [POS_CACHE_WIDTH-1:0] in_position_data_reg2;
	reg [POS_CACHE_WIDTH-1:0] in_position_data_reg3;
	reg [POS_CACHE_WIDTH-1:0] in_position_data_reg4;
	reg [POS_CACHE_WIDTH-1:0] in_position_data_reg5;
	reg [POS_CACHE_WIDTH-1:0] in_position_data_reg6;
	reg [POS_CACHE_WIDTH-1:0] in_position_data_reg7;
	reg [POS_CACHE_WIDTH-1:0] in_position_data_reg8;
	reg [POS_CACHE_WIDTH-1:0] in_position_data_reg9;
	reg [POS_CACHE_WIDTH-1:0] delay_in_position_data;
	// Delay registers to propogate the evaluated velocity data to meet the target cell information (9 cycles from speed evaluation to output)
	reg [VELOCITY_CACHE_WIDTH-1:0] evaluated_velocity_reg1;
	reg [VELOCITY_CACHE_WIDTH-1:0] evaluated_velocity_reg2;
	reg [VELOCITY_CACHE_WIDTH-1:0] evaluated_velocity_reg3;
	reg [VELOCITY_CACHE_WIDTH-1:0] delay_evaluated_velocity;
	
	/////////////////////////////////////////////////////////////////////////////////////////////////
	// Postion and velocity information read FSM
	// After the read address is assigned, there are 2 cycles delay when the value is read out
	// Plus, there's one cycle delay when assign the read address
	/////////////////////////////////////////////////////////////////////////////////////////////////
	parameter WAIT_FOR_START = 3'd0;
	parameter READ_PARTICLE_NUM = 3'd1;
	parameter READ_PARTICLE_INFO = 3'd2;
	parameter WAIT_FOR_FINISH = 3'd3;
	parameter MOTION_UPDATE_DONE = 3'd4;
	reg [2:0] state;
	reg [5:0] delay_counter;
	reg [PARTICLE_ID_WIDTH-1:0] particle_num;
	reg [PARTICLE_ID_WIDTH-1:0] rd_addr;
	reg rd_enable;
	reg incoming_data_valid;											// Assign the valid signal after 2 cycles when a valid address is assigned
	always@(posedge clk)
		begin
		if(rst)
			begin
			delay_counter <= 0;
			particle_num <= 0;
			cell_counter <= 0;
			rd_addr <= 0;
			rd_enable <= 1'b0;
			incoming_data_valid <= 1'b0;
			out_motion_update_enable <= 1'b0;
			out_motion_update_done <= 1'b0;
			cell_x <= 1;
			cell_y <= 1;
			cell_z <= 1;
			state <= WAIT_FOR_START;
			end
		else
			begin
			case(state)
				// While wait for the start signal, read in the particle num first
				WAIT_FOR_START:
					begin
					delay_counter <= 0;
					particle_num <= 0;
					cell_counter <= cell_counter;
					rd_addr <= 0;
					incoming_data_valid <= 1'b0;								// Incoming data is not valid during wait process
					out_motion_update_enable <= 1'b0;
					out_motion_update_done <= 1'b0;
					if(motion_update_start)
						begin
						state <= READ_PARTICLE_NUM;
						rd_enable <= 1'b1;			// Pre enable the read
						end
					else
						begin
						state <= WAIT_FOR_START;
						rd_enable <= 1'b0;
						end
					end
				
				// There are a total of 3 cycles delay to read from the data in the particle cache
				// 2 cycles from the memory module
				// 1 cycle to assign the address value
				READ_PARTICLE_NUM:
					begin
					delay_counter <= delay_counter + 1'b1;
					particle_num <= in_position_data[PARTICLE_ID_WIDTH-1:0];
					cell_counter <= cell_counter;
					rd_addr <= rd_addr + 1'b1;									// Start to increment the read address
					rd_enable <= 1'b1;
					incoming_data_valid <= 1'b0;								// Wait for cell particle number readout, incoming data not valid
					out_motion_update_enable <= 1'b1;
					out_motion_update_done <= 1'b0;
					// Wait for 2 more cycles here to let the particle num read out
					// When jump to the next state, the particle count will be ready
					if(delay_counter < 2)
						begin
						state <= READ_PARTICLE_NUM;
						end
					else
						begin
						state <= READ_PARTICLE_INFO;
						end
					end
				
				// Consequtively read out particle data one by one
				READ_PARTICLE_INFO:
					begin
					delay_counter <= 0;											// Reset the delay counter
					particle_num <= particle_num;								// Keep the particle_num
					cell_counter <= cell_counter;
					//rd_addr <= rd_addr + 1'b1;									// Keep incrementing the read address
					rd_enable <= 1'b1;											// Keep the read enable as high
					incoming_data_valid <= 1'b1;								// The data read out are valid from now on
					out_motion_update_enable <= 1'b1;						// Motion update remain high during the entire process
					out_motion_update_done <= 1'b0;
					// Wait for one more cycle here to let the particle num read out
					if(rd_addr < particle_num)
						begin
						rd_addr <= rd_addr + 1'b1;								// Keep incrementing the read address
						state <= READ_PARTICLE_INFO;
						end
					else
						begin
						rd_addr <= 0;												// After read is done, reset the read address
						state <= WAIT_FOR_FINISH;
						end
					end
				
				// Wait till the last particle is processed
				WAIT_FOR_FINISH:
					begin
					delay_counter <= delay_counter + 1'b1;					// Increment the delay counter
					particle_num <= particle_num;								// Keep the particle_num
					rd_addr <= 0;													// Reset the read address
					out_motion_update_enable <= 1'b1;						// Motion update remain high during the entire process
					out_motion_update_done <= 1'b0;
					// Keep the incoming_data_valid high for two more cycles to take in the last data
					if(delay_counter < 2)
						incoming_data_valid <= 1'b1;
					else
						incoming_data_valid <= 1'b0;
					rd_enable <= 1'b1;
					
					// Wait for all the processing finish, the value 40 is an arbitrary number here, may subject to change
					if(delay_counter < 40)
						begin
						state <= WAIT_FOR_FINISH;
						cell_counter <= cell_counter;
						end
					else
						begin
						delay_counter <= 0;
						if (cell_counter == NUM_CELLS-1)
							begin
							cell_counter <= 0;
							state <= MOTION_UPDATE_DONE;
							end
						else
							begin
							cell_counter <= cell_counter+1'b1;
							state <= READ_PARTICLE_NUM;
							end
						if (cell_z < Z_DIM)
							begin
							cell_z <= cell_z+1'b1;
							end
						else
							begin
							cell_z <= 1;
							if (cell_y < Y_DIM)
								begin
								cell_y <= cell_y+1'b1;
								end
							else
								begin
								cell_y <= 1;
								if (cell_x < X_DIM)
									begin
									cell_x <= cell_x+1'b1;
									end
								else
									begin
									cell_x <= 1;
									end
								end
							end
						end
					end
				
				// Set the done signal, initialize the control signals
				MOTION_UPDATE_DONE:
					begin
					delay_counter <= 0;											// Reset delay counter
					particle_num <= particle_num;								// Keep the particle_num
					cell_counter <= cell_counter;
					rd_addr <= 0;													// Reset the read address
					incoming_data_valid <= 1'b0;								// Incoming data is not valid during this state
					out_motion_update_enable <= 1'b0;						// Clear motion update enable signal
					out_motion_update_done <= 1'b1;
					rd_enable <= 1'b0;											// Disable particle read
					state <= WAIT_FOR_START;									// Jump back to the initial state
					end
			endcase
			end
		end
	
	/////////////////////////////////////////////////////////////////////////////////////////////////
	// Assign delay registers
	/////////////////////////////////////////////////////////////////////////////////////////////////
	always@(posedge clk)
		begin
		if(rst)
			begin
			// Delay the incoming velocity data by 1 cycle to wait for force data arrive
			delay_in_velocity_data <= 0;
			// Delay the incoming valid signal to generate the output valid signal
			incoming_data_valid_reg1 <= 1'b0;
			incoming_data_valid_reg2 <= 1'b0;
			incoming_data_valid_reg3 <= 1'b0;
			incoming_data_valid_reg4 <= 1'b0;
			incoming_data_valid_reg5 <= 1'b0;
			incoming_data_valid_reg6 <= 1'b0;
			incoming_data_valid_reg7 <= 1'b0;
			incoming_data_valid_reg8 <= 1'b0;
			incoming_data_valid_reg9 <= 1'b0;
			delay_incoming_data_valid <= 1'b0;
			// Delay position data
			in_position_data_reg1 <= 0;
			in_position_data_reg2 <= 0;
			in_position_data_reg3 <= 0;
			in_position_data_reg4 <= 0;
			in_position_data_reg5 <= 0;
			in_position_data_reg6 <= 0;
			in_position_data_reg7 <= 0;
			in_position_data_reg8 <= 0;
			in_position_data_reg9 <= 0;
			delay_in_position_data <= 0;
			// Delay registers to propogate the evaluated velocity data to meet the target cell information
			evaluated_velocity_reg1 <= 0;
			evaluated_velocity_reg2 <= 0;
			evaluated_velocity_reg3 <= 0;
			delay_evaluated_velocity <= 0;
			end
		else
			begin
			// Delay the incoming velocity data by 1 cycle to wait for force data arrive
			delay_in_velocity_data <= in_velocity_data;
			// Delay the incoming valid signal to generate the output valid signal
			incoming_data_valid_reg1 <= incoming_data_valid;
			incoming_data_valid_reg2 <= incoming_data_valid_reg1;
			incoming_data_valid_reg3 <= incoming_data_valid_reg2;
			incoming_data_valid_reg4 <= incoming_data_valid_reg3;
			incoming_data_valid_reg5 <= incoming_data_valid_reg4;
			incoming_data_valid_reg6 <= incoming_data_valid_reg5;
			incoming_data_valid_reg7 <= incoming_data_valid_reg6;
			incoming_data_valid_reg8 <= incoming_data_valid_reg7;
			delay_incoming_data_valid <= incoming_data_valid_reg8;
			// Delay position data
			in_position_data_reg1 <= in_position_data;
			in_position_data_reg2 <= in_position_data_reg1;
			in_position_data_reg3 <= in_position_data_reg2;
			in_position_data_reg4 <= in_position_data_reg3;
			in_position_data_reg5 <= in_position_data_reg4;
			in_position_data_reg6 <= in_position_data_reg5;
			in_position_data_reg7 <= in_position_data_reg6;
			in_position_data_reg8 <= in_position_data_reg7;
			in_position_data_reg9 <= in_position_data_reg8;
			delay_in_position_data <= in_position_data_reg9;
			// Delay registers to propogate the evaluated velocity data to meet the target cell information
			evaluated_velocity_reg1 <= evaluated_velocity;
			evaluated_velocity_reg2 <= evaluated_velocity_reg1;
			evaluated_velocity_reg3 <= evaluated_velocity_reg2;
			delay_evaluated_velocity <= evaluated_velocity_reg3;
			end
		end
	
	/////////////////////////////////////////////////////////////////////////////////////////////////
	// Update Output ports
	/////////////////////////////////////////////////////////////////////////////////////////////////
	assign out_rd_addr = rd_addr;
	assign out_rd_enable = rd_enable;
	assign out_data_valid = delay_incoming_data_valid;
	// Assign output to Velocity Cache
	assign out_velocity_data = delay_evaluated_velocity;
	// Assign output to Position Cache
	assign out_position_data = evaluated_position_fixed;
	
	float2fixed
	#(
		.OFFSET_WIDTH(OFFSET_WIDTH),
		.DATA_WIDTH(DATA_WIDTH),
		.EXP_0(EXP_0)
	)
	float2fixed_x
	(
		.a(evaluated_dx_float[DATA_WIDTH-1:0]),
		.b(delay_in_position_data[OFFSET_WIDTH-1:0]), 
		
		.cell_offset(cell_x_offset), 
		.q(evaluated_position_fixed[OFFSET_WIDTH-1:0])
	);
	
	float2fixed
	#(
		.OFFSET_WIDTH(OFFSET_WIDTH),
		.DATA_WIDTH(DATA_WIDTH),
		.EXP_0(EXP_0)
	)
	float2fixed_y
	(
		.a(evaluated_dy_float[DATA_WIDTH-1:0]),
		.b(delay_in_position_data[2*OFFSET_WIDTH-1:OFFSET_WIDTH]), 
		
		.cell_offset(cell_y_offset), 
		.q(evaluated_position_fixed[2*OFFSET_WIDTH-1:OFFSET_WIDTH])
	);
	
	float2fixed
	#(
		.OFFSET_WIDTH(OFFSET_WIDTH),
		.DATA_WIDTH(DATA_WIDTH),
		.EXP_0(EXP_0)
	)
	float2fixed_z
	(
		.a(evaluated_dz_float[DATA_WIDTH-1:0]),
		.b(delay_in_position_data[3*OFFSET_WIDTH-1:2*OFFSET_WIDTH]), 
		
		.cell_offset(cell_z_offset), 
		.q(evaluated_position_fixed[3*OFFSET_WIDTH-1:2*OFFSET_WIDTH])
	);
	
	/////////////////////////////////////////////////////////////////////////////////////////////////
	// Velocity Evaluation
	// result = ay * az + ax
	// 5 cycle delay
	/////////////////////////////////////////////////////////////////////////////////////////////////
	// Evaluate vx
	FP_MUL_ADD Eval_vx (
		.ax     (delay_in_velocity_data[1*DATA_WIDTH-1:0*DATA_WIDTH]),
		.ay     (in_force_data[1*DATA_WIDTH-1:0*DATA_WIDTH]),
		.az     (TIME_STEP), 
		.clk    (clk),
		.clr    (rst), 
		.ena    (1'b1),
		.result (evaluated_velocity[1*DATA_WIDTH-1:0*DATA_WIDTH]) 
	);
	
	// Evaluate vy
	FP_MUL_ADD Eval_vy (
		.ax     (delay_in_velocity_data[2*DATA_WIDTH-1:1*DATA_WIDTH]),
		.ay     (in_force_data[2*DATA_WIDTH-1:1*DATA_WIDTH]),
		.az     (TIME_STEP), 
		.clk    (clk),
		.clr    (rst), 
		.ena    (1'b1),
		.result (evaluated_velocity[2*DATA_WIDTH-1:1*DATA_WIDTH]) 
	);
	
	// Evaluate vz
	FP_MUL_ADD Eval_vz (
		.ax     (delay_in_velocity_data[3*DATA_WIDTH-1:2*DATA_WIDTH]),
		.ay     (in_force_data[3*DATA_WIDTH-1:2*DATA_WIDTH]),
		.az     (TIME_STEP), 
		.clk    (clk),
		.clr    (rst), 
		.ena    (1'b1),
		.result (evaluated_velocity[3*DATA_WIDTH-1:2*DATA_WIDTH]) 
	);
	
	// 4 cycles delay, compute displacement
	FP_MUL Eval_dx (
		.ay(evaluated_velocity[1*DATA_WIDTH-1:0*DATA_WIDTH]), 
		.az(REDUCED_TIME_STEP), 
		.clk(clk), 
		.clr(rst), 
		.ena(1'b1), 
		.result(evaluated_dx_float) 
	);
	FP_MUL Eval_dy (
		.ay(evaluated_velocity[2*DATA_WIDTH-1:1*DATA_WIDTH]), 
		.az(REDUCED_TIME_STEP), 
		.clk(clk), 
		.clr(rst), 
		.ena(1'b1), 
		.result(evaluated_dy_float) 
	);
	FP_MUL Eval_dz (
		.ay(evaluated_velocity[3*DATA_WIDTH-1:2*DATA_WIDTH]), 
		.az(REDUCED_TIME_STEP), 
		.clk(clk), 
		.clr(rst), 
		.ena(1'b1), 
		.result(evaluated_dz_float) 
	);
endmodule
