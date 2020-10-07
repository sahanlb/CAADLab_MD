set QSYS_SIMDIR /home/sahanb/1-MD_sim/1-old_design/new_MD_core

source $QSYS_SIMDIR/mentor/msim_setup.tcl

#vlog -work work ../new_MD_core/md_pkg.sv
vlog -work work ../new_MD_core/*.v
vlog -work work -sv ../new_MD_core/*.sv

exit -code 0

