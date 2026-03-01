##---------------------------------------------------------------------------------
## License: CC0-1.0 https://creativecommons.org/publicdomain/zero/1.0/legalcode.txt
## Repository: https://github.com/LarsRockstroh/SwGuides/
## Filename: WaveGen4Bit_top.tcl
## Language: TCL
## Description:
##  . Generates Vivado project for S7 devboard based on script filename
## History:
## 01.00, 2026-02-28
##   Initial
##---------------------------------------------------------------------------------
set Design_Files "\
WaveGen4Bit_top_VarA.vhd 
"

set XdcFile "WaveGen4Bit_top.xdc"

set ScriptPath  [file dirname             [file normalize [info script]]]
# Get FPGAroot directory based on rightmost occurance in path
regexp {(.*/)FPGAroot} ${ScriptPath} NotUsedFullMatch FPGAroot
#puts $FPGAroot

# Get project name from script name
set ProjectName [file rootname [file tail [file normalize [info script]]]]
set ProjectLocation ${FPGAroot}FPGAroot/Projects/${ProjectName}                             
#puts $ProjectLocation

# Auto Incremental Compile:: No reference checkpoint was found in run synth_1.
set_msg_config -suppress -id {Vivado 12-7122} 
set_msg_config -suppress -id {Synth 8-7080} 
# Could not load NoC clock tree from device
set_msg_config -suppress -id {Ipconfig 75-871}
# Unable to create NoC or AIE Models.
set_msg_config -suppress -id {Ipconfig 75-570}


create_project $ProjectName $ProjectLocation

set_property part xc7s25ftgb196-1 [current_project]

set_property target_language VHDL [current_project]
set_param project.enableVHDL2008 1
set_property STEPS.SYNTH_DESIGN.ARGS.FSM_EXTRACTION one_hot [get_runs synth_1]
set_property STEPS.SYNTH_DESIGN.ARGS.ASSERT true [get_runs synth_1]
set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]

cd $ScriptPath
#set fp [open "Design_Files.txt" r]
#set file_data [read $fp]
#close $fp
#set Design_Files [split $file_data "\n"]
add_files $Design_Files
set_property FILE_TYPE {VHDL 2008} [get_files *.vhd*]

add_files -fileset constrs_1 -norecurse $XdcFile
set_property target_constrs_file $XdcFile [current_fileset -constrset]

launch_runs synth_1 -jobs 8
wait_on_run synth_1
launch_runs impl_1 -jobs 8
wait_on_run impl_1
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
