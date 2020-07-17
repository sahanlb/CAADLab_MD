//////////////////////////////////////////////////////////////
// Functionality:
// Capture the force values from RL_LJ_Evaluation_Unit
// Send out neighbor particle force directly to be written back 
// to force cache. (In current organization nb is from home cell)
// Store accumulated force on reference particles based on target cell id
// Send out the reference particles when the reference id changes
//////////////////////////////////////////////////////////////
module force_distributor
#(
	parameter DATA_WIDTH        = 32, 
	parameter CELL_ID_WIDTH     = 3, 
	parameter PARTICLE_ID_WIDTH = 7, 
	parameter NUM_FILTER        = 7, 
	parameter ID_WIDTH          = 3*CELL_ID_WIDTH+PARTICLE_ID_WIDTH,
  parameter WB_WIDTH          = ID_WIDTH + 3*DATA_WIDTH, // Full cell ID is sent out. A downstream module will 
                                                         // convert cell_id to network_id.
  parameter WAIT_CYCLES      = 5, // Number of cycles to wait before starting writing back captured values
                                   // To make sure that no force values intended for the home cell are dropped
	parameter CELL_222 = 9'b010010010, 
	parameter CELL_111 = 9'b001001001
)
(
	input clk, 
	input rst, 
  input start_wb,
	input [NUM_FILTER-1:0][DATA_WIDTH-1:0] ref_force_x, 
	input [NUM_FILTER-1:0][DATA_WIDTH-1:0] ref_force_y, 
	input [NUM_FILTER-1:0][DATA_WIDTH-1:0] ref_force_z, 
	input [NUM_FILTER-1:0][ID_WIDTH-1  :0] ref_id, 
	input [NUM_FILTER-1:0] ref_force_valid, 
	input [DATA_WIDTH-1:0] force_x, 
	input [DATA_WIDTH-1:0] force_y, 
	input [DATA_WIDTH-1:0] force_z, 
	input [ID_WIDTH-1:0] nb_id, 
	input force_valid, 
	// Bus is ready to receive packets
	input ready, 
	
	output reg [WB_WIDTH-1:0] wb_out, 
	output reg wb_valid,
  output reg all_ref_wb_issued 
);

// state encoding
enum {ACTIVE, WAIT, WB_REF} state;

int unsigned i;

reg [5:0] counter;

// registers to store accumulated forces
reg [3*DATA_WIDTH-1:0][13:0] force_reg;
reg [ID_WIDTH-1:0][13:0] force_id_reg;
reg [13:0] force_reg_valid;

//state machine
always_ff @(posedge clk)begin
  if(rst)begin
    wb_out            <= 0;
    wb_valid          <= 0; 
    all_ref_wb_issued <= 0;
    force_reg         <= 0;
    force_reg_valid   <= 0;
    counter           <= 0;
    state             <= ACTIVE;
  end
  else begin
    case(state)
      ACTIVE:begin
        all_ref_wb_issued <= 1'b0;
        wb_valid          <= force_valid;
        wb_out            <= {nb_id, force_z, force_y, force_x};
        //capture force on reference particles
        for(i=0; i<NUM_FILTER; i++)begin
          if(ref_force_valid[i])begin
            if(ref_id[0][ID_WIDTH-1 -: 3*CELL_ID_WIDTH] == CELL_222)begin //phase 0
              force_reg[i]       <= {ref_force_z[i], ref_force_y[i], ref_force_x[i]};
              force_id_reg[i]    <= ref_id[i];
              force_reg_valid[i] <= 1'b1;
            end
            else begin
              force_reg[i+NUM_FILTER]       <= {ref_force_z[i], ref_force_y[i], ref_force_x[i]};
              force_id_reg[i+NUM_FILTER]    <= ref_id[i];
              force_reg_valid[i+NUM_FILTER] <= 1'b1;
            end
          end 
        end
        //state change
        if(start_wb)begin
          counter <= 0;
          state   <= WAIT;
        end
        else begin
          state <= ACTIVE;
        end
      end
      WAIT:begin // Make sure no more writebacks intended for the home cell foce cache are left in the pipeline
        wb_valid <= force_valid;
        wb_out   <= {nb_id, force_z, force_y, force_x};
        if(force_valid | counter == WAIT_CYCLES)
          counter <= 0;
        else
          counter++;
        if(counter == WAIT_CYCLES)
          state   <= WB_REF;
        else
          state <= WAIT;
      end
      WB_REF:begin
        wb_valid <= force_reg_valid[counter];
        wb_out   <= {force_id_reg[counter], force_reg[counter]};
        if(ready & counter == 13)begin
          all_ref_wb_issued <= 1'b1;
          state             <= ACTIVE;
        end
        else if(ready)
          counter++;
      end
    endcase
  end
end

/* This piece of code is only here for debug purposes. Will be removed after verifying functionality*/
always @(negedge clk)begin
  if(force_valid & ~ready)begin
    $display("Neighbor particle force writeback issued when network is not ready!");
    $display("Instance: %m");
    $stop();
  end
end




endmodule
