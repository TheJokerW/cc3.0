# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7a100tfgg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir F:/project_3/project_3.cache/wt [current_project]
set_property parent.project_path F:/project_3/project_3.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo f:/project_3/project_3.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files F:/project_3/project_3.srcs/sources_1/ip.coe
add_files f:/project_2/project_3/project_3.srcs/sources_1/ip.coe
read_verilog -library xil_defaultlib {
  F:/project_3/project_3.srcs/sources_1/new/RAM32bit_64.v
  F:/project_3/project_3.srcs/sources_1/imports/new/calComplement.v
  F:/project_3/project_3.srcs/sources_1/new/noname.v
  F:/project_3/project_3.srcs/sources_1/imports/new/regGroup.v
  F:/project_3/project_3.srcs/sources_1/new/top.v
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc F:/project_3/project_3.srcs/constrs_1/new/noname.xdc
set_property used_in_implementation false [get_files F:/project_3/project_3.srcs/constrs_1/new/noname.xdc]


synth_design -top top -part xc7a100tfgg484-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef top.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb"
