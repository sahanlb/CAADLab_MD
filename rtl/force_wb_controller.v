module force_wb_controller
#(
	parameter DATA_WIDTH = 32, 
	parameter FORCE_CACHE_WIDTH = 3*DATA_WIDTH, 
	parameter FORCE_INPUT_BUFFER_DEPTH = 16, 
	parameter FORCE_INPUT_BUFFER_ADDR_WIDTH = 4, 
	parameter PARTICLE_ID_WIDTH = 7, 
	parameter FORCE_CACHE_DEPTH = 128, 
	parameter FORCE_DATA_WIDTH = FORCE_CACHE_WIDTH+PARTICLE_ID_WIDTH
)
(
	input clk, 
	input rst, 
	input wr_enable, 
	input rd_enable, 
	input [FORCE_CACHE_WIDTH-1:0] force_to_cache, 
	input [PARTICLE_ID_WIDTH-1:0] force_wr_addr, 
	input [PARTICLE_ID_WIDTH-1:0] force_rd_addr, 
	
	output input_buffer_empty, 
	output reg [FORCE_CACHE_WIDTH-1:0] force_to_MU, 
	output reg [PARTICLE_ID_WIDTH-1:0] force_id_to_MU, 
	output reg force_valid_to_MU
);

//// Delay registers
// Conpensate for the 2 cycle delay between read request is issued and data read out from Force_Cache: Cycle 1: Read address registered to cache_rd_address; Cycle 2: Data read out
reg rd_enable_reg1;
reg delay_rd_enable;
reg [PARTICLE_ID_WIDTH-1:0] force_rd_addr_reg1;
reg [PARTICLE_ID_WIDTH-1:0] delay_force_rd_addr;
// Delay the write enable signal by 4 cycles: 1 cycle for assigning read address, 1 cycle for fetching data from cache, 2 cycles for waiting addition finish
reg cache_write_enable_reg1;
reg cache_write_enable_reg2;
reg cache_write_enable_reg3;
reg delay_cache_write_enable;
// Delay the cache clear flag, so the clear signal goes together with the write enable signal while motion updating
reg force_cache_clr_reg1;
reg force_cache_clr_reg2;
reg force_cache_clr_reg3;
reg delay_force_cache_clr;
// Delay the cache write address by 4 cycles: 1 cycle for assigning read address, 1 cycle for fetching data from cache, 2 cycles for waiting addition finish
reg [PARTICLE_ID_WIDTH-1:0] cache_target_address_reg1;
reg [PARTICLE_ID_WIDTH-1:0] cache_target_address_reg2;
reg [PARTICLE_ID_WIDTH-1:0] cache_target_address_reg3;
reg [PARTICLE_ID_WIDTH-1:0] delay_cache_target_address;
// Delay the input particle information by one cycle to conpensating the one cycle delay to read from input FIFO
reg [PARTICLE_ID_WIDTH-1:0] delay_particle_address;
reg [FORCE_CACHE_WIDTH-1:0] delay_force_to_cache;
// Delay the control signal derived from the input information by one cycle
reg delay_wr_enable;
reg delay_input_buffer_empty;
// Delay the input to accumulator by one cycle to conpensate the one cycle delay to read previous data from force cache
reg [FORCE_CACHE_WIDTH-1:0] delay_partial_force_to_accumulator;


//// Registers recording the active particles that is currently being accumulated (6 stage -> Cycle 1: Determine the ID (either from input or input FIFO); Cycle 2: read out current force; Cycle 3-5: accumulation; Cycle 6: write back force)
// If the new incoming forces requires to accumulate to a particle that is being processed in the pipeline, then need to push this new incoming force into a FIFO, until the accumulated force is write back into the force cache
reg [PARTICLE_ID_WIDTH-1:0] active_particle_address;
reg [PARTICLE_ID_WIDTH-1:0] active_particle_address_reg1;
reg [PARTICLE_ID_WIDTH-1:0] active_particle_address_reg2;
reg [PARTICLE_ID_WIDTH-1:0] active_particle_address_reg3;
reg [PARTICLE_ID_WIDTH-1:0] active_particle_address_reg4;
reg [PARTICLE_ID_WIDTH-1:0] active_particle_address_reg5;


