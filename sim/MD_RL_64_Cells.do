set QSYS_SIMDIR /home/sahanb/1-MD_sim/1-old_design/new_MD_core

source $QSYS_SIMDIR/mentor/msim_setup.tcl

#vlog -work work ../new_MD_core/*.v
#vlog -work work -sv ../new_MD_core/*.sv
#vlog -work work ../new_MD_core/velocity_init/*.v


set TOP_LEVEL_NAME RL_top_tb
elab


add wave -r -depth 5 *


#add wave sim:/RL_top_tb/RL_top/all_position_caches/*
#add wave sim:/RL_top_tb/RL_top/PE_collection\[0\]/single_PE/*
#add wave sim:/RL_top_tb/RL_top/PE_collection\[0\]/single_PE/pos_data_preprocessor/*
#add wave sim:/RL_top_tb/RL_top/PE_collection\[0\]/single_PE/pos_data_preprocessor/ref_extractor_inst\[0\]/ref_data_extractor/*


run 200000ns

exit -code 0

