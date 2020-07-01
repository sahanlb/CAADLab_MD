
namespace eval FIX_SQRT {
  proc get_design_libraries {} {
    set libraries [dict create]
    dict set libraries altera_fxp_functions_180 1
    dict set libraries FIX_SQRT                 1
    return $libraries
  }
  
  proc get_memory_files {QSYS_SIMDIR} {
    set memory_files [list]
    lappend memory_files "[normalize_path "$QSYS_SIMDIR/../altera_fxp_functions_180/sim/FIX_SQRT_altera_fxp_functions_180_gf6zify_a0Table_uid33_sqrt_lutmem_part0.hex"]"
    lappend memory_files "[normalize_path "$QSYS_SIMDIR/../altera_fxp_functions_180/sim/FIX_SQRT_altera_fxp_functions_180_gf6zify_a0Table_uid33_sqrt_lutmem_part1.hex"]"
    lappend memory_files "[normalize_path "$QSYS_SIMDIR/../altera_fxp_functions_180/sim/FIX_SQRT_altera_fxp_functions_180_gf6zify_a0Table_uid34_sqrt_lutmem_part0.hex"]"
    lappend memory_files "[normalize_path "$QSYS_SIMDIR/../altera_fxp_functions_180/sim/FIX_SQRT_altera_fxp_functions_180_gf6zify_a0Table_uid34_sqrt_lutmem_part1.hex"]"
    lappend memory_files "[normalize_path "$QSYS_SIMDIR/../altera_fxp_functions_180/sim/FIX_SQRT_altera_fxp_functions_180_gf6zify_a1Table_uid37_sqrt_lutmem.hex"]"
    return $memory_files
  }
  
  proc get_common_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [dict create]
    return $design_files
  }
  
  proc get_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [list]
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_fxp_functions_180/sim/dspba_library_package.vhd"]\"  -work altera_fxp_functions_180"                    
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_fxp_functions_180/sim/dspba_library.vhd"]\"  -work altera_fxp_functions_180"                            
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_fxp_functions_180/sim/FIX_SQRT_altera_fxp_functions_180_gf6zify.vhd"]\"  -work altera_fxp_functions_180"
    lappend design_files "vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/FIX_SQRT.v"]\"  -work FIX_SQRT"                                                                                
    return $design_files
  }
  
  proc get_elab_options {SIMULATOR_TOOL_BITNESS} {
    set ELAB_OPTIONS ""
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $ELAB_OPTIONS
  }
  
  
  proc get_sim_options {SIMULATOR_TOOL_BITNESS} {
    set SIM_OPTIONS ""
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $SIM_OPTIONS
  }
  
  
  proc get_env_variables {SIMULATOR_TOOL_BITNESS} {
    set ENV_VARIABLES [dict create]
    set LD_LIBRARY_PATH [dict create]
    dict set ENV_VARIABLES "LD_LIBRARY_PATH" $LD_LIBRARY_PATH
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $ENV_VARIABLES
  }
  
  
  proc normalize_path {FILEPATH} {
      if {[catch { package require fileutil } err]} { 
          return $FILEPATH 
      } 
      set path [fileutil::lexnormalize [file join [pwd] $FILEPATH]]  
      if {[file pathtype $FILEPATH] eq "relative"} { 
          set path [fileutil::relative [pwd] $path] 
      } 
      return $path 
  } 
}
