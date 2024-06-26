//////////////////////////////////////////////////////////////
// Functionality:
// Capture the force values from RL_LJ_Evaluation_Unit
// Send out neighbor particle force directly to be written back 
// to force cache. (In current organization nb is from home cell)
// Store accumulated force on reference particles based on target cell id
// Send out the reference particles when the reference id changes
//////////////////////////////////////////////////////////////
import md_pkg::full_cell_id_t;
import md_pkg::full_id_t;

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
	//input [NUM_FILTER-1:0][ID_WIDTH-1  :0] ref_id, 
  input full_id_t [NUM_FILTER-1:0] ref_id,
	input [NUM_FILTER-1:0] ref_force_valid, 
	input [DATA_WIDTH-1:0] force_x, 
	input [DATA_WIDTH-1:0] force_y, 
	input [DATA_WIDTH-1:0] force_z, 
	input [ID_WIDTH-1:0] nb_id, 
	input force_valid, 
	// Bus is ready to receive packets
	input ready, 
	
	output [WB_WIDTH-1:0] wb_out, 
	output wb_valid,
  output reg all_ref_wb_issued 
);

localparam CELL_1 = 3'b001;
localparam CELL_2 = 3'b010;
localparam CELL_3 = 3'b011;

// state encoding
enum {ACTIVE, WAIT, WB_REF} state;

int unsigned i;

reg [5:0] counter;

// registers to store accumulated forces
reg [13:0][3*DATA_WIDTH-1:0] force_reg;
reg [13:0][ID_WIDTH-1:0] force_id_reg;
reg [13:0] force_reg_valid;

// Assign outputs
assign wb_out = rst ? 0 : (state == WB_REF) ? {force_id_reg[counter], force_reg[counter]} :
                {nb_id, force_z, force_y, force_x};

assign wb_valid = rst ? 0 : (state == WB_REF) ? force_reg_valid[counter] : force_valid;

// Cell ID values to be compared with input particle IDs.
full_cell_id_t [6:0] cell_id1, cell_id2;

always_comb begin
  {cell_id1[0], cell_id2[0]} = {CELL_2, CELL_2, CELL_2, CELL_3, CELL_1, CELL_3};
  {cell_id1[1], cell_id2[1]} = {CELL_2, CELL_2, CELL_3, CELL_3, CELL_2, CELL_1};
  {cell_id1[2], cell_id2[2]} = {CELL_2, CELL_3, CELL_1, CELL_3, CELL_2, CELL_2};
  {cell_id1[3], cell_id2[3]} = {CELL_2, CELL_3, CELL_2, CELL_3, CELL_2, CELL_3};
  {cell_id1[4], cell_id2[4]} = {CELL_2, CELL_3, CELL_3, CELL_3, CELL_3, CELL_1};
  {cell_id1[5], cell_id2[5]} = {CELL_3, CELL_1, CELL_1, CELL_3, CELL_3, CELL_2};
  {cell_id1[6], cell_id2[6]} = {CELL_3, CELL_1, CELL_2, CELL_3, CELL_3, CELL_3};
end



//state machine
always_ff @(posedge clk)begin
  if(rst)begin
    all_ref_wb_issued <= 0;
    force_reg         <= 0;
    force_id_reg      <= 0;
    force_reg_valid   <= 0;
    counter           <= 0;
    state             <= ACTIVE;
  end
  else begin
    case(state)
      ACTIVE:begin
        all_ref_wb_issued <= 1'b0;
        //capture force on reference particles
        for(i=0; i<NUM_FILTER; i++)begin
          if(ref_force_valid[i])begin
            if(ref_id[i].cell_id == cell_id1[i])begin //phase 0
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
        if(force_valid)begin
          counter <= 0;
          state   <= WAIT;
        end
        else if(counter == WAIT_CYCLES)begin
          counter <= 0;
          state   <= WB_REF;
        end
        else begin
          counter++;
          state <= WAIT;
        end
      end
      WB_REF:begin
        if(ready & counter == 13)begin
          all_ref_wb_issued <= 1'b1;
          force_reg_valid   <= 0;
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
