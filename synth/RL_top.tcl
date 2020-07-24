# Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, the Altera Quartus II License Agreement,
# the Altera MegaCore Function License Agreement, or other 
# applicable license agreement, including, without limitation, 
# that your use is for the sole purpose of programming logic 
# devices manufactured by Altera and sold by Altera or its 
# authorized distributors.  Please refer to the applicable 
# agreement for further details.

# Quartus II: Generate Tcl File for Project
# File: many_poor_processor_DE5_net.tcl
# Generated on: Sat Jan 25 19:31:38 2020

# Load Quartus II Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "RL_top"]} {
		puts "Project RL_top is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists RL_top]} {
		project_open -revision RL_top RL_top
	} else {
		project_new -revision RL_top RL_top
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "Stratix 10"
	set_global_assignment -name DEVICE 1SX280HN2F43E2VG
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 256
	set_global_assignment -name EDA_SIMULATION_TOOL "ModelSim-Altera (Verilog)"
  set_global_assignment -name EDA_OUTPUT_DATA_FORMAT "VERILOG HDL" -section_id eda_simulation
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 100
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top

  # Source Files
set_global_assignment -name SYSTEMVERILOG_FILE ../new_MD_core/md_pkg.sv
set_global_assignment -name SYSTEMVERILOG_FILE ../new_MD_core/RL_top.sv
set_global_assignment -name SYSTEMVERILOG_FILE ../new_MD_core/broadcast_controller.sv
set_global_assignment -name SYSTEMVERILOG_FILE ../new_MD_core/position_cache_to_PE_mapping_half_shell.sv
set_global_assignment -name SYSTEMVERILOG_FILE ../new_MD_core/destination_id_map.sv
set_global_assignment -name SYSTEMVERILOG_FILE ../new_MD_core/ring.sv
set_global_assignment -name SYSTEMVERILOG_FILE ../new_MD_core/all_position_caches.sv
set_global_assignment -name SYSTEMVERILOG_FILE ../new_MD_core/cell_to_dest_id_map.sv
set_global_assignment -name SYSTEMVERILOG_FILE ../new_MD_core/PE_wrapper.sv
set_global_assignment -name SYSTEMVERILOG_FILE ../new_MD_core/pos_data_preprocessor.sv
set_global_assignment -name SYSTEMVERILOG_FILE ../new_MD_core/ring_node.sv
set_global_assignment -name SYSTEMVERILOG_FILE ../new_MD_core/pos_data_preprocessor.sv
set_global_assignment -name SYSTEMVERILOG_FILE ../new_MD_core/RL_LJ_Evaluation_Unit.sv
set_global_assignment -name SYSTEMVERILOG_FILE ../new_MD_core/RL_Force_Evaluation_Unit.sv
set_global_assignment -name SYSTEMVERILOG_FILE ../new_MD_core/filter_bank.sv
set_global_assignment -name SYSTEMVERILOG_FILE ../new_MD_core/force_distributor.sv
set_global_assignment -name SYSTEMVERILOG_FILE ../new_MD_core/ref_data_extractor.sv
set_global_assignment -name VERILOG_FILE ../new_MD_core/all_force_caches.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/Pos_Cache_x_y_z.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/cell_x_y_z.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/cell_empty.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/all_velocity_caches.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/motion_update_control
set_global_assignment -name VERILOG_FILE ../new_MD_core/motion_update
set_global_assignment -name VERILOG_FILE ../new_MD_core/float2fixed
set_global_assignment -name VERILOG_FILE ../new_MD_core/FP_MUL_ADD
set_global_assignment -name VERILOG_FILE ../new_MD_core/FP_MUL
set_global_assignment -name VERILOG_FILE ../new_MD_core/check_broadcast_done
set_global_assignment -name VERILOG_FILE ../new_MD_core/force_wb_controller
set_global_assignment -name VERILOG_FILE ../new_MD_core/FP_ADD
set_global_assignment -name VERILOG_FILE ../new_MD_core/force_cache
set_global_assignment -name VERILOG_FILE ../new_MD_core/force_cache_input_buffer
set_global_assignment -name VERILOG_FILE ../new_MD_core/pos_data_distributor_simplified
set_global_assignment -name VERILOG_FILE ../new_MD_core/filter_logic
set_global_assignment -name VERILOG_FILE ../new_MD_core/planar_filter_normalized
set_global_assignment -name VERILOG_FILE ../new_MD_core/filter_buffer
set_global_assignment -name VERILOG_FILE ../new_MD_core/filter_arbiter
set_global_assignment -name VERILOG_FILE ../new_MD_core/fixed2float
set_global_assignment -name VERILOG_FILE ../new_MD_core/r2_compute
set_global_assignment -name VERILOG_FILE ../new_MD_core/FP_SUB
set_global_assignment -name VERILOG_FILE ../new_MD_core/RL_LJ_Evaluate_Pairs_1st_Order_normalized
set_global_assignment -name VERILOG_FILE ../new_MD_core/lut0_14
set_global_assignment -name VERILOG_FILE ../new_MD_core/lut1_14
set_global_assignment -name VERILOG_FILE ../new_MD_core/lut0_8
set_global_assignment -name VERILOG_FILE ../new_MD_core/lut1_8
set_global_assignment -name VERILOG_FILE ../new_MD_core/pos_data_valid_checker
set_global_assignment -name VERILOG_FILE ../new_MD_core/Partial_Force_Acc
set_global_assignment -name VERILOG_FILE ../new_MD_core/FP_ACC
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_1_1_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_1_1_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_1_1_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_1_1_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_1_1_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_1_1_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_1_1_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_1_1_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_1_2_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_1_2_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_1_2_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_1_2_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_1_2_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_1_2_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_1_2_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_1_2_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_1_3_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_1_3_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_1_3_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_1_3_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_1_3_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_1_3_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_1_3_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_1_3_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_1_4_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_1_4_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_1_4_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_1_4_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_1_4_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_1_4_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_1_4_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_1_4_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_2_1_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_2_1_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_2_1_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_2_1_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_2_1_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_2_1_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_2_1_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_2_1_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_2_2_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_2_2_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_2_2_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_2_2_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_2_2_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_2_2_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_2_2_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_2_2_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_2_3_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_2_3_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_2_3_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_2_3_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_2_3_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_2_3_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_2_3_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_2_3_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_2_4_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_2_4_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_2_4_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_2_4_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_2_4_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_2_4_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_2_4_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_2_4_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_3_1_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_3_1_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_3_1_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_3_1_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_3_1_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_3_1_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_3_1_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_3_1_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_3_2_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_3_2_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_3_2_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_3_2_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_3_2_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_3_2_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_3_2_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_3_2_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_3_3_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_3_3_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_3_3_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_3_3_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_3_3_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_3_3_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_3_3_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_3_3_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_3_4_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_3_4_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_3_4_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_3_4_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_3_4_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_3_4_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_3_4_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_3_4_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_4_1_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_4_1_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_4_1_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_4_1_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_4_1_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_4_1_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_4_1_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_4_1_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_4_2_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_4_2_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_4_2_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_4_2_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_4_2_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_4_2_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_4_2_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_4_2_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_4_3_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_4_3_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_4_3_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_4_3_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_4_3_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_4_3_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_4_3_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_4_3_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_4_4_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_4_4_1.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_4_4_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_4_4_2.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_4_4_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_4_4_3.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/Velocity_Cache_4_4_4.v
set_global_assignment -name VERILOG_FILE ../new_MD_core/velocity_init/velocity_4_4_4.v





	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
