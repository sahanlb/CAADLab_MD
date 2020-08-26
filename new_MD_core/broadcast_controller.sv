import md_pkg::*;

module broadcast_controller(
	input clk, 
	input rst, 
	input iter_start, 
	input particle_id_t [NUM_CELLS-1:0] particle_num,
	input [NUM_CELLS-1:0] back_pressure, 
	input [NUM_CELLS-1:0] filter_buffer_empty, 
	// Returned from PEs, if ref id > particle num
	input [NUM_CELLS-1:0] reading_done, 
	input all_force_wr_issued, // Includes the time to flush out all packets from the interconnect.
  input all_ref_wb_issued,
	
	// Partial flag for motion update start
	output all_reading_done, 
	output all_filter_buffer_empty, 
	output particle_id_t particle_id, 
	output particle_id_t ref_id, 
	output reg phase, 
	// Tell the data receiving end that the data is the number of particles
	output reg reading_particle_num, 
	// Invalidate all pairs to force evaluation unit
	output reg pause_reading,
  output goto_next_ref // indicating that controller is not waiting for the interconnect to be empty and moving to the next ref ID.
);

// FSM state encoding
enum{
  WAIT_FOR_START,
  READ_PARTICLE_NUM,
  READING,
  WAIT_PHASE_CHANGE,
  WAIT_NEXT_REF
}state;


// Flags returned from lower modules
assign all_reading_done = &reading_done;

assign all_filter_buffer_empty = &filter_buffer_empty;

wire [NUM_CELLS-1:0] broadcast_done;
wire all_broadcast_done;
assign all_broadcast_done = &broadcast_done;

wire back_pressure_exist;
assign back_pressure_exist = |back_pressure;

reg increase_ref;
reg prev_phase;
reg [3:0] wait_cycle_counter;

always@(posedge clk)
	begin
	prev_phase <= phase;
	end


always@(posedge clk)
	begin
	if (rst)
		begin
		state                <= WAIT_FOR_START;
		ref_id               <= 7'b0000001;
		phase                <= 1'b0;
		particle_id          <= 0;
		pause_reading        <= 1'b1;
		reading_particle_num <= 1'b0;
		wait_cycle_counter   <= 0;
    increase_ref         <= 1'b0;
		end
	else
		begin
		case(state)
			// Do nothing and wait for start signal
			WAIT_FOR_START:
				begin
				ref_id <= 7'b0000001;
				phase <= 1'b0;
				particle_id <= 0;
				// If start or start count down, continue
				if (iter_start || wait_cycle_counter != 0)
					begin
					// 10 cycles (arbitrary) for new particle number writing
					if (wait_cycle_counter == 10)
						begin
						state <= READ_PARTICLE_NUM;
						pause_reading <= 1'b0;
						// This flag is set high only for here
						reading_particle_num <= 1'b1;
						wait_cycle_counter <= 0;
						end
					else
						begin
						state <= WAIT_FOR_START;
						pause_reading <= 1'b1;
						reading_particle_num <= 1'b0;
						wait_cycle_counter <= wait_cycle_counter + 1'b1;
						end
					end
				else
					begin
					state <= WAIT_FOR_START;
					pause_reading <= 1'b1;
					reading_particle_num <= 1'b0;
					wait_cycle_counter <= wait_cycle_counter;
					end
				end
			// Once every iteration, the receiving end knows to how to store the data
			READ_PARTICLE_NUM:
				begin
				state <= READING;
				ref_id <= 7'b0000001;
				particle_id <= particle_id + 1'b1;
				phase <= phase;
				pause_reading <= 1'b0;
				reading_particle_num <= 1'b0;
				end
			// Normal reading, including phase 0 to phase 1 transition
			READING: 
				begin
				reading_particle_num <= 1'b0;
					// Enter next phase, reset particle id
					if (all_broadcast_done)
						begin
						particle_id <= 7'b0000001;
						// Still the same ref particle
						if (phase == 1'b0)
							begin
							state <= WAIT_PHASE_CHANGE;
							ref_id <= ref_id;
							pause_reading <= 1'b1;
							end
						else
							begin
							state         <= WAIT_NEXT_REF;
							pause_reading <= 1'b1;
              increase_ref  <= 1'b1;
							end
						end
					else
						begin
						ref_id <= ref_id;
						// Stall when there's back pressure
						if (back_pressure_exist)
							begin
							state <= READING;
							phase <= phase;
							particle_id <= particle_id;
							pause_reading <= 1'b1;
							end
						// Normal procedure
						else
							begin
							state <= READING;
							phase <= phase;
							particle_id <= particle_id + 1'b1; 
							pause_reading <= 1'b0;
							end
						end
				end
      WAIT_PHASE_CHANGE:begin
        if(all_filter_buffer_empty)begin
          pause_reading <= 1'b0;
          phase         <= 1'b1;
          state         <= READING;
        end
        else
          state <= WAIT_PHASE_CHANGE;
      end
			// Phase 1 to phase 0 transition
			WAIT_NEXT_REF:
				begin
				reading_particle_num <= 1'b0;
				// We don't know how long this state lasts, so all readings done may happen in this state
				if (all_reading_done)
					begin
					if (all_force_wr_issued)
						begin
						state <= WAIT_FOR_START;
						ref_id <= 7'b0000001;
						phase <= 1'b0;
						particle_id <= 0;
						pause_reading <= 1'b1;
            increase_ref  <= 1'b0;
						end
					// Wait for all force wr to be issued for mu start
					else
						begin
						state <= state;
						ref_id <= ref_id;
						phase <= phase;
						particle_id <= particle_id;
						pause_reading <= 1'b1;
						end
					end
				else begin
					particle_id <= particle_id;
					// This means normal reading can continue
					if(all_ref_wb_issued)begin
						state         <= READING;
            phase         <= 1'b0;
						pause_reading <= 1'b0;
					end
          else if(all_filter_buffer_empty & increase_ref)begin
            ref_id        <= ref_id + 1'b1;
            pause_reading <= 1'b1;
            increase_ref  <= 1'b0;
            state         <= state;
          end
					else begin
						state <= state;
						pause_reading <= 1'b1;
					end
				end
			end
		endcase
		end
	end

assign goto_next_ref = ((state == WAIT_PHASE_CHANGE) & all_filter_buffer_empty) |
                       ((state == WAIT_NEXT_REF) & ~all_reading_done & 
                       all_filter_buffer_empty & all_ref_wb_issued);


genvar i;
generate
	for (i = 0; i < NUM_CELLS; i = i + 1)
		begin: broadcast_done_check
		check_broadcast_done
		check_broadcast_done(
			.particle_count(particle_num[i]), 
			.particle_id(particle_id), 
			
			.broadcast_done(broadcast_done[i])
		);
		end
endgenerate

endmodule