//// Signals connected to force input buffer
wire input_buffer_wr_en, input_buffer_rd_en;
wire input_buffer_full;
wire [PARTICLE_ID_WIDTH+FORCE_CACHE_WIDTH-1:0] input_buffer_readout_data;

//// Signals derived from input
// Extract the particle read address from the incoming partile id
wire [PARTICLE_ID_WIDTH-1:0] particle_address;
assign particle_address = force_wr_addr;
// Determine if the input requires particle that is being processed when making the selection between FIFO output or input to send down for processing
// Note: when making the occupied decision, use the delayed input information
wire particle_occupied;
assign particle_occupied = (delay_particle_address == active_particle_address) || (delay_particle_address == active_particle_address_reg1) || (delay_particle_address == active_particle_address_reg2) || (delay_particle_address == active_particle_address_reg3) || (delay_particle_address == active_particle_address_reg4) || (delay_particle_address == active_particle_address_reg5);
// Determine if the input buffer output requires particle that is being processed when making the selection between FIFO output or input to send down for processing
wire [PARTICLE_ID_WIDTH-1:0] input_buffer_out_particle_address;
assign input_buffer_out_particle_address = input_buffer_readout_data[PARTICLE_ID_WIDTH+FORCE_CACHE_WIDTH-1:FORCE_CACHE_WIDTH];
wire input_buffer_out_particle_occupied;
assign input_buffer_out_particle_occupied = (input_buffer_out_particle_address == active_particle_address) || (input_buffer_out_particle_address == active_particle_address_reg1) || (input_buffer_out_particle_address == active_particle_address_reg2) || (input_buffer_out_particle_address == active_particle_address_reg3) || (input_buffer_out_particle_address == active_particle_address_reg4) || (input_buffer_out_particle_address == active_particle_address_reg5);

//// Signals for controlling Force_Cache
// Because force cache reading and writing cannot happen at the same time, merge cache write and cache read address into a single signal
reg  [PARTICLE_ID_WIDTH-1:0] cache_target_address;										// Delay for 4 cycles and connect to Force_Cache
wire  [FORCE_CACHE_WIDTH-1:0] cache_write_data;										// Connect to accumulator output and direct send to Force_Cache
reg  cache_write_enable;																// Delay for 4 cycles and connect to Force_Cache
wire [FORCE_CACHE_WIDTH-1:0] cache_readout_data;										// Send the read out data from Force_Cache to Accumulator input

//// Signals connected to accumulator
// The input to force accumulator
reg [FORCE_CACHE_WIDTH-1:0] partial_force_to_accumulator;

