`timescale 1ns/1ns

//`define PRINT_PARTIAL_FORCES 1
`define FULL_DATA_DUMP 1

module RL_top_tb;

parameter NUM_CELLS = 64; 
parameter NUM_PARTICLE_PER_CELL = 100; 
parameter OFFSET_WIDTH = 29; 
parameter DATA_WIDTH = 32;
parameter CELL_ID_WIDTH = 3;
parameter DECIMAL_ADDR_WIDTH = 2; 
parameter PARTICLE_ID_WIDTH = 7; 
parameter X_DIM = 4; 
parameter Y_DIM = 4; 
parameter Z_DIM = 4; 
parameter BODY_BITS = 8; 
parameter ID_WIDTH = 3*CELL_ID_WIDTH+PARTICLE_ID_WIDTH;
parameter FULL_CELL_ID_WIDTH = 3*CELL_ID_WIDTH; 
parameter FILTER_BUFFER_DATA_WIDTH = PARTICLE_ID_WIDTH+3*DATA_WIDTH; 
parameter FORCE_BUFFER_WIDTH = 3*DATA_WIDTH+PARTICLE_ID_WIDTH+1; 
parameter FORCE_DATA_WIDTH = FORCE_BUFFER_WIDTH-1; 
parameter FORCE_CACHE_WIDTH = 3*DATA_WIDTH; 
parameter POS_CACHE_WIDTH = 3*OFFSET_WIDTH; 
parameter VELOCITY_CACHE_WIDTH = 3*DATA_WIDTH; 
parameter NUM_FILTER = 7; 
parameter ARBITER_MSB = 64; 				// 2^(NUM_FILTER-1)
parameter NUM_NEIGHBOR_CELLS = 13; 
parameter ALL_POSITION_WIDTH = (NUM_NEIGHBOR_CELLS+1)*POS_CACHE_WIDTH;

reg clk; 
reg rst; 
reg start;

// Output from PE
wire [NUM_CELLS-1:0] reading_done; 
wire [NUM_CELLS-1:0] back_pressure; 
wire [NUM_CELLS-1:0] filter_buffer_empty; 
wire [NUM_CELLS-1:0] force_valid;
wire force_valid_and;

always #1 clk <= ~clk;

initial begin
	clk <= 1;
	rst <= 1;
	start <= 0;
	
	#10
	rst <= 0;
	
	#8
	start <= 1;
	
	#100
	start <= 0;
end


// Stop simulation after motion update is completed in the first iteration
initial begin
  wait(RL_top.MU_done);
  #10000;
  $stop();
end


`ifdef PRINT_PARTIAL_FORCES
// Print partial force values
localparam C1 = 3'b001;
localparam C2 = 3'b010;
localparam C3 = 3'b011;

integer file0, file1, file2, file3, file4, file5, file6, file7, file8, file9, file10, file11, file12, file13;

initial begin
  file0  = $fopen("filter0.dat", "w");
  file1  = $fopen("filter1.dat", "w");
  file2  = $fopen("filter2.dat", "w");
  file3  = $fopen("filter3.dat", "w");
  file4  = $fopen("filter4.dat", "w");
  file5  = $fopen("filter5.dat", "w");
  file6  = $fopen("filter6.dat", "w");
  file7  = $fopen("filter7.dat", "w");
  file8  = $fopen("filter8.dat", "w");
  file9  = $fopen("filter9.dat", "w");
  file10 = $fopen("filter10.dat", "w");
  file11 = $fopen("filter11.dat", "w");
  file12 = $fopen("filter12.dat", "w");
  file13 = $fopen("filter13.dat", "w");

  if(!file0 | !file1 | !file2 | !file3  | !file4  | !file5  | !file6  |
     !file7 | !file8 | !file9 | !file10 | !file11 | !file12 | !file13 )begin
    $display("Error opening output files.");
    $stop();
  end

end

`define RL0 RL_top.PE_collection[0].single_PE.RL_LJ_Evaluation_Unit.RL_Force_Evaluation_Unit
`define PA0 RL_top.PE_collection[0].single_PE.RL_LJ_Evaluation_Unit.partial_acc_inst[0].Partial_Force_Acc
`define PA1 RL_top.PE_collection[0].single_PE.RL_LJ_Evaluation_Unit.partial_acc_inst[1].Partial_Force_Acc
`define PA2 RL_top.PE_collection[0].single_PE.RL_LJ_Evaluation_Unit.partial_acc_inst[2].Partial_Force_Acc
`define PA3 RL_top.PE_collection[0].single_PE.RL_LJ_Evaluation_Unit.partial_acc_inst[3].Partial_Force_Acc
`define PA4 RL_top.PE_collection[0].single_PE.RL_LJ_Evaluation_Unit.partial_acc_inst[4].Partial_Force_Acc
`define PA5 RL_top.PE_collection[0].single_PE.RL_LJ_Evaluation_Unit.partial_acc_inst[5].Partial_Force_Acc
`define PA6 RL_top.PE_collection[0].single_PE.RL_LJ_Evaluation_Unit.partial_acc_inst[6].Partial_Force_Acc

