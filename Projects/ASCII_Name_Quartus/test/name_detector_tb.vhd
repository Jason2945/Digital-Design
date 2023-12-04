-- File Name : name_detector_tb.vhd
-- ASCII Name Detector testbench

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; -- This is needed for to_unsigned function

-- Testbench does not have ports in entity
ENTITY name_detector_tb IS
END ENTITY name_detector_tb;

ARCHITECTURE test OF name_detector_tb IS

	-- Component Declaration for the unit to be tested
	COMPONENT ASCII_Name -- The entity name of the componenet being tested
		-- Enter the ports for the componenet
		PORT (
			X : IN std_logic;
			B : IN std_logic;
			C : IN std_logic;
			D : IN std_logic;
			E : IN std_logic;
			F : IN std_logic;
			Y : IN std_logic;
			
			first_cond : OUT std_logic;
			last_cond : OUT std_logic;
			first_sel : OUT std_logic;
			last_sel : OUT std_logic
			);
	END COMPONENT;
	
	-- Signals connected to the componenet
	
	--Input ascii for X, B, C, D, E, F, and Y
	SIGNAL ascii : std_logic_vector(6 DOWNTO 0);
	
	--Ouput
	SIGNAL fName1 : std_logic;
	SIGNAL lName1 : std_logic;
	SIGNAL fName2 : std_logic;
	SIGNAL lName2 : std_logic;
	
BEGIN

	-- Instantiate the Unit Under Test (UUT)
	UUT : ASCII_Name PORT MAP(
		Y => ascii(0),
		F => ascii(1),
		E => ascii(2),
		D => ascii(3),
		C => ascii(4),
		B => ascii(5),
		X => ascii(6),
		
		first_cond => fName1,
		first_sel => fName2,
		last_cond => lName1,
		last_sel => lName2
		);
		
	stimulus : PROCESS
	BEGIN
		FOR i IN 0 TO 127 LOOP
			ascii <= std_logic_vector(to_unsigned(i,7));
			WAIT FOR 10 ns;
		END LOOP;
	END PROCESS stimulus;
	
END ARCHITECTURE test;