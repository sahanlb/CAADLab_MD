module pos_cache_1_1_1
#(
	parameter OFFSET_WIDTH = 29, 
	parameter PARTICLE_ID_WIDTH = 7, 
	parameter POS_CACHE_DEPTH = 128
)
(
	input clk, 
	input rst, 
	input motion_update_enable, 
	input [PARTICLE_ID_WIDTH-1:0] in_read_address, 
	input [3*OFFSET_WIDTH-1:0] in_data, 
	input in_data_valid, 
	input in_rden, 
	
	output [3*OFFSET_WIDTH-1:0] out_particle_data
);

	//////////////////////////////////////////////////////////////////////////////////////////////
	// Control FSM to switch between the 2 memory modules
	//////////////////////////////////////////////////////////////////////////////////////////////
	parameter WAIT_FOR_MOTION_UPDATE_START = 2'b00;
	parameter MOTION_UPDATE_PROCESS = 2'b01;
	parameter WRITE_PARTICLE_NUM = 2'b10;
	parameter MOTION_UPDATE_DONE = 2'b11;
	reg [1:0] state;
	// Flag selecting which cell is the active one for processing
	reg active_cell;
	// Counter for recording the # of new particles
	reg [PARTICLE_ID_WIDTH-1:0] new_particle_counter;
	// Memory module control signal
	reg cell_wr_en;
	reg [PARTICLE_ID_WIDTH-1:0] cell_wr_address;
	reg [3*OFFSET_WIDTH-1:0] cell_wr_data;
	
	always@(posedge clk)
		begin
		if(rst)
			begin
			active_cell <= 1'b0;
			new_particle_counter <= 1;								// Counter starts from 1, to avoid write to Address 0
			cell_wr_en <= 1'b0;
			cell_wr_address <= {(PARTICLE_ID_WIDTH){1'b0}};
			cell_wr_data <= {(3*OFFSET_WIDTH){1'b0}};
			
			state <= WAIT_FOR_MOTION_UPDATE_START;
			end
		else
			begin
			case(state)
				// Wait for the start signal
				WAIT_FOR_MOTION_UPDATE_START:
					begin
					if(motion_update_enable)
						begin
						active_cell <= active_cell;
						// Check if the first data is valid
						if(in_data_valid)
							begin
							new_particle_counter <= new_particle_counter + 1'b1;
							cell_wr_en <= 1'b1;
							cell_wr_address <= new_particle_counter;
							cell_wr_data <= in_data;
							end
						else
							begin
							new_particle_counter <= new_particle_counter;
							cell_wr_en <= 1'b0;
							cell_wr_address <= 0;
							cell_wr_data <= 0;
							end
						state <= MOTION_UPDATE_PROCESS;
						end
					else
						begin
						active_cell <= active_cell;
						new_particle_counter <= 1;
						cell_wr_en <= 1'b0;
						cell_wr_address <= {(PARTICLE_ID_WIDTH){1'b0}};
						cell_wr_data <= {(3*OFFSET_WIDTH){1'b0}};
						state <= WAIT_FOR_MOTION_UPDATE_START;
						end
					end
				// Record the new particle data
				MOTION_UPDATE_PROCESS:
					begin
					active_cell <= active_cell;
					// Check if the first data is valid
					if(in_data_valid)
						begin
						new_particle_counter <= new_particle_counter + 1'b1;
						cell_wr_en <= 1'b1;
						cell_wr_address <= new_particle_counter;
						cell_wr_data <= in_data;
						end
					else
						begin
						new_particle_counter <= new_particle_counter;
						cell_wr_en <= 1'b0;
						cell_wr_address <= 0;
						cell_wr_data <= 0;
						end
					// Update the next state
					// The motion_update_enable is suppose to keep high during the process
					if(motion_update_enable)
						begin
						state <= MOTION_UPDATE_PROCESS;
						end
					else
						begin
						state <= WRITE_PARTICLE_NUM;
						end
					end
				// Write the paticle # to address 0
				WRITE_PARTICLE_NUM:
					begin
					active_cell <= active_cell;
					// Write the new particle # to address 0
					new_particle_counter <= new_particle_counter;
					cell_wr_en <= 1'b1;
					cell_wr_address <= 0;
					cell_wr_data <= new_particle_counter - 1'b1;					// new_particle_counter = actual_current_# + 1'b1
					// Move to the DONE state
					state <= MOTION_UPDATE_DONE;
					end
				// Flip the active_cell bit
				MOTION_UPDATE_DONE:
					begin
					// Inverse the sel bit
					active_cell <= ~active_cell;
					// Reset the counter to 1
					new_particle_counter <= 1;
					cell_wr_en <= 1'b0;
					cell_wr_address <= 0;
					cell_wr_data <= 0;
					// Move to the initial state
					state <= WAIT_FOR_MOTION_UPDATE_START;
					end
			endcase
			end
		end

	//////////////////////////////////////////////////////////////////////////////////////////////
	// Signals connect to 2 cell memories
	//////////////////////////////////////////////////////////////////////////////////////////////
	// Assign the read address
	wire [PARTICLE_ID_WIDTH-1:0] input_to_cell_addr_0, input_to_cell_addr_1;
	assign input_to_cell_addr_0 = (active_cell) ? cell_wr_address : in_read_address;
	assign input_to_cell_addr_1 = (active_cell) ? in_read_address : cell_wr_address;
	// Assign the write data
	wire [3*OFFSET_WIDTH-1:0] input_to_cell_new_position_data_0, input_to_cell_new_position_data_1;
	assign input_to_cell_new_position_data_0 = (active_cell) ? cell_wr_data : 0;
	assign input_to_cell_new_position_data_1 = (active_cell) ? 0 : cell_wr_data;
	// Assign the read enable
	wire input_to_cell_rden_0, input_to_cell_rden_1;
	assign input_to_cell_rden_0 = (active_cell) ? 1'b0 : in_rden;
	assign input_to_cell_rden_1 = (active_cell) ? in_rden : 1'b0;
	// Assign the write enable
	wire input_to_cell_wren_0, input_to_cell_wren_1;
	assign input_to_cell_wren_0 = (active_cell) ? cell_wr_en : 1'b0;
	assign input_to_cell_wren_1 = (active_cell) ? 1'b0 : cell_wr_en;
	// Assign the read out data to output
	wire [3*OFFSET_WIDTH-1:0] cell_to_output_position_readout_0, cell_to_output_position_readout_1;
	assign out_particle_info = (active_cell) ? cell_to_output_position_readout_1 : cell_to_output_position_readout_0;

	//////////////////////////////////////////////////////////////////////////////////////////////
	// Memory Modules
	//////////////////////////////////////////////////////////////////////////////////////////////
	// Original Cell with initial value
	cell_1_1_1
	#(
		.DATA_WIDTH(3*OFFSET_WIDTH),
		.PARTICLE_NUM(POS_CACHE_DEPTH),
		.ADDR_WIDTH(PARTICLE_ID_WIDTH)
	)
	cell_0
	(
		.address(input_to_cell_addr_0),
		.clock(clk),
		.data(input_to_cell_new_position_data_0),
		.rden(input_to_cell_rden_0),
		.wren(input_to_cell_wren_0),
		.q(cell_to_output_position_readout_0)
	);

	// Alternative cell
	cell_empty
	#(
		.DATA_WIDTH(3*OFFSET_WIDTH),
		.PARTICLE_NUM(POS_CACHE_DEPTH),
		.ADDR_WIDTH(PARTICLE_ID_WIDTH)
	)
	cell_1
	(
		.address(input_to_cell_addr_1),
		.clock(clk),
		.data(input_to_cell_new_position_data_1),
		.rden(input_to_cell_rden_1),
		.wren(input_to_cell_wren_1),
		.q(cell_to_output_position_readout_1)
	);

endmodule