//filter 0
always @(negedge clk)begin
  if(`PA0.in_input_valid & `PA0.particle_id_match & (`PA0.cell_id_match | `PA0.phase_change))begin
    if(`PA0.in_id.cell_id == {C2,C2,C2})begin //(222)
      $fdisplay(file0, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA0.in_id.cell_id == {C3,C1,C3})begin //(313)
      $fdisplay(file7, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 0 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
end

//filter 1
always @(negedge clk)begin
  if(`PA1.in_input_valid & `PA1.particle_id_match & (`PA1.cell_id_match | `PA1.phase_change))begin
    if(`PA1.in_id.cell_id == {C2,C2,C3})begin //(223)
      $fdisplay(file1, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA1.in_id.cell_id == {C3,C2,C1})begin //(321)
      $fdisplay(file8, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 1 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
end

//filter 2
always @(negedge clk)begin
  if(`PA2.in_input_valid & `PA2.particle_id_match & (`PA2.cell_id_match | `PA2.phase_change))begin
    if(`PA2.in_id.cell_id == {C2,C3,C1})begin //(231)
      $fdisplay(file2, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA2.in_id.cell_id == {C3,C2,C2})begin
      $fdisplay(file9, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 2 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
end

//filter 3
always @(negedge clk)begin
  if(`PA3.in_input_valid & `PA3.particle_id_match & (`PA3.cell_id_match | `PA3.phase_change))begin
    if(`PA3.in_id.cell_id == {C2,C3,C2})begin //(232)
      $fdisplay(file3, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA3.in_id.cell_id == {C3,C2,C3})begin
      $fdisplay(file10, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 3 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
end

//filter 4
always @(negedge clk)begin
  if(`PA4.in_input_valid & `PA4.particle_id_match & (`PA4.cell_id_match | `PA4.phase_change))begin
    if(`PA4.in_id.cell_id == {C2,C3,C3})begin //(233)
      $fdisplay(file4, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA4.in_id.cell_id == {C3,C3,C1})begin
      $fdisplay(file11, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 4 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
end

//filter 5
always @(negedge clk)begin
  if(`PA5.in_input_valid & `PA5.particle_id_match & (`PA5.cell_id_match | `PA5.phase_change))begin
    if(`PA5.in_id.cell_id == {C3,C1,C1})begin //(311)
      $fdisplay(file5, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA5.in_id.cell_id == {C3,C3,C2})begin
      $fdisplay(file12, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 5 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
end

//filter 6
always @(negedge clk)begin
  if(`PA6.in_input_valid & `PA6.particle_id_match & (`PA6.cell_id_match | `PA6.phase_change))begin
    if(`PA6.in_id.cell_id == {C3,C1,C2})begin //(312)
      $fdisplay(file6, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA6.in_id.cell_id == {C3,C3,C3})begin
      $fdisplay(file13, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 6 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
end


// Stop simulation after one ref_id is completed
initial begin
  wait(`PA0.start_wb);
  $display("Start WB issued by partial acumulator 0 at t=%0t", $time);
  #10;
  $stop();
end
`endif


// Full data dump for one iteration

`ifdef FULL_DATA_DUMP
// text macros for module hierarchies
// Common
`define MUC RL_top.motion_update_control
`define MU `MUC.motion_update
`define MUX `MU.float2fixed_x
`define MUY `MU.float2fixed_y
`define MUZ `MU.float2fixed_z

// Cell 0 (cell with 3 periodic boundaries)
`define PE0 RL_top.PE_collection[0].single_PE
`define FC0 RL_top.all_force_caches.force_caches[0].force_wb_controller
`define FD0 `PE0.force_distributor
`define RL0 `PE0.RL_LJ_Evaluation_Unit.RL_Force_Evaluation_Unit
`define PA00 `PE0.RL_LJ_Evaluation_Unit.partial_acc_inst[0].Partial_Force_Acc
`define PA01 `PE0.RL_LJ_Evaluation_Unit.partial_acc_inst[1].Partial_Force_Acc
`define PA02 `PE0.RL_LJ_Evaluation_Unit.partial_acc_inst[2].Partial_Force_Acc
`define PA03 `PE0.RL_LJ_Evaluation_Unit.partial_acc_inst[3].Partial_Force_Acc
`define PA04 `PE0.RL_LJ_Evaluation_Unit.partial_acc_inst[4].Partial_Force_Acc
`define PA05 `PE0.RL_LJ_Evaluation_Unit.partial_acc_inst[5].Partial_Force_Acc
`define PA06 `PE0.RL_LJ_Evaluation_Unit.partial_acc_inst[6].Partial_Force_Acc

// Cell 61 (cell with 2 periodic boundaries)
`define PE61 RL_top.PE_collection[61].single_PE
`define FC61 RL_top.all_force_caches.force_caches[61].force_wb_controller
`define FD61 `PE61.force_distributor
`define RL61 `PE61.RL_LJ_Evaluation_Unit.RL_Force_Evaluation_Unit
`define PA610 `PE61.RL_LJ_Evaluation_Unit.partial_acc_inst[0].Partial_Force_Acc
`define PA611 `PE61.RL_LJ_Evaluation_Unit.partial_acc_inst[1].Partial_Force_Acc
`define PA612 `PE61.RL_LJ_Evaluation_Unit.partial_acc_inst[2].Partial_Force_Acc
`define PA613 `PE61.RL_LJ_Evaluation_Unit.partial_acc_inst[3].Partial_Force_Acc
`define PA614 `PE61.RL_LJ_Evaluation_Unit.partial_acc_inst[4].Partial_Force_Acc
`define PA615 `PE61.RL_LJ_Evaluation_Unit.partial_acc_inst[5].Partial_Force_Acc
`define PA616 `PE61.RL_LJ_Evaluation_Unit.partial_acc_inst[6].Partial_Force_Acc

// Cell 27 (cell with 1 periodic boundaries)
`define PE27 RL_top.PE_collection[27].single_PE
`define FC27 RL_top.all_force_caches.force_caches[27].force_wb_controller
`define FD27 `PE27.force_distributor
`define RL27 `PE27.RL_LJ_Evaluation_Unit.RL_Force_Evaluation_Unit
`define PA270 `PE27.RL_LJ_Evaluation_Unit.partial_acc_inst[0].Partial_Force_Acc
`define PA271 `PE27.RL_LJ_Evaluation_Unit.partial_acc_inst[1].Partial_Force_Acc
`define PA272 `PE27.RL_LJ_Evaluation_Unit.partial_acc_inst[2].Partial_Force_Acc
`define PA273 `PE27.RL_LJ_Evaluation_Unit.partial_acc_inst[3].Partial_Force_Acc
`define PA274 `PE27.RL_LJ_Evaluation_Unit.partial_acc_inst[4].Partial_Force_Acc
`define PA275 `PE27.RL_LJ_Evaluation_Unit.partial_acc_inst[5].Partial_Force_Acc
`define PA276 `PE27.RL_LJ_Evaluation_Unit.partial_acc_inst[6].Partial_Force_Acc

// Cell 42 (cell with 0 periodic boundaries)
`define PE42 RL_top.PE_collection[42].single_PE
`define FC42 RL_top.all_force_caches.force_caches[42].force_wb_controller
`define FD42 `PE42.force_distributor
`define RL42 `PE42.RL_LJ_Evaluation_Unit.RL_Force_Evaluation_Unit
`define PA420 `PE42.RL_LJ_Evaluation_Unit.partial_acc_inst[0].Partial_Force_Acc
`define PA421 `PE42.RL_LJ_Evaluation_Unit.partial_acc_inst[1].Partial_Force_Acc
`define PA422 `PE42.RL_LJ_Evaluation_Unit.partial_acc_inst[2].Partial_Force_Acc
`define PA423 `PE42.RL_LJ_Evaluation_Unit.partial_acc_inst[3].Partial_Force_Acc
`define PA424 `PE42.RL_LJ_Evaluation_Unit.partial_acc_inst[4].Partial_Force_Acc
`define PA425 `PE42.RL_LJ_Evaluation_Unit.partial_acc_inst[5].Partial_Force_Acc
`define PA426 `PE42.RL_LJ_Evaluation_Unit.partial_acc_inst[6].Partial_Force_Acc

// Dump reduced set of values for the rest of the cells
`define FD1  RL_top.PE_collection[1].single_PE.force_distributor
`define FD2  RL_top.PE_collection[2].single_PE.force_distributor
`define FD3  RL_top.PE_collection[3].single_PE.force_distributor
`define FD4  RL_top.PE_collection[4].single_PE.force_distributor
`define FD5  RL_top.PE_collection[5].single_PE.force_distributor
`define FD6  RL_top.PE_collection[6].single_PE.force_distributor
`define FD7  RL_top.PE_collection[7].single_PE.force_distributor
`define FD8  RL_top.PE_collection[8].single_PE.force_distributor
`define FD9  RL_top.PE_collection[9].single_PE.force_distributor
`define FD10 RL_top.PE_collection[10].single_PE.force_distributor
`define FD11 RL_top.PE_collection[11].single_PE.force_distributor
`define FD12 RL_top.PE_collection[12].single_PE.force_distributor
`define FD13 RL_top.PE_collection[13].single_PE.force_distributor
`define FD14 RL_top.PE_collection[14].single_PE.force_distributor
`define FD15 RL_top.PE_collection[15].single_PE.force_distributor
`define FD16 RL_top.PE_collection[16].single_PE.force_distributor
`define FD17 RL_top.PE_collection[17].single_PE.force_distributor
`define FD18 RL_top.PE_collection[18].single_PE.force_distributor
`define FD19 RL_top.PE_collection[19].single_PE.force_distributor
`define FD20 RL_top.PE_collection[20].single_PE.force_distributor
`define FD21 RL_top.PE_collection[21].single_PE.force_distributor
`define FD22 RL_top.PE_collection[22].single_PE.force_distributor
`define FD23 RL_top.PE_collection[23].single_PE.force_distributor
`define FD24 RL_top.PE_collection[24].single_PE.force_distributor
`define FD25 RL_top.PE_collection[25].single_PE.force_distributor
`define FD26 RL_top.PE_collection[26].single_PE.force_distributor
`define FD28 RL_top.PE_collection[28].single_PE.force_distributor
`define FD29 RL_top.PE_collection[29].single_PE.force_distributor
`define FD30 RL_top.PE_collection[30].single_PE.force_distributor
`define FD31 RL_top.PE_collection[31].single_PE.force_distributor
`define FD32 RL_top.PE_collection[32].single_PE.force_distributor
`define FD33 RL_top.PE_collection[33].single_PE.force_distributor
`define FD34 RL_top.PE_collection[34].single_PE.force_distributor
`define FD35 RL_top.PE_collection[35].single_PE.force_distributor
`define FD36 RL_top.PE_collection[36].single_PE.force_distributor
`define FD37 RL_top.PE_collection[37].single_PE.force_distributor
`define FD38 RL_top.PE_collection[38].single_PE.force_distributor
`define FD39 RL_top.PE_collection[39].single_PE.force_distributor
`define FD40 RL_top.PE_collection[40].single_PE.force_distributor
`define FD41 RL_top.PE_collection[41].single_PE.force_distributor
`define FD43 RL_top.PE_collection[43].single_PE.force_distributor
`define FD44 RL_top.PE_collection[44].single_PE.force_distributor
`define FD45 RL_top.PE_collection[45].single_PE.force_distributor
`define FD46 RL_top.PE_collection[46].single_PE.force_distributor
`define FD47 RL_top.PE_collection[47].single_PE.force_distributor
`define FD48 RL_top.PE_collection[48].single_PE.force_distributor
`define FD49 RL_top.PE_collection[49].single_PE.force_distributor
`define FD50 RL_top.PE_collection[50].single_PE.force_distributor
`define FD51 RL_top.PE_collection[51].single_PE.force_distributor
`define FD52 RL_top.PE_collection[52].single_PE.force_distributor
`define FD53 RL_top.PE_collection[53].single_PE.force_distributor
`define FD54 RL_top.PE_collection[54].single_PE.force_distributor
`define FD55 RL_top.PE_collection[55].single_PE.force_distributor
`define FD56 RL_top.PE_collection[56].single_PE.force_distributor
`define FD57 RL_top.PE_collection[57].single_PE.force_distributor
`define FD58 RL_top.PE_collection[58].single_PE.force_distributor
`define FD59 RL_top.PE_collection[59].single_PE.force_distributor
`define FD60 RL_top.PE_collection[60].single_PE.force_distributor
`define FD62 RL_top.PE_collection[62].single_PE.force_distributor
`define FD63 RL_top.PE_collection[63].single_PE.force_distributor


// Output files
// cell 0
integer file00, file01, file02, file03, file04, file05, file06, file07, file08, file09, file010, file011, file012, file013;
integer file_fdb0, file_fci0, file_fco0;
integer file_mu_pos0, file_mu_vel0;

// cell 61
integer file610, file611, file612, file613, file614, file615, file616, file617, file618, file619, file6110, file6111, file6112, file6113;
integer file_fdb61, file_fci61, file_fco61;
integer file_mu_pos61, file_mu_vel61;

// cell 27
integer file270, file271, file272, file273, file274, file275, file276, file277, file278, file279, file2710, file2711, file2712, file2713;
integer file_fdb27, file_fci27, file_fco27;
integer file_mu_pos27, file_mu_vel27;

// cell 42
integer file420, file421, file422, file423, file424, file425, file426, file427, file428, file429, file4210, file4211, file4212, file4213;
integer file_fdb42, file_fci42, file_fco42;
integer file_mu_pos42, file_mu_vel42;

// other cells
integer file_fdb1, file_fdb2, file_fdb3, file_fdb4, file_fdb5, file_fdb6, file_fdb7, file_fdb8, file_fdb9, file_fdb10,
        file_fdb11, file_fdb12, file_fdb13, file_fdb14, file_fdb15, file_fdb16, file_fdb17, file_fdb18, file_fdb19, file_fdb20,
        file_fdb21, file_fdb22, file_fdb23, file_fdb24, file_fdb25, file_fdb26, file_fdb28, file_fdb29, file_fdb30,
        file_fdb31, file_fdb32, file_fdb33, file_fdb34, file_fdb35, file_fdb36, file_fdb37, file_fdb38, file_fdb39, file_fdb40,
        file_fdb41, file_fdb43, file_fdb44, file_fdb45, file_fdb46, file_fdb47, file_fdb48, file_fdb49, file_fdb50,
        file_fdb51, file_fdb52, file_fdb53, file_fdb54, file_fdb55, file_fdb56, file_fdb57, file_fdb58, file_fdb59, file_fdb60,
        file_fdb62, file_fdb63;


// cell 0
initial begin
  file00  = $fopen("filter_0_0.dat", "w");
  file01  = $fopen("filter_0_1.dat", "w");
  file02  = $fopen("filter_0_2.dat", "w");
  file03  = $fopen("filter_0_3.dat", "w");
  file04  = $fopen("filter_0_4.dat", "w");
  file05  = $fopen("filter_0_5.dat", "w");
  file06  = $fopen("filter_0_6.dat", "w");
  file07  = $fopen("filter_0_7.dat", "w");
  file08  = $fopen("filter_0_8.dat", "w");
  file09  = $fopen("filter_0_9.dat", "w");
  file010 = $fopen("filter_0_10.dat", "w");
  file011 = $fopen("filter_0_11.dat", "w");
  file012 = $fopen("filter_0_12.dat", "w");
  file013 = $fopen("filter_0_13.dat", "w");

  file_fdb0 = $fopen("force_distributor_0_output.dat", "w");
  file_fci0 = $fopen("force_cache_0_input.dat", "w");
  file_fco0 = $fopen("force_cache_0_output.dat", "w");

  file_mu_pos0 = $fopen("mu_position_cell0.dat", "w");
  file_mu_vel0 = $fopen("mu_velocity_cell0.dat", "w");

  if(!file00 | !file01 | !file02 | !file03  | !file04  | !file05  | !file06  |
     !file07 | !file08 | !file09 | !file010 | !file011 | !file012 | !file013 |
     !file_fdb0 | !file_fci0 | !file_fco0
    )begin
    $display("Error opening output files.");
    $stop();
  end
end

// cell 61
initial begin
  file610  = $fopen("filter_61_0.dat", "w");
  file611  = $fopen("filter_61_1.dat", "w");
  file612  = $fopen("filter_61_2.dat", "w");
  file613  = $fopen("filter_61_3.dat", "w");
  file614  = $fopen("filter_61_4.dat", "w");
  file615  = $fopen("filter_61_5.dat", "w");
  file616  = $fopen("filter_61_6.dat", "w");
  file617  = $fopen("filter_61_7.dat", "w");
  file618  = $fopen("filter_61_8.dat", "w");
  file619  = $fopen("filter_61_9.dat", "w");
  file6110 = $fopen("filter_61_10.dat", "w");
  file6111 = $fopen("filter_61_11.dat", "w");
  file6112 = $fopen("filter_61_12.dat", "w");
  file6113 = $fopen("filter_61_13.dat", "w");

  file_fdb61 = $fopen("force_distributor_61_output.dat", "w");
  file_fci61 = $fopen("force_cache_61_input.dat", "w");
  file_fco61 = $fopen("force_cache_61_output.dat", "w");

  file_mu_pos61 = $fopen("mu_position_cell61.dat", "w");
  file_mu_vel61 = $fopen("mu_velocity_cell61.dat", "w");

  if(!file610 | !file611 | !file612 | !file613  | !file614  | !file615  | !file616  |
     !file617 | !file618 | !file619 | !file6110 | !file6111 | !file6112 | !file6113 |
     !file_fdb61 | !file_fci61 | !file_fco61
    )begin
    $display("Error opening output files.");
    $stop();
  end
end

// cell 27
initial begin
  file270  = $fopen("filter_27_0.dat", "w");
  file271  = $fopen("filter_27_1.dat", "w");
  file272  = $fopen("filter_27_2.dat", "w");
  file273  = $fopen("filter_27_3.dat", "w");
  file274  = $fopen("filter_27_4.dat", "w");
  file275  = $fopen("filter_27_5.dat", "w");
  file276  = $fopen("filter_27_6.dat", "w");
  file277  = $fopen("filter_27_7.dat", "w");
  file278  = $fopen("filter_27_8.dat", "w");
  file279  = $fopen("filter_27_9.dat", "w");
  file2710 = $fopen("filter_27_10.dat", "w");
  file2711 = $fopen("filter_27_11.dat", "w");
  file2712 = $fopen("filter_27_12.dat", "w");
  file2713 = $fopen("filter_27_13.dat", "w");

  file_fdb27 = $fopen("force_distributor_27_output.dat", "w");
  file_fci27 = $fopen("force_cache_27_input.dat", "w");
  file_fco27 = $fopen("force_cache_27_output.dat", "w");

  file_mu_pos27 = $fopen("mu_position_cell27.dat", "w");
  file_mu_vel27 = $fopen("mu_velocity_cell27.dat", "w");

  if(!file270 | !file271 | !file272 | !file273  | !file274  | !file275  | !file276  |
     !file277 | !file278 | !file279 | !file2710 | !file2711 | !file2712 | !file2713 |
     !file_fdb27 | !file_fci27 | !file_fco27
    )begin
    $display("Error opening output files.");
    $stop();
  end
end

// cell 42
initial begin
  file420  = $fopen("filter_42_0.dat", "w");
  file421  = $fopen("filter_42_1.dat", "w");
  file422  = $fopen("filter_42_2.dat", "w");
  file423  = $fopen("filter_42_3.dat", "w");
  file424  = $fopen("filter_42_4.dat", "w");
  file425  = $fopen("filter_42_5.dat", "w");
  file426  = $fopen("filter_42_6.dat", "w");
  file427  = $fopen("filter_42_7.dat", "w");
  file428  = $fopen("filter_42_8.dat", "w");
  file429  = $fopen("filter_42_9.dat", "w");
  file4210 = $fopen("filter_42_10.dat", "w");
  file4211 = $fopen("filter_42_11.dat", "w");
  file4212 = $fopen("filter_42_12.dat", "w");
  file4213 = $fopen("filter_42_13.dat", "w");

  file_fdb42 = $fopen("force_distributor_42_output.dat", "w");
  file_fci42 = $fopen("force_cache_42_input.dat", "w");
  file_fco42 = $fopen("force_cache_42_output.dat", "w");

  file_mu_pos42 = $fopen("mu_position_cell42.dat", "w");
  file_mu_vel42 = $fopen("mu_velocity_cell42.dat", "w");

  if(!file420 | !file421 | !file422 | !file423  | !file424  | !file425  | !file426  |
     !file427 | !file428 | !file429 | !file4210 | !file4211 | !file4212 | !file4213 |
     !file_fdb42 | !file_fci42 | !file_fco42
    )begin
    $display("Error opening output files.");
    $stop();
  end
end

// Other cells
initial begin
  file_fdb1  = $fopen("force_distributor_1_output.dat", "w");
  file_fdb2  = $fopen("force_distributor_2_output.dat", "w");
  file_fdb3  = $fopen("force_distributor_3_output.dat", "w");
  file_fdb4  = $fopen("force_distributor_4_output.dat", "w");
  file_fdb5  = $fopen("force_distributor_5_output.dat", "w");
  file_fdb6  = $fopen("force_distributor_6_output.dat", "w");
  file_fdb7  = $fopen("force_distributor_7_output.dat", "w");
  file_fdb8  = $fopen("force_distributor_8_output.dat", "w");
  file_fdb9  = $fopen("force_distributor_9_output.dat", "w");
  file_fdb10 = $fopen("force_distributor_10_output.dat", "w");
  file_fdb11 = $fopen("force_distributor_11_output.dat", "w");
  file_fdb12 = $fopen("force_distributor_12_output.dat", "w");
  file_fdb13 = $fopen("force_distributor_13_output.dat", "w");
  file_fdb14 = $fopen("force_distributor_14_output.dat", "w");
  file_fdb15 = $fopen("force_distributor_15_output.dat", "w");
  file_fdb16 = $fopen("force_distributor_16_output.dat", "w");
  file_fdb17 = $fopen("force_distributor_17_output.dat", "w");
  file_fdb18 = $fopen("force_distributor_18_output.dat", "w");
  file_fdb19 = $fopen("force_distributor_19_output.dat", "w");
  file_fdb20 = $fopen("force_distributor_20_output.dat", "w");
  file_fdb21 = $fopen("force_distributor_21_output.dat", "w");
  file_fdb22 = $fopen("force_distributor_22_output.dat", "w");
  file_fdb23 = $fopen("force_distributor_23_output.dat", "w");
  file_fdb24 = $fopen("force_distributor_24_output.dat", "w");
  file_fdb25 = $fopen("force_distributor_25_output.dat", "w");
  file_fdb26 = $fopen("force_distributor_26_output.dat", "w");
  file_fdb28 = $fopen("force_distributor_28_output.dat", "w");
  file_fdb29 = $fopen("force_distributor_29_output.dat", "w");
  file_fdb30 = $fopen("force_distributor_30_output.dat", "w");
  file_fdb31 = $fopen("force_distributor_31_output.dat", "w");
  file_fdb32 = $fopen("force_distributor_32_output.dat", "w");
  file_fdb33 = $fopen("force_distributor_33_output.dat", "w");
  file_fdb34 = $fopen("force_distributor_34_output.dat", "w");
  file_fdb35 = $fopen("force_distributor_35_output.dat", "w");
  file_fdb36 = $fopen("force_distributor_36_output.dat", "w");
  file_fdb37 = $fopen("force_distributor_37_output.dat", "w");
  file_fdb38 = $fopen("force_distributor_38_output.dat", "w");
  file_fdb39 = $fopen("force_distributor_39_output.dat", "w");
  file_fdb40 = $fopen("force_distributor_40_output.dat", "w");
  file_fdb41 = $fopen("force_distributor_41_output.dat", "w");
  file_fdb43 = $fopen("force_distributor_43_output.dat", "w");
  file_fdb44 = $fopen("force_distributor_44_output.dat", "w");
  file_fdb45 = $fopen("force_distributor_45_output.dat", "w");
  file_fdb46 = $fopen("force_distributor_46_output.dat", "w");
  file_fdb47 = $fopen("force_distributor_47_output.dat", "w");
  file_fdb48 = $fopen("force_distributor_48_output.dat", "w");
  file_fdb49 = $fopen("force_distributor_49_output.dat", "w");
  file_fdb50 = $fopen("force_distributor_50_output.dat", "w");
  file_fdb51 = $fopen("force_distributor_51_output.dat", "w");
  file_fdb52 = $fopen("force_distributor_52_output.dat", "w");
  file_fdb53 = $fopen("force_distributor_53_output.dat", "w");
  file_fdb54 = $fopen("force_distributor_54_output.dat", "w");
  file_fdb55 = $fopen("force_distributor_55_output.dat", "w");
  file_fdb56 = $fopen("force_distributor_56_output.dat", "w");
  file_fdb57 = $fopen("force_distributor_57_output.dat", "w");
  file_fdb58 = $fopen("force_distributor_58_output.dat", "w");
  file_fdb59 = $fopen("force_distributor_59_output.dat", "w");
  file_fdb60 = $fopen("force_distributor_60_output.dat", "w");
  file_fdb62 = $fopen("force_distributor_62_output.dat", "w");
  file_fdb63 = $fopen("force_distributor_63_output.dat", "w");

  if(!file_fdb1  | !file_fdb2  | !file_fdb3  | !file_fdb4  | !file_fdb5  | !file_fdb6  | !file_fdb7  | !file_fdb8  | !file_fdb9  | !file_fdb10 |
     !file_fdb11 | !file_fdb12 | !file_fdb13 | !file_fdb14 | !file_fdb15 | !file_fdb16 | !file_fdb17 | !file_fdb18 | !file_fdb19 | !file_fdb20 |
     !file_fdb21 | !file_fdb22 | !file_fdb23 | !file_fdb24 | !file_fdb25 | !file_fdb26 |               !file_fdb28 | !file_fdb29 | !file_fdb30 |
     !file_fdb31 | !file_fdb32 | !file_fdb33 | !file_fdb34 | !file_fdb35 | !file_fdb36 | !file_fdb37 | !file_fdb38 | !file_fdb39 | !file_fdb40 |
     !file_fdb41 |               !file_fdb43 | !file_fdb44 | !file_fdb45 | !file_fdb46 | !file_fdb47 | !file_fdb48 | !file_fdb49 | !file_fdb50 |
     !file_fdb51 | !file_fdb52 | !file_fdb53 | !file_fdb54 | !file_fdb55 | !file_fdb56 | !file_fdb57 | !file_fdb58 | !file_fdb59 | !file_fdb60 |
                   !file_fdb62 | !file_fdb63 
  )begin
    $display("Error opening output files.");
    $stop();
  end
end


// Cell 0
// 1. values written to force cache
// 1.1 going out of the force distributor
always @(negedge clk)begin
  if(`FD0.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD0.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb0, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD0.wb_out[102:96],
        `FD0.wb_out[31:0], `FD0.wb_out[63:32], `FD0.wb_out[95:64]);
    end
    if(`FD0.start_wb)begin
      $fdisplay(file_fdb0, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD0.state.name() == "WB_REF")begin
    if(`FD0.wb_valid & `FD0.ready)begin
      $fdisplay(file_fdb0, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD0.wb_out[102:96], `FD0.wb_out[111:109], `FD0.wb_out[108:106],
        `FD0.wb_out[105:103], `FD0.wb_out[31:0], `FD0.wb_out[63:32], `FD0.wb_out[95:64]
      );
    end
    if(`FD0.ready & `FD0.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb0, "\n\nChange ref ID.\n");
    end
  end
end

// 1.2 Going into force cache
always @(negedge clk)begin
  if(`FC0.wr_enable)begin
    $fdisplay(file_fci0, "PID=%0d\t\t%x\t%x\t%x", `FC0.force_wr_addr,
      `FC0.force_to_cache[31:0], `FC0.force_to_cache[63:32], `FC0.force_to_cache[95:64]);
  end
end

// 2. values going into 7 partial force accumulators
localparam C1 = 3'b001;
localparam C2 = 3'b010;
localparam C3 = 3'b011;

//filter 0
always @(negedge clk)begin
  if(`PA00.in_input_valid & `PA00.particle_id_match & (`PA00.cell_id_match | `PA00.phase_change))begin
    if(`PA00.in_id.cell_id == {C2,C2,C2})begin //(222)
      $fdisplay(file00, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA00.in_id.cell_id == {C3,C1,C3})begin //(313)
      $fdisplay(file07, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 0 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA00.particle_id_match)begin
    $fdisplay(file00, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA00.in_id.particle);
    $fdisplay(file07, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA00.in_id.particle);
  end
end

//filter 1
always @(negedge clk)begin
  if(`PA01.in_input_valid & `PA01.particle_id_match & (`PA01.cell_id_match | `PA01.phase_change))begin
    if(`PA01.in_id.cell_id == {C2,C2,C3})begin //(223)
      $fdisplay(file01, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA01.in_id.cell_id == {C3,C2,C1})begin //(321)
      $fdisplay(file08, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 1 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(~`PA01.particle_id_match)begin
    $fdisplay(file01, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA01.in_id.particle);
    $fdisplay(file08, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA01.in_id.particle);
  end
end

//filter 2
always @(negedge clk)begin
  if(`PA02.in_input_valid & `PA02.particle_id_match & (`PA02.cell_id_match | `PA02.phase_change))begin
    if(`PA02.in_id.cell_id == {C2,C3,C1})begin //(231)
      $fdisplay(file02, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA02.in_id.cell_id == {C3,C2,C2})begin
      $fdisplay(file09, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 2 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA02.particle_id_match)begin
    $fdisplay(file02, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA02.in_id.particle);
    $fdisplay(file09, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA02.in_id.particle);
  end
end

//filter 3
always @(negedge clk)begin
  if(`PA03.in_input_valid & `PA03.particle_id_match & (`PA03.cell_id_match | `PA03.phase_change))begin
    if(`PA03.in_id.cell_id == {C2,C3,C2})begin //(232)
      $fdisplay(file03, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA03.in_id.cell_id == {C3,C2,C3})begin
      $fdisplay(file010, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 3 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA03.particle_id_match)begin
    $fdisplay(file03, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA03.in_id.particle);
    $fdisplay(file010, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA03.in_id.particle);
  end
end

//filter 4
always @(negedge clk)begin
  if(`PA04.in_input_valid & `PA04.particle_id_match & (`PA04.cell_id_match | `PA04.phase_change))begin
    if(`PA04.in_id.cell_id == {C2,C3,C3})begin //(233)
      $fdisplay(file04, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA04.in_id.cell_id == {C3,C3,C1})begin
      $fdisplay(file011, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 4 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA04.particle_id_match)begin
    $fdisplay(file04, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA04.in_id.particle);
    $fdisplay(file011, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA04.in_id.particle);
  end
end

//filter 5
always @(negedge clk)begin
  if(`PA05.in_input_valid & `PA05.particle_id_match & (`PA05.cell_id_match | `PA05.phase_change))begin
    if(`PA05.in_id.cell_id == {C3,C1,C1})begin //(311)
      $fdisplay(file05, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA05.in_id.cell_id == {C3,C3,C2})begin
      $fdisplay(file012, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 5 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA05.particle_id_match)begin
    $fdisplay(file05, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA05.in_id.particle);
    $fdisplay(file012, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA05.in_id.particle);
  end
end

//filter 6
always @(negedge clk)begin
  if(`PA06.in_input_valid & `PA06.particle_id_match & (`PA06.cell_id_match | `PA06.phase_change))begin
    if(`PA06.in_id.cell_id == {C3,C1,C2})begin //(312)
      $fdisplay(file06, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else if(`PA06.in_id.cell_id == {C3,C3,C3})begin
      $fdisplay(file013, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL0.out_neighbor_particle_id[6:0], 
        $time,
        `RL0.out_RL_Force_X,
        `RL0.out_RL_Force_Y,
        `RL0.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 6 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA06.particle_id_match)begin
    $fdisplay(file06, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA06.in_id.particle);
    $fdisplay(file013, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA06.in_id.particle);
  end
end


// 3. values read from force cache for motion update
logic mu_started;
initial begin
  mu_started = 0;
  wait(RL_top.motion_update_start);
  mu_started = 1;
end

always @(negedge clk)begin
  if(`FC0.rd_enable)begin
    $fdisplay(file_fco0, "t=%0t\trd_addr=%0d", $time, `FC0.force_rd_addr);
  end
end

always @(`FC0.force_id_to_MU or `FC0.force_to_MU)begin
  if(mu_started)begin
    $fdisplay(file_fco0, "t=%0t\tID=%0d\t\t%x\t%x\t%x", $time, `FC0.force_id_to_MU,
      `FC0.force_to_MU[31:0], `FC0.force_to_MU[63:32], `FC0.force_to_MU[95:64]);
  end
end


// 4. values going out of motion update unit to position and velocity caches
always @(negedge clk)begin
  if(mu_started & `MUC.out_data_valid & `MUC.out_dst_cell == 9'b001_001_001)begin
    //time  diff_x(float) diff_y  diff_z  old_pos_x(fixed)  new_pos_x(fixed) pos_y pos_z
    $fdisplay(file_mu_pos0, "t=%0t\t\t%x\t%x\t%x\t\t%x\t%x\t%x",
    $time, `MUX.b, `MUY.b, `MUZ.b, `MUX.a, `MUY.a, `MUZ.a);
  end
end

always @(negedge clk)begin
  if(mu_started & `MUC.out_data_valid & `MUC.out_dst_cell == 9'b001_001_001)begin
    $fdisplay(file_mu_vel0, "t=%0t\t\t%x\t%x\t%x", $time, `MUC.out_velocity_data[31:0], 
    `MUC.out_velocity_data[63:32], `MUC.out_velocity_data[95:64]);
  end
end


// cell 61
// 1. values written to force cache
// 1.1 going out of the force distributor
always @(negedge clk)begin
  if(`FD61.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD61.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb61, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD61.wb_out[102:96],
        `FD61.wb_out[31:0], `FD61.wb_out[63:32], `FD61.wb_out[95:64]);
    end
    if(`FD61.start_wb)begin
      $fdisplay(file_fdb61, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD61.state.name() == "WB_REF")begin
    if(`FD61.wb_valid & `FD61.ready)begin
      $fdisplay(file_fdb61, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD61.wb_out[102:96], `FD61.wb_out[111:109], `FD61.wb_out[108:106],
        `FD61.wb_out[105:103], `FD61.wb_out[31:0], `FD61.wb_out[63:32], `FD61.wb_out[95:64]
      );
    end
    if(`FD61.ready & `FD61.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb61, "\n\nChange ref ID.\n");
    end
  end
end

// 1.2 Going into force cache
always @(negedge clk)begin
  if(`FC61.wr_enable)begin
    $fdisplay(file_fci61, "PID=%0d\t\t%x\t%x\t%x", `FC61.force_wr_addr,
      `FC61.force_to_cache[31:0], `FC61.force_to_cache[63:32], `FC61.force_to_cache[95:64]);
  end
end

//filter 0
always @(negedge clk)begin
  if(`PA610.in_input_valid & `PA610.particle_id_match & (`PA610.cell_id_match | `PA610.phase_change))begin
    if(`PA610.in_id.cell_id == {C2,C2,C2})begin //(222)
      $fdisplay(file610, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL61.out_neighbor_particle_id[6:0], 
        $time,
        `RL61.out_RL_Force_X,
        `RL61.out_RL_Force_Y,
        `RL61.out_RL_Force_Z
      );
    end
    else if(`PA610.in_id.cell_id == {C3,C1,C3})begin //(313)
      $fdisplay(file617, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL61.out_neighbor_particle_id[6:0], 
        $time,
        `RL61.out_RL_Force_X,
        `RL61.out_RL_Force_Y,
        `RL61.out_RL_Force_Z
      );
    end
    else begin
      $display("Cell 61 Filter 0 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA610.particle_id_match)begin
    $fdisplay(file610, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA610.in_id.particle);
    $fdisplay(file617, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA610.in_id.particle);
  end
end

//filter 1
always @(negedge clk)begin
  if(`PA611.in_input_valid & `PA611.particle_id_match & (`PA611.cell_id_match | `PA611.phase_change))begin
    if(`PA611.in_id.cell_id == {C2,C2,C3})begin //(223)
      $fdisplay(file611, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL61.out_neighbor_particle_id[6:0], 
        $time,
        `RL61.out_RL_Force_X,
        `RL61.out_RL_Force_Y,
        `RL61.out_RL_Force_Z
      );
    end
    else if(`PA611.in_id.cell_id == {C3,C2,C1})begin //(321)
      $fdisplay(file618, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL61.out_neighbor_particle_id[6:0], 
        $time,
        `RL61.out_RL_Force_X,
        `RL61.out_RL_Force_Y,
        `RL61.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 1 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(~`PA611.particle_id_match)begin
    $fdisplay(file611, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA611.in_id.particle);
    $fdisplay(file618, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA611.in_id.particle);
  end
end

//filter 2
always @(negedge clk)begin
  if(`PA612.in_input_valid & `PA612.particle_id_match & (`PA612.cell_id_match | `PA612.phase_change))begin
    if(`PA612.in_id.cell_id == {C2,C3,C1})begin //(231)
      $fdisplay(file612, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL61.out_neighbor_particle_id[6:0], 
        $time,
        `RL61.out_RL_Force_X,
        `RL61.out_RL_Force_Y,
        `RL61.out_RL_Force_Z
      );
    end
    else if(`PA612.in_id.cell_id == {C3,C2,C2})begin
      $fdisplay(file619, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL61.out_neighbor_particle_id[6:0], 
        $time,
        `RL61.out_RL_Force_X,
        `RL61.out_RL_Force_Y,
        `RL61.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 2 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA612.particle_id_match)begin
    $fdisplay(file612, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA612.in_id.particle);
    $fdisplay(file619, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA612.in_id.particle);
  end
end

//filter 3
always @(negedge clk)begin
  if(`PA613.in_input_valid & `PA613.particle_id_match & (`PA613.cell_id_match | `PA613.phase_change))begin
    if(`PA613.in_id.cell_id == {C2,C3,C2})begin //(232)
      $fdisplay(file613, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL61.out_neighbor_particle_id[6:0], 
        $time,
        `RL61.out_RL_Force_X,
        `RL61.out_RL_Force_Y,
        `RL61.out_RL_Force_Z
      );
    end
    else if(`PA613.in_id.cell_id == {C3,C2,C3})begin
      $fdisplay(file6110, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL61.out_neighbor_particle_id[6:0], 
        $time,
        `RL61.out_RL_Force_X,
        `RL61.out_RL_Force_Y,
        `RL61.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 3 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA613.particle_id_match)begin
    $fdisplay(file613, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA613.in_id.particle);
    $fdisplay(file6110, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA613.in_id.particle);
  end
end

//filter 4
always @(negedge clk)begin
  if(`PA614.in_input_valid & `PA614.particle_id_match & (`PA614.cell_id_match | `PA614.phase_change))begin
    if(`PA614.in_id.cell_id == {C2,C3,C3})begin //(233)
      $fdisplay(file614, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL61.out_neighbor_particle_id[6:0], 
        $time,
        `RL61.out_RL_Force_X,
        `RL61.out_RL_Force_Y,
        `RL61.out_RL_Force_Z
      );
    end
    else if(`PA614.in_id.cell_id == {C3,C3,C1})begin
      $fdisplay(file6111, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL61.out_neighbor_particle_id[6:0], 
        $time,
        `RL61.out_RL_Force_X,
        `RL61.out_RL_Force_Y,
        `RL61.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 4 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA614.particle_id_match)begin
    $fdisplay(file614, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA614.in_id.particle);
    $fdisplay(file6111, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA614.in_id.particle);
  end
end

//filter 5
always @(negedge clk)begin
  if(`PA615.in_input_valid & `PA615.particle_id_match & (`PA615.cell_id_match | `PA615.phase_change))begin
    if(`PA615.in_id.cell_id == {C3,C1,C1})begin //(311)
      $fdisplay(file615, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL61.out_neighbor_particle_id[6:0], 
        $time,
        `RL61.out_RL_Force_X,
        `RL61.out_RL_Force_Y,
        `RL61.out_RL_Force_Z
      );
    end
    else if(`PA615.in_id.cell_id == {C3,C3,C2})begin
      $fdisplay(file6112, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL61.out_neighbor_particle_id[6:0], 
        $time,
        `RL61.out_RL_Force_X,
        `RL61.out_RL_Force_Y,
        `RL61.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 5 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA615.particle_id_match)begin
    $fdisplay(file615, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA615.in_id.particle);
    $fdisplay(file6112, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA615.in_id.particle);
  end
end

//filter 6
always @(negedge clk)begin
  if(`PA616.in_input_valid & `PA616.particle_id_match & (`PA616.cell_id_match | `PA616.phase_change))begin
    if(`PA616.in_id.cell_id == {C3,C1,C2})begin //(312)
      $fdisplay(file616, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL61.out_neighbor_particle_id[6:0], 
        $time,
        `RL61.out_RL_Force_X,
        `RL61.out_RL_Force_Y,
        `RL61.out_RL_Force_Z
      );
    end
    else if(`PA616.in_id.cell_id == {C3,C3,C3})begin
      $fdisplay(file6113, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL61.out_neighbor_particle_id[6:0], 
        $time,
        `RL61.out_RL_Force_X,
        `RL61.out_RL_Force_Y,
        `RL61.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 6 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA616.particle_id_match)begin
    $fdisplay(file616, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA616.in_id.particle);
    $fdisplay(file6113, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA616.in_id.particle);
  end
end


// 3. values read from force cache for motion update
always @(negedge clk)begin
  if(`FC61.rd_enable)begin
    $fdisplay(file_fco61, "t=%0t\trd_addr=%0d", $time, `FC61.force_rd_addr);
  end
end

always @(`FC61.force_id_to_MU or `FC61.force_to_MU)begin
  if(mu_started)begin
    $fdisplay(file_fco61, "t=%0t\tID=%0d\t\t%x\t%x\t%x", $time, `FC61.force_id_to_MU,
      `FC61.force_to_MU[31:0], `FC61.force_to_MU[63:32], `FC61.force_to_MU[95:64]);
  end
end


// 4. values going out of motion update unit to position and velocity caches
always @(negedge clk)begin
  if(mu_started & `MUC.out_data_valid & `MUC.out_dst_cell == 9'b010_100_100)begin //{x,y,z} cell order
    //time  diff_x(float) diff_y  diff_z  old_pos_x(fixed)  new_pos_x(fixed) pos_y pos_z
    $fdisplay(file_mu_pos61, "t=%0t\t\t%x\t%x\t%x\t\t%x\t%x\t%x",
    $time, `MUX.b, `MUY.b, `MUZ.b, `MUX.a, `MUY.a, `MUZ.a);
  end
end

always @(negedge clk)begin
  if(mu_started & `MUC.out_data_valid & `MUC.out_dst_cell == 9'b010_100_100)begin
    $fdisplay(file_mu_vel61, "t=%0t\t\t%x\t%x\t%x", $time, `MUC.out_velocity_data[31:0], 
    `MUC.out_velocity_data[63:32], `MUC.out_velocity_data[95:64]);
  end
end


// cell 27
// 1. values written to force cache
// 1.1 going out of the force distributor
always @(negedge clk)begin
  if(`FD27.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD27.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb27, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD27.wb_out[102:96],
        `FD27.wb_out[31:0], `FD27.wb_out[63:32], `FD27.wb_out[95:64]);
    end
    if(`FD27.start_wb)begin
      $fdisplay(file_fdb27, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD27.state.name() == "WB_REF")begin
    if(`FD27.wb_valid & `FD27.ready)begin
      $fdisplay(file_fdb27, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD27.wb_out[102:96], `FD27.wb_out[111:109], `FD27.wb_out[108:106],
        `FD27.wb_out[105:103], `FD27.wb_out[31:0], `FD27.wb_out[63:32], `FD27.wb_out[95:64]
      );
    end
    if(`FD27.ready & `FD27.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb27, "\n\nChange ref ID.\n");
    end
  end
end

// 1.2 Going into force cache
always @(negedge clk)begin
  if(`FC27.wr_enable)begin
    $fdisplay(file_fci27, "PID=%0d\t\t%x\t%x\t%x", `FC27.force_wr_addr,
      `FC27.force_to_cache[31:0], `FC27.force_to_cache[63:32], `FC27.force_to_cache[95:64]);
  end
end


//filter 0
always @(negedge clk)begin
  if(`PA270.in_input_valid & `PA270.particle_id_match & (`PA270.cell_id_match | `PA270.phase_change))begin
    if(`PA270.in_id.cell_id == {C2,C2,C2})begin //(222)
      $fdisplay(file270, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL27.out_neighbor_particle_id[6:0], 
        $time,
        `RL27.out_RL_Force_X,
        `RL27.out_RL_Force_Y,
        `RL27.out_RL_Force_Z
      );
    end
    else if(`PA270.in_id.cell_id == {C3,C1,C3})begin //(313)
      $fdisplay(file277, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL27.out_neighbor_particle_id[6:0], 
        $time,
        `RL27.out_RL_Force_X,
        `RL27.out_RL_Force_Y,
        `RL27.out_RL_Force_Z
      );
    end
    else begin
      $display("Cell 27 Filter 0 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA270.particle_id_match)begin
    $fdisplay(file270, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA270.in_id.particle);
    $fdisplay(file277, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA270.in_id.particle);
  end
end

//filter 1
always @(negedge clk)begin
  if(`PA271.in_input_valid & `PA271.particle_id_match & (`PA271.cell_id_match | `PA271.phase_change))begin
    if(`PA271.in_id.cell_id == {C2,C2,C3})begin //(223)
      $fdisplay(file271, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL27.out_neighbor_particle_id[6:0], 
        $time,
        `RL27.out_RL_Force_X,
        `RL27.out_RL_Force_Y,
        `RL27.out_RL_Force_Z
      );
    end
    else if(`PA271.in_id.cell_id == {C3,C2,C1})begin //(321)
      $fdisplay(file278, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL27.out_neighbor_particle_id[6:0], 
        $time,
        `RL27.out_RL_Force_X,
        `RL27.out_RL_Force_Y,
        `RL27.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 1 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(~`PA271.particle_id_match)begin
    $fdisplay(file271, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA271.in_id.particle);
    $fdisplay(file278, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA271.in_id.particle);
  end
end

//filter 2
always @(negedge clk)begin
  if(`PA272.in_input_valid & `PA272.particle_id_match & (`PA272.cell_id_match | `PA272.phase_change))begin
    if(`PA272.in_id.cell_id == {C2,C3,C1})begin //(231)
      $fdisplay(file272, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL27.out_neighbor_particle_id[6:0], 
        $time,
        `RL27.out_RL_Force_X,
        `RL27.out_RL_Force_Y,
        `RL27.out_RL_Force_Z
      );
    end
    else if(`PA272.in_id.cell_id == {C3,C2,C2})begin
      $fdisplay(file279, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL27.out_neighbor_particle_id[6:0], 
        $time,
        `RL27.out_RL_Force_X,
        `RL27.out_RL_Force_Y,
        `RL27.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 2 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA272.particle_id_match)begin
    $fdisplay(file272, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA272.in_id.particle);
    $fdisplay(file279, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA272.in_id.particle);
  end
end

//filter 3
always @(negedge clk)begin
  if(`PA273.in_input_valid & `PA273.particle_id_match & (`PA273.cell_id_match | `PA273.phase_change))begin
    if(`PA273.in_id.cell_id == {C2,C3,C2})begin //(232)
      $fdisplay(file273, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL27.out_neighbor_particle_id[6:0], 
        $time,
        `RL27.out_RL_Force_X,
        `RL27.out_RL_Force_Y,
        `RL27.out_RL_Force_Z
      );
    end
    else if(`PA273.in_id.cell_id == {C3,C2,C3})begin
      $fdisplay(file2710, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL27.out_neighbor_particle_id[6:0], 
        $time,
        `RL27.out_RL_Force_X,
        `RL27.out_RL_Force_Y,
        `RL27.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 3 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA273.particle_id_match)begin
    $fdisplay(file273, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA273.in_id.particle);
    $fdisplay(file2710, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA273.in_id.particle);
  end
end

//filter 4
always @(negedge clk)begin
  if(`PA274.in_input_valid & `PA274.particle_id_match & (`PA274.cell_id_match | `PA274.phase_change))begin
    if(`PA274.in_id.cell_id == {C2,C3,C3})begin //(233)
      $fdisplay(file274, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL27.out_neighbor_particle_id[6:0], 
        $time,
        `RL27.out_RL_Force_X,
        `RL27.out_RL_Force_Y,
        `RL27.out_RL_Force_Z
      );
    end
    else if(`PA274.in_id.cell_id == {C3,C3,C1})begin
      $fdisplay(file2711, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL27.out_neighbor_particle_id[6:0], 
        $time,
        `RL27.out_RL_Force_X,
        `RL27.out_RL_Force_Y,
        `RL27.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 4 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA274.particle_id_match)begin
    $fdisplay(file274, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA274.in_id.particle);
    $fdisplay(file2711, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA274.in_id.particle);
  end
end

//filter 5
always @(negedge clk)begin
  if(`PA275.in_input_valid & `PA275.particle_id_match & (`PA275.cell_id_match | `PA275.phase_change))begin
    if(`PA275.in_id.cell_id == {C3,C1,C1})begin //(311)
      $fdisplay(file275, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL27.out_neighbor_particle_id[6:0], 
        $time,
        `RL27.out_RL_Force_X,
        `RL27.out_RL_Force_Y,
        `RL27.out_RL_Force_Z
      );
    end
    else if(`PA275.in_id.cell_id == {C3,C3,C2})begin
      $fdisplay(file2712, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL27.out_neighbor_particle_id[6:0], 
        $time,
        `RL27.out_RL_Force_X,
        `RL27.out_RL_Force_Y,
        `RL27.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 5 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA275.particle_id_match)begin
    $fdisplay(file275, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA275.in_id.particle);
    $fdisplay(file2712, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA275.in_id.particle);
  end
end

//filter 6
always @(negedge clk)begin
  if(`PA276.in_input_valid & `PA276.particle_id_match & (`PA276.cell_id_match | `PA276.phase_change))begin
    if(`PA276.in_id.cell_id == {C3,C1,C2})begin //(312)
      $fdisplay(file276, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL27.out_neighbor_particle_id[6:0], 
        $time,
        `RL27.out_RL_Force_X,
        `RL27.out_RL_Force_Y,
        `RL27.out_RL_Force_Z
      );
    end
    else if(`PA276.in_id.cell_id == {C3,C3,C3})begin
      $fdisplay(file2713, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL27.out_neighbor_particle_id[6:0], 
        $time,
        `RL27.out_RL_Force_X,
        `RL27.out_RL_Force_Y,
        `RL27.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 6 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA276.particle_id_match)begin
    $fdisplay(file276, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA276.in_id.particle);
    $fdisplay(file2713, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA276.in_id.particle);
  end
end


// 3. values read from force cache for motion update
always @(negedge clk)begin
  if(`FC27.rd_enable)begin
    $fdisplay(file_fco27, "t=%0t\trd_addr=%0d", $time, `FC27.force_rd_addr);
  end
end

always @(`FC27.force_id_to_MU or `FC27.force_to_MU)begin
  if(mu_started)begin
    $fdisplay(file_fco27, "t=%0t\tID=%0d\t\t%x\t%x\t%x", $time, `FC27.force_id_to_MU,
      `FC27.force_to_MU[31:0], `FC27.force_to_MU[63:32], `FC27.force_to_MU[95:64]);
  end
end


// 4. values going out of motion update unit to position and velocity caches
always @(negedge clk)begin
  if(mu_started & `MUC.out_data_valid & `MUC.out_dst_cell == 9'b100_011_010)begin //{x,y,z} cell order
    //time  diff_x(float) diff_y  diff_z  old_pos_x(fixed)  new_pos_x(fixed) pos_y pos_z
    $fdisplay(file_mu_pos27, "t=%0t\t\t%x\t%x\t%x\t\t%x\t%x\t%x",
    $time, `MUX.b, `MUY.b, `MUZ.b, `MUX.a, `MUY.a, `MUZ.a);
  end
end

always @(negedge clk)begin
  if(mu_started & `MUC.out_data_valid & `MUC.out_dst_cell == 9'b100_011_010)begin
    $fdisplay(file_mu_vel27, "t=%0t\t\t%x\t%x\t%x", $time, `MUC.out_velocity_data[31:0], 
    `MUC.out_velocity_data[63:32], `MUC.out_velocity_data[95:64]);
  end
end


// cell 42
// 1. values written to force cache
// 1.1 going out of the force distributor
always @(negedge clk)begin
  if(`FD42.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD42.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb42, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD42.wb_out[102:96],
        `FD42.wb_out[31:0], `FD42.wb_out[63:32], `FD42.wb_out[95:64]);
    end
    if(`FD42.start_wb)begin
      $fdisplay(file_fdb42, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD42.state.name() == "WB_REF")begin
    if(`FD42.wb_valid & `FD42.ready)begin
      $fdisplay(file_fdb42, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD42.wb_out[102:96], `FD42.wb_out[111:109], `FD42.wb_out[108:106],
        `FD42.wb_out[105:103], `FD42.wb_out[31:0], `FD42.wb_out[63:32], `FD42.wb_out[95:64]
      );
    end
    if(`FD42.ready & `FD42.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb42, "\n\nChange ref ID.\n");
    end
  end
end

// 1.2 Going into force cache
always @(negedge clk)begin
  if(`FC42.wr_enable)begin
    $fdisplay(file_fci42, "PID=%0d\t\t%x\t%x\t%x", `FC42.force_wr_addr,
      `FC42.force_to_cache[31:0], `FC42.force_to_cache[63:32], `FC42.force_to_cache[95:64]);
  end
end


//filter 0
always @(negedge clk)begin
  if(`PA420.in_input_valid & `PA420.particle_id_match & (`PA420.cell_id_match | `PA420.phase_change))begin
    if(`PA420.in_id.cell_id == {C2,C2,C2})begin //(222)
      $fdisplay(file420, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL42.out_neighbor_particle_id[6:0], 
        $time,
        `RL42.out_RL_Force_X,
        `RL42.out_RL_Force_Y,
        `RL42.out_RL_Force_Z
      );
    end
    else if(`PA420.in_id.cell_id == {C3,C1,C3})begin //(313)
      $fdisplay(file427, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL42.out_neighbor_particle_id[6:0], 
        $time,
        `RL42.out_RL_Force_X,
        `RL42.out_RL_Force_Y,
        `RL42.out_RL_Force_Z
      );
    end
    else begin
      $display("Cell 42 Filter 0 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA420.particle_id_match)begin
    $fdisplay(file420, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA420.in_id.particle);
    $fdisplay(file427, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA420.in_id.particle);
  end
end

//filter 1
always @(negedge clk)begin
  if(`PA421.in_input_valid & `PA421.particle_id_match & (`PA421.cell_id_match | `PA421.phase_change))begin
    if(`PA421.in_id.cell_id == {C2,C2,C3})begin //(223)
      $fdisplay(file421, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL42.out_neighbor_particle_id[6:0], 
        $time,
        `RL42.out_RL_Force_X,
        `RL42.out_RL_Force_Y,
        `RL42.out_RL_Force_Z
      );
    end
    else if(`PA421.in_id.cell_id == {C3,C2,C1})begin //(321)
      $fdisplay(file428, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL42.out_neighbor_particle_id[6:0], 
        $time,
        `RL42.out_RL_Force_X,
        `RL42.out_RL_Force_Y,
        `RL42.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 1 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(~`PA421.particle_id_match)begin
    $fdisplay(file421, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA421.in_id.particle);
    $fdisplay(file428, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA421.in_id.particle);
  end
end

//filter 2
always @(negedge clk)begin
  if(`PA422.in_input_valid & `PA422.particle_id_match & (`PA422.cell_id_match | `PA422.phase_change))begin
    if(`PA422.in_id.cell_id == {C2,C3,C1})begin //(231)
      $fdisplay(file422, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL42.out_neighbor_particle_id[6:0], 
        $time,
        `RL42.out_RL_Force_X,
        `RL42.out_RL_Force_Y,
        `RL42.out_RL_Force_Z
      );
    end
    else if(`PA422.in_id.cell_id == {C3,C2,C2})begin
      $fdisplay(file429, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL42.out_neighbor_particle_id[6:0], 
        $time,
        `RL42.out_RL_Force_X,
        `RL42.out_RL_Force_Y,
        `RL42.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 2 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA422.particle_id_match)begin
    $fdisplay(file422, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA422.in_id.particle);
    $fdisplay(file429, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA422.in_id.particle);
  end
end

//filter 3
always @(negedge clk)begin
  if(`PA423.in_input_valid & `PA423.particle_id_match & (`PA423.cell_id_match | `PA423.phase_change))begin
    if(`PA423.in_id.cell_id == {C2,C3,C2})begin //(232)
      $fdisplay(file423, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL42.out_neighbor_particle_id[6:0], 
        $time,
        `RL42.out_RL_Force_X,
        `RL42.out_RL_Force_Y,
        `RL42.out_RL_Force_Z
      );
    end
    else if(`PA423.in_id.cell_id == {C3,C2,C3})begin
      $fdisplay(file4210, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL42.out_neighbor_particle_id[6:0], 
        $time,
        `RL42.out_RL_Force_X,
        `RL42.out_RL_Force_Y,
        `RL42.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 3 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA423.particle_id_match)begin
    $fdisplay(file423, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA423.in_id.particle);
    $fdisplay(file4210, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA423.in_id.particle);
  end
end

//filter 4
always @(negedge clk)begin
  if(`PA424.in_input_valid & `PA424.particle_id_match & (`PA424.cell_id_match | `PA424.phase_change))begin
    if(`PA424.in_id.cell_id == {C2,C3,C3})begin //(233)
      $fdisplay(file424, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL42.out_neighbor_particle_id[6:0], 
        $time,
        `RL42.out_RL_Force_X,
        `RL42.out_RL_Force_Y,
        `RL42.out_RL_Force_Z
      );
    end
    else if(`PA424.in_id.cell_id == {C3,C3,C1})begin
      $fdisplay(file4211, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL42.out_neighbor_particle_id[6:0], 
        $time,
        `RL42.out_RL_Force_X,
        `RL42.out_RL_Force_Y,
        `RL42.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 4 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA424.particle_id_match)begin
    $fdisplay(file424, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA424.in_id.particle);
    $fdisplay(file4211, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA424.in_id.particle);
  end
end

//filter 5
always @(negedge clk)begin
  if(`PA425.in_input_valid & `PA425.particle_id_match & (`PA425.cell_id_match | `PA425.phase_change))begin
    if(`PA425.in_id.cell_id == {C3,C1,C1})begin //(311)
      $fdisplay(file425, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL42.out_neighbor_particle_id[6:0], 
        $time,
        `RL42.out_RL_Force_X,
        `RL42.out_RL_Force_Y,
        `RL42.out_RL_Force_Z
      );
    end
    else if(`PA425.in_id.cell_id == {C3,C3,C2})begin
      $fdisplay(file4212, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL42.out_neighbor_particle_id[6:0], 
        $time,
        `RL42.out_RL_Force_X,
        `RL42.out_RL_Force_Y,
        `RL42.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 5 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA425.particle_id_match)begin
    $fdisplay(file425, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA425.in_id.particle);
    $fdisplay(file4212, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA425.in_id.particle);
  end
end

//filter 6
always @(negedge clk)begin
  if(`PA426.in_input_valid & `PA426.particle_id_match & (`PA426.cell_id_match | `PA426.phase_change))begin
    if(`PA426.in_id.cell_id == {C3,C1,C2})begin //(312)
      $fdisplay(file426, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL42.out_neighbor_particle_id[6:0], 
        $time,
        `RL42.out_RL_Force_X,
        `RL42.out_RL_Force_Y,
        `RL42.out_RL_Force_Z
      );
    end
    else if(`PA426.in_id.cell_id == {C3,C3,C3})begin
      $fdisplay(file4213, "nb_PID=%0d\ttime=%0t\tFx=%h\tFy=%h\tFz=%h", 
        `RL42.out_neighbor_particle_id[6:0], 
        $time,
        `RL42.out_RL_Force_X,
        `RL42.out_RL_Force_Y,
        `RL42.out_RL_Force_Z
      );
    end
    else begin
      $display("Filter 6 getting wrong value at t=%0t", $time);
      $stop();
    end
  end
  else if(!`PA426.particle_id_match)begin
    $fdisplay(file426, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA426.in_id.particle);
    $fdisplay(file4213, "\n\nChange ref ID. Next ref_ID=%0d\n", `PA426.in_id.particle);
  end
end


// 3. values read from force cache for motion update
always @(negedge clk)begin
  if(`FC42.rd_enable)begin
    $fdisplay(file_fco42, "t=%0t\trd_addr=%0d", $time, `FC42.force_rd_addr);
  end
end

always @(`FC42.force_id_to_MU or `FC42.force_to_MU)begin
  if(mu_started)begin
    $fdisplay(file_fco42, "t=%0t\tID=%0d\t\t%x\t%x\t%x", $time, `FC42.force_id_to_MU,
      `FC42.force_to_MU[31:0], `FC42.force_to_MU[63:32], `FC42.force_to_MU[95:64]);
  end
end


// 4. values going out of motion update unit to position and velocity caches
always @(negedge clk)begin
  if(mu_started & `MUC.out_data_valid & `MUC.out_dst_cell == 9'b011_011_011)begin //{x,y,z} cell order
    //time  diff_x(float) diff_y  diff_z  old_pos_x(fixed)  new_pos_x(fixed) pos_y pos_z
    $fdisplay(file_mu_pos42, "t=%0t\t\t%x\t%x\t%x\t\t%x\t%x\t%x",
    $time, `MUX.b, `MUY.b, `MUZ.b, `MUX.a, `MUY.a, `MUZ.a);
  end
end

always @(negedge clk)begin
  if(mu_started & `MUC.out_data_valid & `MUC.out_dst_cell == 9'b011_011_011)begin
    $fdisplay(file_mu_vel42, "t=%0t\t\t%x\t%x\t%x", $time, `MUC.out_velocity_data[31:0], 
    `MUC.out_velocity_data[63:32], `MUC.out_velocity_data[95:64]);
  end
end


// Record data sent out of the force distributor for rest of the cells
// cell 1
always @(negedge clk)begin
  if(`FD1.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD1.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb1, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD1.wb_out[102:96],
        `FD1.wb_out[31:0], `FD1.wb_out[63:32], `FD1.wb_out[95:64]);
    end
    if(`FD1.start_wb)begin
      $fdisplay(file_fdb1, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD1.state.name() == "WB_REF")begin
    if(`FD1.wb_valid & `FD1.ready)begin
      $fdisplay(file_fdb1, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD1.wb_out[102:96], `FD1.wb_out[111:109], `FD1.wb_out[108:106],
        `FD1.wb_out[105:103], `FD1.wb_out[31:0], `FD1.wb_out[63:32], `FD1.wb_out[95:64]
      );
    end
    if(`FD1.ready & `FD1.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb1, "\n\nChange ref ID.\n");
    end
  end
end

// cell 2
always @(negedge clk)begin
  if(`FD2.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD2.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb2, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD2.wb_out[102:96],
        `FD2.wb_out[31:0], `FD2.wb_out[63:32], `FD2.wb_out[95:64]);
    end
    if(`FD2.start_wb)begin
      $fdisplay(file_fdb2, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD2.state.name() == "WB_REF")begin
    if(`FD2.wb_valid & `FD2.ready)begin
      $fdisplay(file_fdb2, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD2.wb_out[102:96], `FD2.wb_out[111:109], `FD2.wb_out[108:106],
        `FD2.wb_out[105:103], `FD2.wb_out[31:0], `FD2.wb_out[63:32], `FD2.wb_out[95:64]
      );
    end
    if(`FD2.ready & `FD2.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb2, "\n\nChange ref ID.\n");
    end
  end
end

// cell 3
always @(negedge clk)begin
  if(`FD3.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD3.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb3, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD3.wb_out[102:96],
        `FD3.wb_out[31:0], `FD3.wb_out[63:32], `FD3.wb_out[95:64]);
    end
    if(`FD3.start_wb)begin
      $fdisplay(file_fdb3, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD3.state.name() == "WB_REF")begin
    if(`FD3.wb_valid & `FD3.ready)begin
      $fdisplay(file_fdb3, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD3.wb_out[102:96], `FD3.wb_out[111:109], `FD3.wb_out[108:106],
        `FD3.wb_out[105:103], `FD3.wb_out[31:0], `FD3.wb_out[63:32], `FD3.wb_out[95:64]
      );
    end
    if(`FD3.ready & `FD3.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb3, "\n\nChange ref ID.\n");
    end
  end
end

// cell 4
always @(negedge clk)begin
  if(`FD4.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD4.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb4, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD4.wb_out[102:96],
        `FD4.wb_out[31:0], `FD4.wb_out[63:32], `FD4.wb_out[95:64]);
    end
    if(`FD4.start_wb)begin
      $fdisplay(file_fdb4, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD4.state.name() == "WB_REF")begin
    if(`FD4.wb_valid & `FD4.ready)begin
      $fdisplay(file_fdb4, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD4.wb_out[102:96], `FD4.wb_out[111:109], `FD4.wb_out[108:106],
        `FD4.wb_out[105:103], `FD4.wb_out[31:0], `FD4.wb_out[63:32], `FD4.wb_out[95:64]
      );
    end
    if(`FD4.ready & `FD4.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb4, "\n\nChange ref ID.\n");
    end
  end
end

// cell 5
always @(negedge clk)begin
  if(`FD5.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD5.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb5, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD5.wb_out[102:96],
        `FD5.wb_out[31:0], `FD5.wb_out[63:32], `FD5.wb_out[95:64]);
    end
    if(`FD5.start_wb)begin
      $fdisplay(file_fdb5, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD5.state.name() == "WB_REF")begin
    if(`FD5.wb_valid & `FD5.ready)begin
      $fdisplay(file_fdb5, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD5.wb_out[102:96], `FD5.wb_out[111:109], `FD5.wb_out[108:106],
        `FD5.wb_out[105:103], `FD5.wb_out[31:0], `FD5.wb_out[63:32], `FD5.wb_out[95:64]
      );
    end
    if(`FD5.ready & `FD5.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb5, "\n\nChange ref ID.\n");
    end
  end
end

// cell 6
always @(negedge clk)begin
  if(`FD6.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD6.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb6, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD6.wb_out[102:96],
        `FD6.wb_out[31:0], `FD6.wb_out[63:32], `FD6.wb_out[95:64]);
    end
    if(`FD6.start_wb)begin
      $fdisplay(file_fdb6, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD6.state.name() == "WB_REF")begin
    if(`FD6.wb_valid & `FD6.ready)begin
      $fdisplay(file_fdb6, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD6.wb_out[102:96], `FD6.wb_out[111:109], `FD6.wb_out[108:106],
        `FD6.wb_out[105:103], `FD6.wb_out[31:0], `FD6.wb_out[63:32], `FD6.wb_out[95:64]
      );
    end
    if(`FD6.ready & `FD6.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb6, "\n\nChange ref ID.\n");
    end
  end
end

// cell 7
always @(negedge clk)begin
  if(`FD7.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD7.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb7, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD7.wb_out[102:96],
        `FD7.wb_out[31:0], `FD7.wb_out[63:32], `FD7.wb_out[95:64]);
    end
    if(`FD7.start_wb)begin
      $fdisplay(file_fdb7, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD7.state.name() == "WB_REF")begin
    if(`FD7.wb_valid & `FD7.ready)begin
      $fdisplay(file_fdb7, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD7.wb_out[102:96], `FD7.wb_out[111:109], `FD7.wb_out[108:106],
        `FD7.wb_out[105:103], `FD7.wb_out[31:0], `FD7.wb_out[63:32], `FD7.wb_out[95:64]
      );
    end
    if(`FD7.ready & `FD7.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb7, "\n\nChange ref ID.\n");
    end
  end
end

// cell 8
always @(negedge clk)begin
  if(`FD8.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD8.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb8, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD8.wb_out[102:96],
        `FD8.wb_out[31:0], `FD8.wb_out[63:32], `FD8.wb_out[95:64]);
    end
    if(`FD8.start_wb)begin
      $fdisplay(file_fdb8, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD8.state.name() == "WB_REF")begin
    if(`FD8.wb_valid & `FD8.ready)begin
      $fdisplay(file_fdb8, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD8.wb_out[102:96], `FD8.wb_out[111:109], `FD8.wb_out[108:106],
        `FD8.wb_out[105:103], `FD8.wb_out[31:0], `FD8.wb_out[63:32], `FD8.wb_out[95:64]
      );
    end
    if(`FD8.ready & `FD8.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb8, "\n\nChange ref ID.\n");
    end
  end
end

// cell 9
always @(negedge clk)begin
  if(`FD9.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD9.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb9, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD9.wb_out[102:96],
        `FD9.wb_out[31:0], `FD9.wb_out[63:32], `FD9.wb_out[95:64]);
    end
    if(`FD9.start_wb)begin
      $fdisplay(file_fdb9, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD9.state.name() == "WB_REF")begin
    if(`FD9.wb_valid & `FD9.ready)begin
      $fdisplay(file_fdb9, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD9.wb_out[102:96], `FD9.wb_out[111:109], `FD9.wb_out[108:106],
        `FD9.wb_out[105:103], `FD9.wb_out[31:0], `FD9.wb_out[63:32], `FD9.wb_out[95:64]
      );
    end
    if(`FD9.ready & `FD9.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb9, "\n\nChange ref ID.\n");
    end
  end
end

// cell 10
always @(negedge clk)begin
  if(`FD10.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD10.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb10, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD10.wb_out[102:96],
        `FD10.wb_out[31:0], `FD10.wb_out[63:32], `FD10.wb_out[95:64]);
    end
    if(`FD10.start_wb)begin
      $fdisplay(file_fdb10, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD10.state.name() == "WB_REF")begin
    if(`FD10.wb_valid & `FD10.ready)begin
      $fdisplay(file_fdb10, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD10.wb_out[102:96], `FD10.wb_out[111:109], `FD10.wb_out[108:106],
        `FD10.wb_out[105:103], `FD10.wb_out[31:0], `FD10.wb_out[63:32], `FD10.wb_out[95:64]
      );
    end
    if(`FD10.ready & `FD10.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb10, "\n\nChange ref ID.\n");
    end
  end
end

// cell 11
always @(negedge clk)begin
  if(`FD11.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD11.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb11, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD11.wb_out[102:96],
        `FD11.wb_out[31:0], `FD11.wb_out[63:32], `FD11.wb_out[95:64]);
    end
    if(`FD11.start_wb)begin
      $fdisplay(file_fdb11, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD11.state.name() == "WB_REF")begin
    if(`FD11.wb_valid & `FD11.ready)begin
      $fdisplay(file_fdb11, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD11.wb_out[102:96], `FD11.wb_out[111:109], `FD11.wb_out[108:106],
        `FD11.wb_out[105:103], `FD11.wb_out[31:0], `FD11.wb_out[63:32], `FD11.wb_out[95:64]
      );
    end
    if(`FD11.ready & `FD11.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb11, "\n\nChange ref ID.\n");
    end
  end
end

// cell 12
always @(negedge clk)begin
  if(`FD12.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD12.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb12, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD12.wb_out[102:96],
        `FD12.wb_out[31:0], `FD12.wb_out[63:32], `FD12.wb_out[95:64]);
    end
    if(`FD12.start_wb)begin
      $fdisplay(file_fdb12, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD12.state.name() == "WB_REF")begin
    if(`FD12.wb_valid & `FD12.ready)begin
      $fdisplay(file_fdb12, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD12.wb_out[102:96], `FD12.wb_out[111:109], `FD12.wb_out[108:106],
        `FD12.wb_out[105:103], `FD12.wb_out[31:0], `FD12.wb_out[63:32], `FD12.wb_out[95:64]
      );
    end
    if(`FD12.ready & `FD12.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb12, "\n\nChange ref ID.\n");
    end
  end
end

// cell 13
always @(negedge clk)begin
  if(`FD13.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD13.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb13, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD13.wb_out[102:96],
        `FD13.wb_out[31:0], `FD13.wb_out[63:32], `FD13.wb_out[95:64]);
    end
    if(`FD13.start_wb)begin
      $fdisplay(file_fdb13, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD13.state.name() == "WB_REF")begin
    if(`FD13.wb_valid & `FD13.ready)begin
      $fdisplay(file_fdb13, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD13.wb_out[102:96], `FD13.wb_out[111:109], `FD13.wb_out[108:106],
        `FD13.wb_out[105:103], `FD13.wb_out[31:0], `FD13.wb_out[63:32], `FD13.wb_out[95:64]
      );
    end
    if(`FD13.ready & `FD13.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb13, "\n\nChange ref ID.\n");
    end
  end
end

// cell 14
always @(negedge clk)begin
  if(`FD14.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD14.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb14, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD14.wb_out[102:96],
        `FD14.wb_out[31:0], `FD14.wb_out[63:32], `FD14.wb_out[95:64]);
    end
    if(`FD14.start_wb)begin
      $fdisplay(file_fdb14, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD14.state.name() == "WB_REF")begin
    if(`FD14.wb_valid & `FD14.ready)begin
      $fdisplay(file_fdb14, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD14.wb_out[102:96], `FD14.wb_out[111:109], `FD14.wb_out[108:106],
        `FD14.wb_out[105:103], `FD14.wb_out[31:0], `FD14.wb_out[63:32], `FD14.wb_out[95:64]
      );
    end
    if(`FD14.ready & `FD14.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb14, "\n\nChange ref ID.\n");
    end
  end
end

// cell 15
always @(negedge clk)begin
  if(`FD15.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD15.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb15, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD15.wb_out[102:96],
        `FD15.wb_out[31:0], `FD15.wb_out[63:32], `FD15.wb_out[95:64]);
    end
    if(`FD15.start_wb)begin
      $fdisplay(file_fdb15, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD15.state.name() == "WB_REF")begin
    if(`FD15.wb_valid & `FD15.ready)begin
      $fdisplay(file_fdb15, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD15.wb_out[102:96], `FD15.wb_out[111:109], `FD15.wb_out[108:106],
        `FD15.wb_out[105:103], `FD15.wb_out[31:0], `FD15.wb_out[63:32], `FD15.wb_out[95:64]
      );
    end
    if(`FD15.ready & `FD15.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb15, "\n\nChange ref ID.\n");
    end
  end
end

// cell 16
always @(negedge clk)begin
  if(`FD16.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD16.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb16, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD16.wb_out[102:96],
        `FD16.wb_out[31:0], `FD16.wb_out[63:32], `FD16.wb_out[95:64]);
    end
    if(`FD16.start_wb)begin
      $fdisplay(file_fdb16, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD16.state.name() == "WB_REF")begin
    if(`FD16.wb_valid & `FD16.ready)begin
      $fdisplay(file_fdb16, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD16.wb_out[102:96], `FD16.wb_out[111:109], `FD16.wb_out[108:106],
        `FD16.wb_out[105:103], `FD16.wb_out[31:0], `FD16.wb_out[63:32], `FD16.wb_out[95:64]
      );
    end
    if(`FD16.ready & `FD16.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb16, "\n\nChange ref ID.\n");
    end
  end
end

// cell 17
always @(negedge clk)begin
  if(`FD17.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD17.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb17, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD17.wb_out[102:96],
        `FD17.wb_out[31:0], `FD17.wb_out[63:32], `FD17.wb_out[95:64]);
    end
    if(`FD17.start_wb)begin
      $fdisplay(file_fdb17, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD17.state.name() == "WB_REF")begin
    if(`FD17.wb_valid & `FD17.ready)begin
      $fdisplay(file_fdb17, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD17.wb_out[102:96], `FD17.wb_out[111:109], `FD17.wb_out[108:106],
        `FD17.wb_out[105:103], `FD17.wb_out[31:0], `FD17.wb_out[63:32], `FD17.wb_out[95:64]
      );
    end
    if(`FD17.ready & `FD17.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb17, "\n\nChange ref ID.\n");
    end
  end
end

// cell 18
always @(negedge clk)begin
  if(`FD18.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD18.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb18, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD18.wb_out[102:96],
        `FD18.wb_out[31:0], `FD18.wb_out[63:32], `FD18.wb_out[95:64]);
    end
    if(`FD18.start_wb)begin
      $fdisplay(file_fdb18, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD18.state.name() == "WB_REF")begin
    if(`FD18.wb_valid & `FD18.ready)begin
      $fdisplay(file_fdb18, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD18.wb_out[102:96], `FD18.wb_out[111:109], `FD18.wb_out[108:106],
        `FD18.wb_out[105:103], `FD18.wb_out[31:0], `FD18.wb_out[63:32], `FD18.wb_out[95:64]
      );
    end
    if(`FD18.ready & `FD18.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb18, "\n\nChange ref ID.\n");
    end
  end
end

// cell 19
always @(negedge clk)begin
  if(`FD19.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD19.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb19, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD19.wb_out[102:96],
        `FD19.wb_out[31:0], `FD19.wb_out[63:32], `FD19.wb_out[95:64]);
    end
    if(`FD19.start_wb)begin
      $fdisplay(file_fdb19, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD19.state.name() == "WB_REF")begin
    if(`FD19.wb_valid & `FD19.ready)begin
      $fdisplay(file_fdb19, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD19.wb_out[102:96], `FD19.wb_out[111:109], `FD19.wb_out[108:106],
        `FD19.wb_out[105:103], `FD19.wb_out[31:0], `FD19.wb_out[63:32], `FD19.wb_out[95:64]
      );
    end
    if(`FD19.ready & `FD19.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb19, "\n\nChange ref ID.\n");
    end
  end
end

// cell 20
always @(negedge clk)begin
  if(`FD20.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD20.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb20, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD20.wb_out[102:96],
        `FD20.wb_out[31:0], `FD20.wb_out[63:32], `FD20.wb_out[95:64]);
    end
    if(`FD20.start_wb)begin
      $fdisplay(file_fdb20, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD20.state.name() == "WB_REF")begin
    if(`FD20.wb_valid & `FD20.ready)begin
      $fdisplay(file_fdb20, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD20.wb_out[102:96], `FD20.wb_out[111:109], `FD20.wb_out[108:106],
        `FD20.wb_out[105:103], `FD20.wb_out[31:0], `FD20.wb_out[63:32], `FD20.wb_out[95:64]
      );
    end
    if(`FD20.ready & `FD20.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb20, "\n\nChange ref ID.\n");
    end
  end
end

// cell 21
always @(negedge clk)begin
  if(`FD21.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD21.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb21, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD21.wb_out[102:96],
        `FD21.wb_out[31:0], `FD21.wb_out[63:32], `FD21.wb_out[95:64]);
    end
    if(`FD21.start_wb)begin
      $fdisplay(file_fdb21, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD21.state.name() == "WB_REF")begin
    if(`FD21.wb_valid & `FD21.ready)begin
      $fdisplay(file_fdb21, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD21.wb_out[102:96], `FD21.wb_out[111:109], `FD21.wb_out[108:106],
        `FD21.wb_out[105:103], `FD21.wb_out[31:0], `FD21.wb_out[63:32], `FD21.wb_out[95:64]
      );
    end
    if(`FD21.ready & `FD21.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb21, "\n\nChange ref ID.\n");
    end
  end
end

// cell 22
always @(negedge clk)begin
  if(`FD22.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD22.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb22, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD22.wb_out[102:96],
        `FD22.wb_out[31:0], `FD22.wb_out[63:32], `FD22.wb_out[95:64]);
    end
    if(`FD22.start_wb)begin
      $fdisplay(file_fdb22, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD22.state.name() == "WB_REF")begin
    if(`FD22.wb_valid & `FD22.ready)begin
      $fdisplay(file_fdb22, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD22.wb_out[102:96], `FD22.wb_out[111:109], `FD22.wb_out[108:106],
        `FD22.wb_out[105:103], `FD22.wb_out[31:0], `FD22.wb_out[63:32], `FD22.wb_out[95:64]
      );
    end
    if(`FD22.ready & `FD22.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb22, "\n\nChange ref ID.\n");
    end
  end
end

// cell 23
always @(negedge clk)begin
  if(`FD23.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD23.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb23, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD23.wb_out[102:96],
        `FD23.wb_out[31:0], `FD23.wb_out[63:32], `FD23.wb_out[95:64]);
    end
    if(`FD23.start_wb)begin
      $fdisplay(file_fdb23, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD23.state.name() == "WB_REF")begin
    if(`FD23.wb_valid & `FD23.ready)begin
      $fdisplay(file_fdb23, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD23.wb_out[102:96], `FD23.wb_out[111:109], `FD23.wb_out[108:106],
        `FD23.wb_out[105:103], `FD23.wb_out[31:0], `FD23.wb_out[63:32], `FD23.wb_out[95:64]
      );
    end
    if(`FD23.ready & `FD23.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb23, "\n\nChange ref ID.\n");
    end
  end
end

// cell 24
always @(negedge clk)begin
  if(`FD24.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD24.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb24, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD24.wb_out[102:96],
        `FD24.wb_out[31:0], `FD24.wb_out[63:32], `FD24.wb_out[95:64]);
    end
    if(`FD24.start_wb)begin
      $fdisplay(file_fdb24, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD24.state.name() == "WB_REF")begin
    if(`FD24.wb_valid & `FD24.ready)begin
      $fdisplay(file_fdb24, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD24.wb_out[102:96], `FD24.wb_out[111:109], `FD24.wb_out[108:106],
        `FD24.wb_out[105:103], `FD24.wb_out[31:0], `FD24.wb_out[63:32], `FD24.wb_out[95:64]
      );
    end
    if(`FD24.ready & `FD24.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb24, "\n\nChange ref ID.\n");
    end
  end
end

// cell 25
always @(negedge clk)begin
  if(`FD25.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD25.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb25, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD25.wb_out[102:96],
        `FD25.wb_out[31:0], `FD25.wb_out[63:32], `FD25.wb_out[95:64]);
    end
    if(`FD25.start_wb)begin
      $fdisplay(file_fdb25, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD25.state.name() == "WB_REF")begin
    if(`FD25.wb_valid & `FD25.ready)begin
      $fdisplay(file_fdb25, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD25.wb_out[102:96], `FD25.wb_out[111:109], `FD25.wb_out[108:106],
        `FD25.wb_out[105:103], `FD25.wb_out[31:0], `FD25.wb_out[63:32], `FD25.wb_out[95:64]
      );
    end
    if(`FD25.ready & `FD25.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb25, "\n\nChange ref ID.\n");
    end
  end
end

// cell 26
always @(negedge clk)begin
  if(`FD26.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD26.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb26, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD26.wb_out[102:96],
        `FD26.wb_out[31:0], `FD26.wb_out[63:32], `FD26.wb_out[95:64]);
    end
    if(`FD26.start_wb)begin
      $fdisplay(file_fdb26, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD26.state.name() == "WB_REF")begin
    if(`FD26.wb_valid & `FD26.ready)begin
      $fdisplay(file_fdb26, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD26.wb_out[102:96], `FD26.wb_out[111:109], `FD26.wb_out[108:106],
        `FD26.wb_out[105:103], `FD26.wb_out[31:0], `FD26.wb_out[63:32], `FD26.wb_out[95:64]
      );
    end
    if(`FD26.ready & `FD26.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb26, "\n\nChange ref ID.\n");
    end
  end
end

// cell 28
always @(negedge clk)begin
  if(`FD28.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD28.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb28, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD28.wb_out[102:96],
        `FD28.wb_out[31:0], `FD28.wb_out[63:32], `FD28.wb_out[95:64]);
    end
    if(`FD28.start_wb)begin
      $fdisplay(file_fdb28, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD28.state.name() == "WB_REF")begin
    if(`FD28.wb_valid & `FD28.ready)begin
      $fdisplay(file_fdb28, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD28.wb_out[102:96], `FD28.wb_out[111:109], `FD28.wb_out[108:106],
        `FD28.wb_out[105:103], `FD28.wb_out[31:0], `FD28.wb_out[63:32], `FD28.wb_out[95:64]
      );
    end
    if(`FD28.ready & `FD28.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb28, "\n\nChange ref ID.\n");
    end
  end
end

// cell 29
always @(negedge clk)begin
  if(`FD29.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD29.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb29, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD29.wb_out[102:96],
        `FD29.wb_out[31:0], `FD29.wb_out[63:32], `FD29.wb_out[95:64]);
    end
    if(`FD29.start_wb)begin
      $fdisplay(file_fdb29, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD29.state.name() == "WB_REF")begin
    if(`FD29.wb_valid & `FD29.ready)begin
      $fdisplay(file_fdb29, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD29.wb_out[102:96], `FD29.wb_out[111:109], `FD29.wb_out[108:106],
        `FD29.wb_out[105:103], `FD29.wb_out[31:0], `FD29.wb_out[63:32], `FD29.wb_out[95:64]
      );
    end
    if(`FD29.ready & `FD29.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb29, "\n\nChange ref ID.\n");
    end
  end
end

// cell 30
always @(negedge clk)begin
  if(`FD30.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD30.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb30, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD30.wb_out[102:96],
        `FD30.wb_out[31:0], `FD30.wb_out[63:32], `FD30.wb_out[95:64]);
    end
    if(`FD30.start_wb)begin
      $fdisplay(file_fdb30, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD30.state.name() == "WB_REF")begin
    if(`FD30.wb_valid & `FD30.ready)begin
      $fdisplay(file_fdb30, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD30.wb_out[102:96], `FD30.wb_out[111:109], `FD30.wb_out[108:106],
        `FD30.wb_out[105:103], `FD30.wb_out[31:0], `FD30.wb_out[63:32], `FD30.wb_out[95:64]
      );
    end
    if(`FD30.ready & `FD30.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb30, "\n\nChange ref ID.\n");
    end
  end
end

// cell 31
always @(negedge clk)begin
  if(`FD31.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD31.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb31, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD31.wb_out[102:96],
        `FD31.wb_out[31:0], `FD31.wb_out[63:32], `FD31.wb_out[95:64]);
    end
    if(`FD31.start_wb)begin
      $fdisplay(file_fdb31, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD31.state.name() == "WB_REF")begin
    if(`FD31.wb_valid & `FD31.ready)begin
      $fdisplay(file_fdb31, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD31.wb_out[102:96], `FD31.wb_out[111:109], `FD31.wb_out[108:106],
        `FD31.wb_out[105:103], `FD31.wb_out[31:0], `FD31.wb_out[63:32], `FD31.wb_out[95:64]
      );
    end
    if(`FD31.ready & `FD31.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb31, "\n\nChange ref ID.\n");
    end
  end
end

// cell 32
always @(negedge clk)begin
  if(`FD32.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD32.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb32, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD32.wb_out[102:96],
        `FD32.wb_out[31:0], `FD32.wb_out[63:32], `FD32.wb_out[95:64]);
    end
    if(`FD32.start_wb)begin
      $fdisplay(file_fdb32, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD32.state.name() == "WB_REF")begin
    if(`FD32.wb_valid & `FD32.ready)begin
      $fdisplay(file_fdb32, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD32.wb_out[102:96], `FD32.wb_out[111:109], `FD32.wb_out[108:106],
        `FD32.wb_out[105:103], `FD32.wb_out[31:0], `FD32.wb_out[63:32], `FD32.wb_out[95:64]
      );
    end
    if(`FD32.ready & `FD32.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb32, "\n\nChange ref ID.\n");
    end
  end
end

// cell 33
always @(negedge clk)begin
  if(`FD33.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD33.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb33, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD33.wb_out[102:96],
        `FD33.wb_out[31:0], `FD33.wb_out[63:32], `FD33.wb_out[95:64]);
    end
    if(`FD33.start_wb)begin
      $fdisplay(file_fdb33, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD33.state.name() == "WB_REF")begin
    if(`FD33.wb_valid & `FD33.ready)begin
      $fdisplay(file_fdb33, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD33.wb_out[102:96], `FD33.wb_out[111:109], `FD33.wb_out[108:106],
        `FD33.wb_out[105:103], `FD33.wb_out[31:0], `FD33.wb_out[63:32], `FD33.wb_out[95:64]
      );
    end
    if(`FD33.ready & `FD33.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb33, "\n\nChange ref ID.\n");
    end
  end
end

// cell 34
always @(negedge clk)begin
  if(`FD34.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD34.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb34, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD34.wb_out[102:96],
        `FD34.wb_out[31:0], `FD34.wb_out[63:32], `FD34.wb_out[95:64]);
    end
    if(`FD34.start_wb)begin
      $fdisplay(file_fdb34, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD34.state.name() == "WB_REF")begin
    if(`FD34.wb_valid & `FD34.ready)begin
      $fdisplay(file_fdb34, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD34.wb_out[102:96], `FD34.wb_out[111:109], `FD34.wb_out[108:106],
        `FD34.wb_out[105:103], `FD34.wb_out[31:0], `FD34.wb_out[63:32], `FD34.wb_out[95:64]
      );
    end
    if(`FD34.ready & `FD34.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb34, "\n\nChange ref ID.\n");
    end
  end
end

// cell 35
always @(negedge clk)begin
  if(`FD35.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD35.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb35, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD35.wb_out[102:96],
        `FD35.wb_out[31:0], `FD35.wb_out[63:32], `FD35.wb_out[95:64]);
    end
    if(`FD35.start_wb)begin
      $fdisplay(file_fdb35, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD35.state.name() == "WB_REF")begin
    if(`FD35.wb_valid & `FD35.ready)begin
      $fdisplay(file_fdb35, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD35.wb_out[102:96], `FD35.wb_out[111:109], `FD35.wb_out[108:106],
        `FD35.wb_out[105:103], `FD35.wb_out[31:0], `FD35.wb_out[63:32], `FD35.wb_out[95:64]
      );
    end
    if(`FD35.ready & `FD35.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb35, "\n\nChange ref ID.\n");
    end
  end
end

// cell 36
always @(negedge clk)begin
  if(`FD36.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD36.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb36, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD36.wb_out[102:96],
        `FD36.wb_out[31:0], `FD36.wb_out[63:32], `FD36.wb_out[95:64]);
    end
    if(`FD36.start_wb)begin
      $fdisplay(file_fdb36, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD36.state.name() == "WB_REF")begin
    if(`FD36.wb_valid & `FD36.ready)begin
      $fdisplay(file_fdb36, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD36.wb_out[102:96], `FD36.wb_out[111:109], `FD36.wb_out[108:106],
        `FD36.wb_out[105:103], `FD36.wb_out[31:0], `FD36.wb_out[63:32], `FD36.wb_out[95:64]
      );
    end
    if(`FD36.ready & `FD36.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb36, "\n\nChange ref ID.\n");
    end
  end
end

// cell 37
always @(negedge clk)begin
  if(`FD37.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD37.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb37, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD37.wb_out[102:96],
        `FD37.wb_out[31:0], `FD37.wb_out[63:32], `FD37.wb_out[95:64]);
    end
    if(`FD37.start_wb)begin
      $fdisplay(file_fdb37, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD37.state.name() == "WB_REF")begin
    if(`FD37.wb_valid & `FD37.ready)begin
      $fdisplay(file_fdb37, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD37.wb_out[102:96], `FD37.wb_out[111:109], `FD37.wb_out[108:106],
        `FD37.wb_out[105:103], `FD37.wb_out[31:0], `FD37.wb_out[63:32], `FD37.wb_out[95:64]
      );
    end
    if(`FD37.ready & `FD37.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb37, "\n\nChange ref ID.\n");
    end
  end
end

// cell 38
always @(negedge clk)begin
  if(`FD38.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD38.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb38, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD38.wb_out[102:96],
        `FD38.wb_out[31:0], `FD38.wb_out[63:32], `FD38.wb_out[95:64]);
    end
    if(`FD38.start_wb)begin
      $fdisplay(file_fdb38, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD38.state.name() == "WB_REF")begin
    if(`FD38.wb_valid & `FD38.ready)begin
      $fdisplay(file_fdb38, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD38.wb_out[102:96], `FD38.wb_out[111:109], `FD38.wb_out[108:106],
        `FD38.wb_out[105:103], `FD38.wb_out[31:0], `FD38.wb_out[63:32], `FD38.wb_out[95:64]
      );
    end
    if(`FD38.ready & `FD38.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb38, "\n\nChange ref ID.\n");
    end
  end
end

// cell 39
always @(negedge clk)begin
  if(`FD39.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD39.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb39, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD39.wb_out[102:96],
        `FD39.wb_out[31:0], `FD39.wb_out[63:32], `FD39.wb_out[95:64]);
    end
    if(`FD39.start_wb)begin
      $fdisplay(file_fdb39, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD39.state.name() == "WB_REF")begin
    if(`FD39.wb_valid & `FD39.ready)begin
      $fdisplay(file_fdb39, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD39.wb_out[102:96], `FD39.wb_out[111:109], `FD39.wb_out[108:106],
        `FD39.wb_out[105:103], `FD39.wb_out[31:0], `FD39.wb_out[63:32], `FD39.wb_out[95:64]
      );
    end
    if(`FD39.ready & `FD39.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb39, "\n\nChange ref ID.\n");
    end
  end
end

// cell 40
always @(negedge clk)begin
  if(`FD40.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD40.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb40, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD40.wb_out[102:96],
        `FD40.wb_out[31:0], `FD40.wb_out[63:32], `FD40.wb_out[95:64]);
    end
    if(`FD40.start_wb)begin
      $fdisplay(file_fdb40, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD40.state.name() == "WB_REF")begin
    if(`FD40.wb_valid & `FD40.ready)begin
      $fdisplay(file_fdb40, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD40.wb_out[102:96], `FD40.wb_out[111:109], `FD40.wb_out[108:106],
        `FD40.wb_out[105:103], `FD40.wb_out[31:0], `FD40.wb_out[63:32], `FD40.wb_out[95:64]
      );
    end
    if(`FD40.ready & `FD40.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb40, "\n\nChange ref ID.\n");
    end
  end
end

// cell 41
always @(negedge clk)begin
  if(`FD41.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD41.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb41, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD41.wb_out[102:96],
        `FD41.wb_out[31:0], `FD41.wb_out[63:32], `FD41.wb_out[95:64]);
    end
    if(`FD41.start_wb)begin
      $fdisplay(file_fdb41, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD41.state.name() == "WB_REF")begin
    if(`FD41.wb_valid & `FD41.ready)begin
      $fdisplay(file_fdb41, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD41.wb_out[102:96], `FD41.wb_out[111:109], `FD41.wb_out[108:106],
        `FD41.wb_out[105:103], `FD41.wb_out[31:0], `FD41.wb_out[63:32], `FD41.wb_out[95:64]
      );
    end
    if(`FD41.ready & `FD41.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb41, "\n\nChange ref ID.\n");
    end
  end
end

// cell 43
always @(negedge clk)begin
  if(`FD43.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD43.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb43, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD43.wb_out[102:96],
        `FD43.wb_out[31:0], `FD43.wb_out[63:32], `FD43.wb_out[95:64]);
    end
    if(`FD43.start_wb)begin
      $fdisplay(file_fdb43, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD43.state.name() == "WB_REF")begin
    if(`FD43.wb_valid & `FD43.ready)begin
      $fdisplay(file_fdb43, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD43.wb_out[102:96], `FD43.wb_out[111:109], `FD43.wb_out[108:106],
        `FD43.wb_out[105:103], `FD43.wb_out[31:0], `FD43.wb_out[63:32], `FD43.wb_out[95:64]
      );
    end
    if(`FD43.ready & `FD43.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb43, "\n\nChange ref ID.\n");
    end
  end
end

// cell 44
always @(negedge clk)begin
  if(`FD44.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD44.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb44, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD44.wb_out[102:96],
        `FD44.wb_out[31:0], `FD44.wb_out[63:32], `FD44.wb_out[95:64]);
    end
    if(`FD44.start_wb)begin
      $fdisplay(file_fdb44, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD44.state.name() == "WB_REF")begin
    if(`FD44.wb_valid & `FD44.ready)begin
      $fdisplay(file_fdb44, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD44.wb_out[102:96], `FD44.wb_out[111:109], `FD44.wb_out[108:106],
        `FD44.wb_out[105:103], `FD44.wb_out[31:0], `FD44.wb_out[63:32], `FD44.wb_out[95:64]
      );
    end
    if(`FD44.ready & `FD44.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb44, "\n\nChange ref ID.\n");
    end
  end
end

// cell 45
always @(negedge clk)begin
  if(`FD45.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD45.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb45, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD45.wb_out[102:96],
        `FD45.wb_out[31:0], `FD45.wb_out[63:32], `FD45.wb_out[95:64]);
    end
    if(`FD45.start_wb)begin
      $fdisplay(file_fdb45, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD45.state.name() == "WB_REF")begin
    if(`FD45.wb_valid & `FD45.ready)begin
      $fdisplay(file_fdb45, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD45.wb_out[102:96], `FD45.wb_out[111:109], `FD45.wb_out[108:106],
        `FD45.wb_out[105:103], `FD45.wb_out[31:0], `FD45.wb_out[63:32], `FD45.wb_out[95:64]
      );
    end
    if(`FD45.ready & `FD45.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb45, "\n\nChange ref ID.\n");
    end
  end
end

// cell 46
always @(negedge clk)begin
  if(`FD46.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD46.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb46, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD46.wb_out[102:96],
        `FD46.wb_out[31:0], `FD46.wb_out[63:32], `FD46.wb_out[95:64]);
    end
    if(`FD46.start_wb)begin
      $fdisplay(file_fdb46, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD46.state.name() == "WB_REF")begin
    if(`FD46.wb_valid & `FD46.ready)begin
      $fdisplay(file_fdb46, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD46.wb_out[102:96], `FD46.wb_out[111:109], `FD46.wb_out[108:106],
        `FD46.wb_out[105:103], `FD46.wb_out[31:0], `FD46.wb_out[63:32], `FD46.wb_out[95:64]
      );
    end
    if(`FD46.ready & `FD46.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb46, "\n\nChange ref ID.\n");
    end
  end
end

// cell 47
always @(negedge clk)begin
  if(`FD47.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD47.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb47, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD47.wb_out[102:96],
        `FD47.wb_out[31:0], `FD47.wb_out[63:32], `FD47.wb_out[95:64]);
    end
    if(`FD47.start_wb)begin
      $fdisplay(file_fdb47, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD47.state.name() == "WB_REF")begin
    if(`FD47.wb_valid & `FD47.ready)begin
      $fdisplay(file_fdb47, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD47.wb_out[102:96], `FD47.wb_out[111:109], `FD47.wb_out[108:106],
        `FD47.wb_out[105:103], `FD47.wb_out[31:0], `FD47.wb_out[63:32], `FD47.wb_out[95:64]
      );
    end
    if(`FD47.ready & `FD47.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb47, "\n\nChange ref ID.\n");
    end
  end
end

// cell 48
always @(negedge clk)begin
  if(`FD48.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD48.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb48, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD48.wb_out[102:96],
        `FD48.wb_out[31:0], `FD48.wb_out[63:32], `FD48.wb_out[95:64]);
    end
    if(`FD48.start_wb)begin
      $fdisplay(file_fdb48, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD48.state.name() == "WB_REF")begin
    if(`FD48.wb_valid & `FD48.ready)begin
      $fdisplay(file_fdb48, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD48.wb_out[102:96], `FD48.wb_out[111:109], `FD48.wb_out[108:106],
        `FD48.wb_out[105:103], `FD48.wb_out[31:0], `FD48.wb_out[63:32], `FD48.wb_out[95:64]
      );
    end
    if(`FD48.ready & `FD48.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb48, "\n\nChange ref ID.\n");
    end
  end
end

// cell 49
always @(negedge clk)begin
  if(`FD49.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD49.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb49, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD49.wb_out[102:96],
        `FD49.wb_out[31:0], `FD49.wb_out[63:32], `FD49.wb_out[95:64]);
    end
    if(`FD49.start_wb)begin
      $fdisplay(file_fdb49, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD49.state.name() == "WB_REF")begin
    if(`FD49.wb_valid & `FD49.ready)begin
      $fdisplay(file_fdb49, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD49.wb_out[102:96], `FD49.wb_out[111:109], `FD49.wb_out[108:106],
        `FD49.wb_out[105:103], `FD49.wb_out[31:0], `FD49.wb_out[63:32], `FD49.wb_out[95:64]
      );
    end
    if(`FD49.ready & `FD49.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb49, "\n\nChange ref ID.\n");
    end
  end
end

// cell 50
always @(negedge clk)begin
  if(`FD50.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD50.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb50, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD50.wb_out[102:96],
        `FD50.wb_out[31:0], `FD50.wb_out[63:32], `FD50.wb_out[95:64]);
    end
    if(`FD50.start_wb)begin
      $fdisplay(file_fdb50, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD50.state.name() == "WB_REF")begin
    if(`FD50.wb_valid & `FD50.ready)begin
      $fdisplay(file_fdb50, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD50.wb_out[102:96], `FD50.wb_out[111:109], `FD50.wb_out[108:106],
        `FD50.wb_out[105:103], `FD50.wb_out[31:0], `FD50.wb_out[63:32], `FD50.wb_out[95:64]
      );
    end
    if(`FD50.ready & `FD50.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb50, "\n\nChange ref ID.\n");
    end
  end
end

// cell 51
always @(negedge clk)begin
  if(`FD51.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD51.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb51, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD51.wb_out[102:96],
        `FD51.wb_out[31:0], `FD51.wb_out[63:32], `FD51.wb_out[95:64]);
    end
    if(`FD51.start_wb)begin
      $fdisplay(file_fdb51, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD51.state.name() == "WB_REF")begin
    if(`FD51.wb_valid & `FD51.ready)begin
      $fdisplay(file_fdb51, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD51.wb_out[102:96], `FD51.wb_out[111:109], `FD51.wb_out[108:106],
        `FD51.wb_out[105:103], `FD51.wb_out[31:0], `FD51.wb_out[63:32], `FD51.wb_out[95:64]
      );
    end
    if(`FD51.ready & `FD51.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb51, "\n\nChange ref ID.\n");
    end
  end
end

// cell 52
always @(negedge clk)begin
  if(`FD52.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD52.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb52, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD52.wb_out[102:96],
        `FD52.wb_out[31:0], `FD52.wb_out[63:32], `FD52.wb_out[95:64]);
    end
    if(`FD52.start_wb)begin
      $fdisplay(file_fdb52, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD52.state.name() == "WB_REF")begin
    if(`FD52.wb_valid & `FD52.ready)begin
      $fdisplay(file_fdb52, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD52.wb_out[102:96], `FD52.wb_out[111:109], `FD52.wb_out[108:106],
        `FD52.wb_out[105:103], `FD52.wb_out[31:0], `FD52.wb_out[63:32], `FD52.wb_out[95:64]
      );
    end
    if(`FD52.ready & `FD52.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb52, "\n\nChange ref ID.\n");
    end
  end
end

// cell 53
always @(negedge clk)begin
  if(`FD53.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD53.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb53, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD53.wb_out[102:96],
        `FD53.wb_out[31:0], `FD53.wb_out[63:32], `FD53.wb_out[95:64]);
    end
    if(`FD53.start_wb)begin
      $fdisplay(file_fdb53, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD53.state.name() == "WB_REF")begin
    if(`FD53.wb_valid & `FD53.ready)begin
      $fdisplay(file_fdb53, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD53.wb_out[102:96], `FD53.wb_out[111:109], `FD53.wb_out[108:106],
        `FD53.wb_out[105:103], `FD53.wb_out[31:0], `FD53.wb_out[63:32], `FD53.wb_out[95:64]
      );
    end
    if(`FD53.ready & `FD53.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb53, "\n\nChange ref ID.\n");
    end
  end
end

// cell 54
always @(negedge clk)begin
  if(`FD54.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD54.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb54, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD54.wb_out[102:96],
        `FD54.wb_out[31:0], `FD54.wb_out[63:32], `FD54.wb_out[95:64]);
    end
    if(`FD54.start_wb)begin
      $fdisplay(file_fdb54, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD54.state.name() == "WB_REF")begin
    if(`FD54.wb_valid & `FD54.ready)begin
      $fdisplay(file_fdb54, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD54.wb_out[102:96], `FD54.wb_out[111:109], `FD54.wb_out[108:106],
        `FD54.wb_out[105:103], `FD54.wb_out[31:0], `FD54.wb_out[63:32], `FD54.wb_out[95:64]
      );
    end
    if(`FD54.ready & `FD54.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb54, "\n\nChange ref ID.\n");
    end
  end
end

// cell 55
always @(negedge clk)begin
  if(`FD55.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD55.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb55, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD55.wb_out[102:96],
        `FD55.wb_out[31:0], `FD55.wb_out[63:32], `FD55.wb_out[95:64]);
    end
    if(`FD55.start_wb)begin
      $fdisplay(file_fdb55, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD55.state.name() == "WB_REF")begin
    if(`FD55.wb_valid & `FD55.ready)begin
      $fdisplay(file_fdb55, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD55.wb_out[102:96], `FD55.wb_out[111:109], `FD55.wb_out[108:106],
        `FD55.wb_out[105:103], `FD55.wb_out[31:0], `FD55.wb_out[63:32], `FD55.wb_out[95:64]
      );
    end
    if(`FD55.ready & `FD55.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb55, "\n\nChange ref ID.\n");
    end
  end
end

// cell 56
always @(negedge clk)begin
  if(`FD56.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD56.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb56, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD56.wb_out[102:96],
        `FD56.wb_out[31:0], `FD56.wb_out[63:32], `FD56.wb_out[95:64]);
    end
    if(`FD56.start_wb)begin
      $fdisplay(file_fdb56, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD56.state.name() == "WB_REF")begin
    if(`FD56.wb_valid & `FD56.ready)begin
      $fdisplay(file_fdb56, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD56.wb_out[102:96], `FD56.wb_out[111:109], `FD56.wb_out[108:106],
        `FD56.wb_out[105:103], `FD56.wb_out[31:0], `FD56.wb_out[63:32], `FD56.wb_out[95:64]
      );
    end
    if(`FD56.ready & `FD56.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb56, "\n\nChange ref ID.\n");
    end
  end
end

// cell 57
always @(negedge clk)begin
  if(`FD57.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD57.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb57, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD57.wb_out[102:96],
        `FD57.wb_out[31:0], `FD57.wb_out[63:32], `FD57.wb_out[95:64]);
    end
    if(`FD57.start_wb)begin
      $fdisplay(file_fdb57, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD57.state.name() == "WB_REF")begin
    if(`FD57.wb_valid & `FD57.ready)begin
      $fdisplay(file_fdb57, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD57.wb_out[102:96], `FD57.wb_out[111:109], `FD57.wb_out[108:106],
        `FD57.wb_out[105:103], `FD57.wb_out[31:0], `FD57.wb_out[63:32], `FD57.wb_out[95:64]
      );
    end
    if(`FD57.ready & `FD57.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb57, "\n\nChange ref ID.\n");
    end
  end
end

// cell 58
always @(negedge clk)begin
  if(`FD58.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD58.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb58, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD58.wb_out[102:96],
        `FD58.wb_out[31:0], `FD58.wb_out[63:32], `FD58.wb_out[95:64]);
    end
    if(`FD58.start_wb)begin
      $fdisplay(file_fdb58, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD58.state.name() == "WB_REF")begin
    if(`FD58.wb_valid & `FD58.ready)begin
      $fdisplay(file_fdb58, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD58.wb_out[102:96], `FD58.wb_out[111:109], `FD58.wb_out[108:106],
        `FD58.wb_out[105:103], `FD58.wb_out[31:0], `FD58.wb_out[63:32], `FD58.wb_out[95:64]
      );
    end
    if(`FD58.ready & `FD58.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb58, "\n\nChange ref ID.\n");
    end
  end
end

// cell 59
always @(negedge clk)begin
  if(`FD59.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD59.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb59, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD59.wb_out[102:96],
        `FD59.wb_out[31:0], `FD59.wb_out[63:32], `FD59.wb_out[95:64]);
    end
    if(`FD59.start_wb)begin
      $fdisplay(file_fdb59, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD59.state.name() == "WB_REF")begin
    if(`FD59.wb_valid & `FD59.ready)begin
      $fdisplay(file_fdb59, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD59.wb_out[102:96], `FD59.wb_out[111:109], `FD59.wb_out[108:106],
        `FD59.wb_out[105:103], `FD59.wb_out[31:0], `FD59.wb_out[63:32], `FD59.wb_out[95:64]
      );
    end
    if(`FD59.ready & `FD59.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb59, "\n\nChange ref ID.\n");
    end
  end
end

// cell 60
always @(negedge clk)begin
  if(`FD60.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD60.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb60, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD60.wb_out[102:96],
        `FD60.wb_out[31:0], `FD60.wb_out[63:32], `FD60.wb_out[95:64]);
    end
    if(`FD60.start_wb)begin
      $fdisplay(file_fdb60, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD60.state.name() == "WB_REF")begin
    if(`FD60.wb_valid & `FD60.ready)begin
      $fdisplay(file_fdb60, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD60.wb_out[102:96], `FD60.wb_out[111:109], `FD60.wb_out[108:106],
        `FD60.wb_out[105:103], `FD60.wb_out[31:0], `FD60.wb_out[63:32], `FD60.wb_out[95:64]
      );
    end
    if(`FD60.ready & `FD60.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb60, "\n\nChange ref ID.\n");
    end
  end
end

// cell 62
always @(negedge clk)begin
  if(`FD62.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD62.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb62, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD62.wb_out[102:96],
        `FD62.wb_out[31:0], `FD62.wb_out[63:32], `FD62.wb_out[95:64]);
    end
    if(`FD62.start_wb)begin
      $fdisplay(file_fdb62, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD62.state.name() == "WB_REF")begin
    if(`FD62.wb_valid & `FD62.ready)begin
      $fdisplay(file_fdb62, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD62.wb_out[102:96], `FD62.wb_out[111:109], `FD62.wb_out[108:106],
        `FD62.wb_out[105:103], `FD62.wb_out[31:0], `FD62.wb_out[63:32], `FD62.wb_out[95:64]
      );
    end
    if(`FD62.ready & `FD62.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb62, "\n\nChange ref ID.\n");
    end
  end
end

// cell 63
always @(negedge clk)begin
  if(`FD63.state.name() == "ACTIVE")begin // ACTIVE state
    if(`FD63.wb_valid)begin // writeback to home force cache
      $fdisplay(file_fdb63, "nbPID=%0d\t\t%x\t\t%x\t\t%x", `FD63.wb_out[102:96],
        `FD63.wb_out[31:0], `FD63.wb_out[63:32], `FD63.wb_out[95:64]);
    end
    if(`FD63.start_wb)begin
      $fdisplay(file_fdb63, "\nStart writing back forces ref particles.\n");
    end
  end
  else if(`FD63.state.name() == "WB_REF")begin
    if(`FD63.wb_valid & `FD63.ready)begin
      $fdisplay(file_fdb63, "refPID=%0d\t%0d\t%0d\t%0d\t\t%x\t%x\t%x",
        `FD63.wb_out[102:96], `FD63.wb_out[111:109], `FD63.wb_out[108:106],
        `FD63.wb_out[105:103], `FD63.wb_out[31:0], `FD63.wb_out[63:32], `FD63.wb_out[95:64]
      );
    end
    if(`FD63.ready & `FD63.counter == 13)begin // end of one ref ID
      $fdisplay(file_fdb63, "\n\nChange ref ID.\n");
    end
  end
end


// End simulation when motion update is done.
initial begin
  wait(`MUC.out_motion_update_done);
  #10;
  $display("Ending simulation.");
  // cell 0
  $fclose(file00);
  $fclose(file01);
  $fclose(file02);
  $fclose(file03);
  $fclose(file04);
  $fclose(file05);
  $fclose(file06);
  $fclose(file07);
  $fclose(file08);
  $fclose(file09);
  $fclose(file010);
  $fclose(file011);
  $fclose(file012);
  $fclose(file013);
  $fclose(file_fdb0);
  $fclose(file_fci0);
  $fclose(file_fco0);
  $fclose(file_mu_pos0);
  $fclose(file_mu_vel0);
  // cell 61
  $fclose(file610);
  $fclose(file611);
  $fclose(file612);
  $fclose(file613);
  $fclose(file614);
  $fclose(file615);
  $fclose(file616);
  $fclose(file617);
  $fclose(file618);
  $fclose(file619);
  $fclose(file6110);
  $fclose(file6111);
  $fclose(file6112);
  $fclose(file6113);
  $fclose(file_fdb61);
  $fclose(file_fci61);
  $fclose(file_fco61);
  $fclose(file_mu_pos61);
  $fclose(file_mu_vel61);
  // cell 27
  $fclose(file270);
  $fclose(file271);
  $fclose(file272);
  $fclose(file273);
  $fclose(file274);
  $fclose(file275);
  $fclose(file276);
  $fclose(file277);
  $fclose(file278);
  $fclose(file279);
  $fclose(file2710);
  $fclose(file2711);
  $fclose(file2712);
  $fclose(file2713);
  $fclose(file_fdb27);
  $fclose(file_fci27);
  $fclose(file_fco27);
  $fclose(file_mu_pos27);
  $fclose(file_mu_vel27);
  // cell 42
  $fclose(file420);
  $fclose(file421);
  $fclose(file422);
  $fclose(file423);
  $fclose(file424);
  $fclose(file425);
  $fclose(file426);
  $fclose(file427);
  $fclose(file428);
  $fclose(file429);
  $fclose(file4210);
  $fclose(file4211);
  $fclose(file4212);
  $fclose(file4213);
  $fclose(file_fdb42);
  $fclose(file_fci42);
  $fclose(file_fco42);
  $fclose(file_mu_pos42);
  $fclose(file_mu_vel42);
  // other cells
  $fclose(file_fdb1);
  $fclose(file_fdb2);
  $fclose(file_fdb3);
  $fclose(file_fdb4);
  $fclose(file_fdb5);
  $fclose(file_fdb6);
  $fclose(file_fdb7);
  $fclose(file_fdb8);
  $fclose(file_fdb9);
  $fclose(file_fdb10);
  $fclose(file_fdb11);
  $fclose(file_fdb12);
  $fclose(file_fdb13);
  $fclose(file_fdb14);
  $fclose(file_fdb15);
  $fclose(file_fdb16);
  $fclose(file_fdb17);
  $fclose(file_fdb18);
  $fclose(file_fdb19);
  $fclose(file_fdb20);
  $fclose(file_fdb21);
  $fclose(file_fdb22);
  $fclose(file_fdb23);
  $fclose(file_fdb24);
  $fclose(file_fdb25);
  $fclose(file_fdb26);
  $fclose(file_fdb28);
  $fclose(file_fdb29);
  $fclose(file_fdb30);
  $fclose(file_fdb31);
  $fclose(file_fdb32);
  $fclose(file_fdb33);
  $fclose(file_fdb34);
  $fclose(file_fdb35);
  $fclose(file_fdb36);
  $fclose(file_fdb37);
  $fclose(file_fdb38);
  $fclose(file_fdb39);
  $fclose(file_fdb40);
  $fclose(file_fdb41);
  $fclose(file_fdb43);
  $fclose(file_fdb44);
  $fclose(file_fdb45);
  $fclose(file_fdb46);
  $fclose(file_fdb47);
  $fclose(file_fdb48);
  $fclose(file_fdb49);
  $fclose(file_fdb50);
  $fclose(file_fdb51);
  $fclose(file_fdb52);
  $fclose(file_fdb53);
  $fclose(file_fdb54);
  $fclose(file_fdb55);
  $fclose(file_fdb56);
  $fclose(file_fdb57);
  $fclose(file_fdb58);
  $fclose(file_fdb59);
  $fclose(file_fdb60);
  $fclose(file_fdb62);
  $fclose(file_fdb63);
  $stop();
end

`endif



RL_top
#(
	.NUM_CELLS(NUM_CELLS),
	.NUM_PARTICLE_PER_CELL(NUM_PARTICLE_PER_CELL),
	.OFFSET_WIDTH(OFFSET_WIDTH),
	.DATA_WIDTH(DATA_WIDTH),
	.CELL_ID_WIDTH(CELL_ID_WIDTH),
	.DECIMAL_ADDR_WIDTH(DECIMAL_ADDR_WIDTH),
	.PARTICLE_ID_WIDTH(PARTICLE_ID_WIDTH),
	.X_DIM(X_DIM),
	.Y_DIM(Y_DIM),
	.Z_DIM(Z_DIM),
	.BODY_BITS(BODY_BITS),
	.ID_WIDTH(ID_WIDTH),
	.FULL_CELL_ID_WIDTH(FULL_CELL_ID_WIDTH),
	.FILTER_BUFFER_DATA_WIDTH(FILTER_BUFFER_DATA_WIDTH),
	.FORCE_BUFFER_WIDTH(FORCE_BUFFER_WIDTH),
	.FORCE_DATA_WIDTH(FORCE_DATA_WIDTH),
	.FORCE_CACHE_WIDTH(FORCE_CACHE_WIDTH),
	.POS_CACHE_WIDTH(POS_CACHE_WIDTH),
	.VELOCITY_CACHE_WIDTH(VELOCITY_CACHE_WIDTH),
	.NUM_FILTER(NUM_FILTER),
	.ARBITER_MSB(ARBITER_MSB),
	.NUM_NEIGHBOR_CELLS(NUM_NEIGHBOR_CELLS),
	.ALL_POSITION_WIDTH(ALL_POSITION_WIDTH)
)
RL_top
(
	.clk(clk),
	.rst(rst),
	.start(start),
	
	.reading_done(reading_done),
	.back_pressure(back_pressure),
	.filter_buffer_empty(filter_buffer_empty),
	.force_valid(force_valid),
	.force_valid_and(force_valid_and)
);

endmodule
