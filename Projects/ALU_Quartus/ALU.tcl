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
# File: ALU.tcl
# Generated on: Mon Dec 11 13:01:44 2023

# Load Quartus Prime Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "ALU"]} {
		puts "Project ALU is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists ALU]} {
		project_open -revision ALU ALU
	} else {
		project_new -revision ALU ALU
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "Cyclone V"
	set_global_assignment -name DEVICE 5CSXFC6D6F31C6
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 20.1.1
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "19:36:09  DECEMBER 06, 2023"
	set_global_assignment -name LAST_QUARTUS_VERSION "20.1.1 Lite Edition"
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 256
	set_global_assignment -name VHDL_FILE ALU.vhd
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_global_assignment -name VHDL_FILE ALU_tb.vhd
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform.vwf
	set_location_assignment PIN_AC30 -to Number2[3]
	set_location_assignment PIN_AB28 -to Number2[2]
	set_location_assignment PIN_AD30 -to Number1[3]
	set_location_assignment PIN_AC28 -to Number1[2]
	set_location_assignment PIN_V25 -to Number1[1]
	set_location_assignment PIN_W25 -to Number1[0]
	set_location_assignment PIN_Y27 -to Number2[1]
	set_location_assignment PIN_AB30 -to Number2[0]
	set_location_assignment PIN_AA30 -to OpSelect[1]
	set_location_assignment PIN_AC29 -to OpSelect[0]
	set_location_assignment PIN_AJ4 -to N
	set_location_assignment PIN_AF24 -to Solution[7]
	set_location_assignment PIN_AE24 -to Solution[6]
	set_location_assignment PIN_AF25 -to Solution[5]
	set_location_assignment PIN_AG25 -to Solution[4]
	set_location_assignment PIN_AD24 -to Solution[3]
	set_location_assignment PIN_AC23 -to Solution[2]
	set_location_assignment PIN_AB23 -to Solution[1]
	set_location_assignment PIN_AA24 -to Solution[0]
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
