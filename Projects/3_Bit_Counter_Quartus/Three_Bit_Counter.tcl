# Copyright (C) 2020  Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions 
# and other software and tools, and any partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License 
# Subscription Agreement, the Intel Quartus Prime License Agreement,
# the Intel FPGA IP License Agreement, or other applicable license
# agreement, including, without limitation, that your use is for
# the sole purpose of programming logic devices manufactured by
# Intel and sold by Intel or its authorized distributors.  Please
# refer to the applicable agreement for further details, at
# https://fpgasoftware.intel.com/eula.

# Quartus Prime: Generate Tcl File for Project
# File: Three_Bit_Counter.tcl
# Generated on: Sat Dec 02 13:38:02 2023

# Load Quartus Prime Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "Three_Bit_Counter"]} {
		puts "Project Three_Bit_Counter is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists Three_Bit_Counter]} {
		project_open -revision Three_Bit_Counter Three_Bit_Counter
	} else {
		project_new -revision Three_Bit_Counter Three_Bit_Counter
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "Cyclone V"
	set_global_assignment -name DEVICE 5CSXFC6D6F31C6
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 20.1.1
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "12:24:33  DECEMBER 02, 2023"
	set_global_assignment -name LAST_QUARTUS_VERSION "20.1.1 Lite Edition"
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 256
	set_global_assignment -name BDF_FILE Three_Bit_Counter.bdf
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform.vwf
	set_location_assignment PIN_AB30 -to reset
	set_location_assignment PIN_AC23 -to q2
	set_location_assignment PIN_AB23 -to q1
	set_location_assignment PIN_AA24 -to q0
	set_location_assignment PIN_AF25 -to clear
	set_location_assignment PIN_AH18 -to seg_g
	set_location_assignment PIN_AG18 -to seg_f
	set_location_assignment PIN_AH17 -to seg_e
	set_location_assignment PIN_AG16 -to seg_d
	set_location_assignment PIN_AG17 -to seg_c
	set_location_assignment PIN_V18 -to seg_b
	set_location_assignment PIN_W17 -to seg_a
	set_location_assignment PIN_AJ4 -to clock
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
