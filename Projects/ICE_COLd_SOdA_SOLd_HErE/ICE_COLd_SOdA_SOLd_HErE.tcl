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
# File: ICE_COLd_SOdA_SOLd_HErE.tcl
# Generated on: Sat Nov 25 17:40:18 2023

# Load Quartus Prime Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "ICE_COLd_SOdA_SOLd_HErE"]} {
		puts "Project ICE_COLd_SOdA_SOLd_HErE is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists ICE_COLd_SOdA_SOLd_HErE]} {
		project_open -revision ICE_COLd_SOdA_SOLd_HErE ICE_COLd_SOdA_SOLd_HErE
	} else {
		project_new -revision ICE_COLd_SOdA_SOLd_HErE ICE_COLd_SOdA_SOLd_HErE
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "Cyclone V"
	set_global_assignment -name DEVICE 5CSXFC6D6F31C6
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 20.1.1
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "15:12:26  NOVEMBER 25, 2023"
	set_global_assignment -name LAST_QUARTUS_VERSION "20.1.1 Lite Edition"
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 256
	set_global_assignment -name BDF_FILE ICE_COLd_SOdA_SOLd_HErE.bdf
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_location_assignment PIN_AB28 -to x
	set_location_assignment PIN_Y27 -to y
	set_location_assignment PIN_AB30 -to z
	set_location_assignment PIN_AD20 -to HEX3g
	set_location_assignment PIN_AA19 -to HEX3f
	set_location_assignment PIN_AC20 -to HEX3e
	set_location_assignment PIN_AA20 -to HEX3d
	set_location_assignment PIN_AD19 -to HEX3c
	set_location_assignment PIN_W19 -to HEX3b
	set_location_assignment PIN_Y19 -to HEX3a
	set_location_assignment PIN_W16 -to HEX2g
	set_location_assignment PIN_AF18 -to HEX2f
	set_location_assignment PIN_Y18 -to HEX2e
	set_location_assignment PIN_Y17 -to HEX2d
	set_location_assignment PIN_AA18 -to HEX2c
	set_location_assignment PIN_AB17 -to HEX2b
	set_location_assignment PIN_AA21 -to HEX2a
	set_location_assignment PIN_V17 -to HEX1g
	set_location_assignment PIN_AE17 -to HEX1f
	set_location_assignment PIN_AE18 -to HEX1e
	set_location_assignment PIN_AD17 -to HEX1d
	set_location_assignment PIN_AE16 -to HEX1c
	set_location_assignment PIN_V16 -to HEX1b
	set_location_assignment PIN_AF16 -to HEX1a
	set_location_assignment PIN_AH18 -to HEX0g
	set_location_assignment PIN_AG18 -to HEX0f
	set_location_assignment PIN_AH17 -to HEX0e
	set_location_assignment PIN_AG16 -to HEX0d
	set_location_assignment PIN_AG17 -to HEX0c
	set_location_assignment PIN_V18 -to HEX0b
	set_location_assignment PIN_W17 -to HEX0a
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
