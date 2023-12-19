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
# File: ALU_to_SSD.tcl
# Generated on: Tue Dec 19 17:28:05 2023

# Load Quartus Prime Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "ALU_to_SSD"]} {
		puts "Project ALU_to_SSD is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists ALU_to_SSD]} {
		project_open -revision ALU_to_SSD ALU_to_SSD
	} else {
		project_new -revision ALU_to_SSD ALU_to_SSD
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "Cyclone V"
	set_global_assignment -name DEVICE 5CSXFC6D6F31C6
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 20.1.1
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "14:36:17  DECEMBER 19, 2023"
	set_global_assignment -name LAST_QUARTUS_VERSION "20.1.1 Lite Edition"
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 256
	set_global_assignment -name VHDL_FILE Binary_to_SSD.vhd
	set_global_assignment -name VHDL_FILE ALU.vhd
	set_global_assignment -name VHDL_FILE ALU_to_SSD.vhd
	set_global_assignment -name POWER_PRESET_COOLING_SOLUTION "23 MM HEAT SINK WITH 200 LFPM AIRFLOW"
	set_global_assignment -name POWER_BOARD_THERMAL_MODEL "NONE (CONSERVATIVE)"
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_global_assignment -name VHDL_FILE output_files/ALU_to_SSD_tb.vhd
	set_location_assignment PIN_AD30 -to A[3]
	set_location_assignment PIN_AC28 -to A[2]
	set_location_assignment PIN_V25 -to A[1]
	set_location_assignment PIN_W25 -to A[0]
	set_location_assignment PIN_AC30 -to B[3]
	set_location_assignment PIN_AB28 -to B[2]
	set_location_assignment PIN_Y27 -to B[1]
	set_location_assignment PIN_AB30 -to B[0]
	set_location_assignment PIN_AA30 -to Sel[1]
	set_location_assignment PIN_AC29 -to Sel[0]
	set_location_assignment PIN_AJ4 -to N
	set_location_assignment PIN_W16 -to hex2[6]
	set_location_assignment PIN_AF18 -to hex2[5]
	set_location_assignment PIN_Y18 -to hex2[4]
	set_location_assignment PIN_Y17 -to hex2[3]
	set_location_assignment PIN_AA18 -to hex2[2]
	set_location_assignment PIN_AB17 -to hex2[1]
	set_location_assignment PIN_AA21 -to hex2[0]
	set_location_assignment PIN_V17 -to hex1[6]
	set_location_assignment PIN_AE17 -to hex1[5]
	set_location_assignment PIN_AE18 -to hex1[4]
	set_location_assignment PIN_AD17 -to hex1[3]
	set_location_assignment PIN_AE16 -to hex1[2]
	set_location_assignment PIN_V16 -to hex1[1]
	set_location_assignment PIN_AF16 -to hex1[0]
	set_location_assignment PIN_AH18 -to hex0[6]
	set_location_assignment PIN_AG18 -to hex0[5]
	set_location_assignment PIN_AH17 -to hex0[4]
	set_location_assignment PIN_AG16 -to hex0[3]
	set_location_assignment PIN_AG17 -to hex0[2]
	set_location_assignment PIN_V18 -to hex0[1]
	set_location_assignment PIN_W17 -to hex0[0]
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
