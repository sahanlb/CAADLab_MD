set QSYS_SIMDIR /home/sahanb/1-MD_sim/1-old_design/new_MD_core

source $QSYS_SIMDIR/mentor/msim_setup.tcl

#vlog -work work ../new_MD_core/*.v
#vlog -work work -sv ../new_MD_core/*.sv
#vlog -work work ../new_MD_core/velocity_init/*.v


set TOP_LEVEL_NAME RL_top_tb
elab


add wave -r -depth 3 *


run 300000ns

exit -code 0