// Clear force cache while the motion update module is reading from the force cache
reg force_cache_clr;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Input FIFO control logic
// Assign the read enable when: data in FIFO && current output is not valid
// If the input is not valid or matching the cell, assign the the read enable if there are data inside FIFO
//	If the input is valid, but the request data is in process, then write to FIFO
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// FIFO output valid
// Set this flag when FIFO one cycle after rd_en is set
// Clear this flag when FIFO output is taken by partial_force_to_accumulator
reg input_buffer_read_valid;
// Input FIFO rd & wr control
assign input_buffer_wr_en = (delay_wr_enable && particle_occupied) ? 1'b1 : 1'b0;
assign input_buffer_rd_en = (~input_buffer_read_valid && ~input_buffer_empty) ? 1'b1 : 1'b0;
	

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Force Cache Controller
// Since there is a 3 cycle latency for the adder, when there is a particle force being accumulated, while new forces for the same particle arrive, need to wait
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always@(posedge clk)
	begin
	if(rst)
		begin
		// Delay registers
		// For assigning the read out valid
		rd_enable_reg1 <= 1'b0;
		delay_rd_enable <= 1'b0;
		force_rd_addr_reg1 <= {(PARTICLE_ID_WIDTH){1'b0}};
		delay_force_rd_addr <= {(PARTICLE_ID_WIDTH){1'b0}};
		// For conpensating the 4 cycles delay from write enable is assigned and accumulated value is calculated
		cache_write_enable_reg1 <= 1'b0;
		cache_write_enable_reg2 <= 1'b0;
		cache_write_enable_reg3 <= 1'b0;
		delay_cache_write_enable <= 1'b0;
		// For conpensating the 4 cycles delay from force cache clear is assigned and accumulated value is calculated
		force_cache_clr_reg1 <= 1'b0;
		force_cache_clr_reg2 <= 1'b0;
		force_cache_clr_reg3 <= 1'b0;
		delay_force_cache_clr <= 1'b0;
		// For conpensating the 4 cycles delay from write address is generated and accumulated value is calculated
		cache_target_address_reg1 <= {(PARTICLE_ID_WIDTH){1'b0}};
		cache_target_address_reg2 <= {(PARTICLE_ID_WIDTH){1'b0}};
		cache_target_address_reg3 <= {(PARTICLE_ID_WIDTH){1'b0}};
		delay_cache_target_address <= {(PARTICLE_ID_WIDTH){1'b0}};
		// For conpensating the one cycle delay to read from input FIFO, delay the input particle information by one cycle
		delay_particle_address <= {(PARTICLE_ID_WIDTH){1'b0}};
		delay_force_to_cache <= {(FORCE_CACHE_WIDTH){1'b0}};
		// For conpensating the one cycle delay to read from input FIFO, delay the control signal derived from the input information by one cycle
		delay_wr_enable <= 1'b0;
		delay_input_buffer_empty <= 1'b1;
		// For conpensating the one cycle delay of reading the previous value from force cache
		delay_partial_force_to_accumulator <= {(FORCE_CACHE_WIDTH){1'b1}};
		// For registering the active particles in the pipeline
		active_particle_address <= {(PARTICLE_ID_WIDTH){1'b0}};
		active_particle_address_reg1 <= {(PARTICLE_ID_WIDTH){1'b0}};
		active_particle_address_reg2 <= {(PARTICLE_ID_WIDTH){1'b0}};
		active_particle_address_reg3 <= {(PARTICLE_ID_WIDTH){1'b0}};
		active_particle_address_reg4 <= {(PARTICLE_ID_WIDTH){1'b0}};
		active_particle_address_reg5 <= {(PARTICLE_ID_WIDTH){1'b0}};
		
		// Read output ports
		force_to_MU <= {(FORCE_CACHE_WIDTH){1'b0}};
		force_id_to_MU <= {(PARTICLE_ID_WIDTH){1'b0}};
		force_valid_to_MU <= 1'b0;
		// Cache control signals
		cache_target_address <= {(PARTICLE_ID_WIDTH){1'b0}};
		cache_write_enable <= 1'b0;
		// Input to force accumulator
		partial_force_to_accumulator <= {(FORCE_CACHE_WIDTH){1'b0}};
		// FIFO read valid flag
		input_buffer_read_valid <= 1'b0;
		
		// Force cache clear flag
		force_cache_clr <= 1'b0;
		end
	else
		begin
		//// Delay registers
		// For assigning the read out valid
		rd_enable_reg1 <= rd_enable;
		delay_rd_enable <= rd_enable_reg1;
		force_rd_addr_reg1 <= force_rd_addr;
		delay_force_rd_addr <= force_rd_addr_reg1;
		// For conpensating the 3 cycles delay from write enable is assigned and accumulated value is calculated
		cache_write_enable_reg1 <= cache_write_enable;
		cache_write_enable_reg2 <= cache_write_enable_reg1;
		cache_write_enable_reg3 <= cache_write_enable_reg2;
		delay_cache_write_enable <= cache_write_enable_reg3;
		// For conpensating the 3 cycles delay from cache clear is assigned and accumulated value is calculated
		force_cache_clr_reg1 <= force_cache_clr;
		force_cache_clr_reg2 <= force_cache_clr_reg1;
		force_cache_clr_reg3 <= force_cache_clr_reg2;
		delay_force_cache_clr <= force_cache_clr_reg3;
		// For conpensating the 3 cycles delay from write address is generated and accumulated value is calculated
		cache_target_address_reg1 <= cache_target_address;
		cache_target_address_reg2 <= cache_target_address_reg1;
		cache_target_address_reg3 <= cache_target_address_reg2;
		delay_cache_target_address <= cache_target_address_reg3;
		/// For conpensating the one cycle delay to read from input FIFO, delay the input particle information by one cycle
		delay_particle_address <= particle_address;
		delay_force_to_cache <= force_to_cache;
		// For conpensating the one cycle delay to read from input FIFO, delay the control signal derived from the input information by one cycle
		delay_wr_enable <= wr_enable; // Originally input_matching
		delay_input_buffer_empty <= input_buffer_empty;
		// For conpensating the one cycle delay of reading the previous value from force cache
		delay_partial_force_to_accumulator <= partial_force_to_accumulator;
		// For registering the active particles in the pipeline
		active_particle_address_reg1 <= active_particle_address;
		active_particle_address_reg2 <= active_particle_address_reg1;
		active_particle_address_reg3 <= active_particle_address_reg2;
		active_particle_address_reg4 <= active_particle_address_reg3;
		active_particle_address_reg5 <= active_particle_address_reg4;
		
		//// Priority grant to read request (usually read enable need to keep low during force evaluation process)
		// if outside read request set, then no write activity is permitted
		// There are 2 cycles delay between read request is assigned and force value is read out, thus keep the read_request state for 2 extra cycles after the in_read_data_request is cleared
		if(rd_enable || rd_enable_reg1 || delay_rd_enable)
			begin
			// Active particle id for data dependence detection
			active_particle_address <= 0;
			// Read output ports
			force_to_MU <= cache_readout_data;
			force_id_to_MU <= delay_force_rd_addr;
			force_valid_to_MU <= delay_rd_enable;
			
			// Cache control signals
			force_cache_clr <= 1'b1;								// Memory clear flag set
			cache_target_address <= force_rd_addr;					// Changed from the original version, set memory to 0 after read by motion update
			cache_write_enable <= 1'b1;							// Changed from the original version, set memory to 0 after read by motion update
			// Input to force accumulator
			partial_force_to_accumulator <= {(FORCE_CACHE_WIDTH){1'b0}};
			// FIFO read valid flag
			input_buffer_read_valid <= 1'b0;
			end
		//// Accumulation and write into force memory
		else
			begin
			// If data not requested by motion update, do not clear the memory
			force_cache_clr <= 1'b0;
			// During force accumulation period, output the data that is being written into the memory
			force_to_MU <= cache_write_data;
			force_id_to_MU <= delay_cache_target_address;
			force_valid_to_MU <= 1'b0;
			// If the input is valid and not being processed, then process the input
			if(delay_wr_enable && ~particle_occupied)
				begin
				// Active particle id for data dependence detection
				active_particle_address <= delay_particle_address;
				// Cache control signal
				cache_target_address <= delay_particle_address;
				cache_write_enable <= 1'b1;
				// Input to force accumulator 
				partial_force_to_accumulator <= delay_force_to_cache;
				// FIFO read valid flag
				// When FIFO rd_en is set, set this flag as high
				if(input_buffer_rd_en)
					input_buffer_read_valid <= 1'b1;
				else
					input_buffer_read_valid <= input_buffer_read_valid;
				end
			// If the input is not valid, or the input is valid but requested particle is being processed, then process particle from the input buffer
			else if(~input_buffer_out_particle_occupied && input_buffer_read_valid && (~delay_wr_enable || (delay_wr_enable && particle_occupied)))
//				else if(~input_buffer_out_particle_occupied && input_buffer_read_valid && ~delay_wr_enable)
				begin
				// Active particle id for data dependence detection
				active_particle_address <= input_buffer_readout_data[PARTICLE_ID_WIDTH+FORCE_CACHE_WIDTH-1:FORCE_CACHE_WIDTH];
				// Cache control signal
				cache_target_address <= input_buffer_readout_data[PARTICLE_ID_WIDTH+FORCE_CACHE_WIDTH-1:FORCE_CACHE_WIDTH];
				cache_write_enable <= 1'b1;
				// Input to force accumulator 
				partial_force_to_accumulator <= input_buffer_readout_data[FORCE_CACHE_WIDTH-1:0];
				// FIFO read valid flag
				// When FIFO output is taken, clear this flag
				input_buffer_read_valid <= 1'b0;
				end
			else
				begin
				// Active particle id for data dependence detection
				active_particle_address <= {(PARTICLE_ID_WIDTH){1'b0}};
				// Cache control signal
				cache_target_address <= {(PARTICLE_ID_WIDTH){1'b0}};
				cache_write_enable <= 1'b0;
				// Input to force accumulator
				partial_force_to_accumulator <= {(FORCE_CACHE_WIDTH){1'b0}};
				// FIFO read valid flag
				// When FIFO rd_en is set, set this flag as high
				if(input_buffer_rd_en)
					input_buffer_read_valid <= 1'b1;
				else
					input_buffer_read_valid <= input_buffer_read_valid;
				end
			end
		end
	end


FP_ADD Force_X_Acc(
	.clk(clk),
	.ena(1'b1),
	.clr(rst),
	.ax(cache_readout_data[1*DATA_WIDTH-1:0*DATA_WIDTH]),
	.ay(delay_partial_force_to_accumulator[1*DATA_WIDTH-1:0*DATA_WIDTH]),
	.result(cache_write_data[1*DATA_WIDTH-1:0*DATA_WIDTH])
);

// Force_Y Accumulator
FP_ADD Force_Y_Acc(
	.clk(clk),
	.ena(1'b1),
	.clr(rst),
	.ax(cache_readout_data[2*DATA_WIDTH-1:1*DATA_WIDTH]),
	.ay(delay_partial_force_to_accumulator[2*DATA_WIDTH-1:1*DATA_WIDTH]),
	.result(cache_write_data[2*DATA_WIDTH-1:1*DATA_WIDTH])
);

// Force_Z Accumulator
FP_ADD Force_Z_Acc(
	.clk(clk),
	.ena(1'b1),
	.clr(rst),
	.ax(cache_readout_data[3*DATA_WIDTH-1:2*DATA_WIDTH]),
	.ay(delay_partial_force_to_accumulator[3*DATA_WIDTH-1:2*DATA_WIDTH]),
	.result(cache_write_data[3*DATA_WIDTH-1:2*DATA_WIDTH])
);

// Dual port ram
wire [3*DATA_WIDTH-1:0] in_data_force_cache;
assign in_data_force_cache = delay_force_cache_clr ? {(3*DATA_WIDTH){1'b0}} : cache_write_data;
force_cache
#(
	.DATA_WIDTH(3*DATA_WIDTH),
	.PARTICLE_NUM(FORCE_CACHE_DEPTH),
	.ADDR_WIDTH(PARTICLE_ID_WIDTH)
)
force_cache
(
	.clock(clk),
	.data(in_data_force_cache),
	.rdaddress(cache_target_address),
	.wraddress(delay_cache_target_address),
	.wren(delay_cache_write_enable),
	.q(cache_readout_data)
);

force_cache_input_buffer
#(
	.FORCE_DATA_WIDTH(FORCE_DATA_WIDTH),								// hold particle ID and force value
	.BUFFER_DEPTH(FORCE_INPUT_BUFFER_DEPTH),
	.BUFFER_ADDR_WIDTH(FORCE_INPUT_BUFFER_ADDR_WIDTH)						// log(BUFFER_DEPTH) / log 2
)
force_cache_input_buffer
(
	 .clock(clk),
	 .data({delay_particle_address, delay_force_to_cache}),
	 .rdreq(input_buffer_rd_en),
	 .wrreq(input_buffer_wr_en),
	 .empty(input_buffer_empty),
	 .full(input_buffer_full),
	 .q(input_buffer_readout_data),
	 .usedw()
);

endmodule