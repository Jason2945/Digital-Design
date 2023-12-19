-- File Name ALU_to_SSD_tb
-- ALU Operation to Seven Segment Display Testbench

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

--Testbench does not have ports in entity
ENTITY ALU_to_SSD_tb IS
END ALU_to_SSD_tb;

ARCHITECTURE test of ALU_to_SSD_tb IS

	COMPONENT ALU_to_SSD
		PORT (
			N : IN STD_LOGIC;
			A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			Sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			hex2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
			hex1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
			hex0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
	END COMPONENT;
	
	CONSTANT ZERO : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1000000";
	CONSTANT ONE : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111001";
	CONSTANT TWO : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0100100";
	CONSTANT THREE : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0110000";
	CONSTANT FOUR : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0011001";	
	CONSTANT FIVE : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0010010";
	CONSTANT SIX : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000010";
	CONSTANT SEVEN : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111000";
	CONSTANT EIGHT : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000";
	CONSTANT NINE : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0010000";
	CONSTANT LETTERA : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0001000";
	CONSTANT LETTERB : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000011";
	CONSTANT LETTERC : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1000110";
	CONSTANT LETTERD : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0100001";
	CONSTANT LETTERE : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000110";
	CONSTANT LETTERF : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0001110";
	CONSTANT BLANK : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111";
	CONSTANT DASH : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0111111";
	
	-- Put all the constants into an array
	TYPE ssd_array_type IS ARRAY(0 TO 17) OF STD_LOGIC_VECTOR(6 DOWNTO 0);
	CONSTANT ssd_array_C : ssd_array_type := (
		ZERO, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, LETTERA, LETTERB, LETTERC, LETTERD, LETTERE, LETTERF, BLANK, DASH);
	
	-- testbench signals connected to the input and outputs
	SIGNAL A_tb : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL B_tb : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL Sel_tb : STD_LOGIC_VECTOR(1 DOWNTO 0);
	-- Start with 0 to test subtraction
	SIGNAL N_tb : STD_LOGIC := '0';
	SIGNAL hex0_tb : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL hex1_tb : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL hex2_tb : STD_LOGIC_VECTOR(6 DOWNTO 0);
	
	-- converts a std_logic_vector into a hex string. Taken from txt_util package. Package obtained from http://www.stefanvhdl.com/
	function hstr(slv: std_logic_vector) return string is
       variable hexlen: integer;
       variable longslv : std_logic_vector(67 downto 0) := (others => '0');
       variable hex : string(1 to 16);
       variable fourbit : std_logic_vector(3 downto 0);
     begin
       hexlen := (slv'left+1)/4;
       if (slv'left+1) mod 4 /= 0 then
         hexlen := hexlen + 1;
       end if;
       longslv(slv'left downto 0) := slv;
       for i in (hexlen -1) downto 0 loop
         fourbit := longslv(((i*4)+3) downto (i*4));
         case fourbit is
           when "0000" => hex(hexlen -I) := '0';
           when "0001" => hex(hexlen -I) := '1';
           when "0010" => hex(hexlen -I) := '2';
           when "0011" => hex(hexlen -I) := '3';
           when "0100" => hex(hexlen -I) := '4';
           when "0101" => hex(hexlen -I) := '5';
           when "0110" => hex(hexlen -I) := '6';
           when "0111" => hex(hexlen -I) := '7';
           when "1000" => hex(hexlen -I) := '8';
           when "1001" => hex(hexlen -I) := '9';
           when "1010" => hex(hexlen -I) := 'A';
           when "1011" => hex(hexlen -I) := 'B';
           when "1100" => hex(hexlen -I) := 'C';
           when "1101" => hex(hexlen -I) := 'D';
           when "1110" => hex(hexlen -I) := 'E';
           when "1111" => hex(hexlen -I) := 'F';
           when "ZZZZ" => hex(hexlen -I) := 'z';
           when "UUUU" => hex(hexlen -I) := 'u';
           when "XXXX" => hex(hexlen -I) := 'x';
           when others => hex(hexlen -I) := '?';
         end case;
       end loop;
       return hex(1 to hexlen);
     end hstr;
	
BEGIN

	-- Instantiate the UUT
	UUT : ALU_to_SSD
	PORT MAP(
		A => A_tb,
		B => B_tb,
		Sel => Sel_tb,
		N => N_tb,
		hex0 => hex0_tb,
		hex1 => hex1_tb,
		hex2 => hex2_tb
	);
	
	stimulus : PROCESS
		
		VARIABLE temp_4b : STD_LOGIC_VECTOR(3 DOWNTO 0);
		VARIABLE temp_signed_8b : SIGNED(7 DOWNTO 0);
		VARIABLE ones_dig : INTEGER;
		VARIABLE tens_dig : INTEGER;
	
	-- Create a procedure to check the output of the seven segment display when doing AND and OR operations
	-- The SSD for AND and OR operations can only go up to F.
	PROCEDURE hexadecimal_check(temp_4b : IN STD_LOGIC_VECTOR(3 DOWNTO 0)) IS
		BEGIN
			-- The hex2 SSD doesn't have negative cause AND and OR operations don't go to negative
			ASSERT hex2_tb = BLANK
			REPORT "hex2 is incorrect. Should be Blank" & LF SEVERITY ERROR;
			
			-- The hex1 SSD is always zero because AND and OR operations doesn't use hex2 as max value is F or 15
			ASSERT hex1_tb = ZERO
			REPORT "hex1 is incorrect. Should be 0" & LF SEVERITY ERROR;
			
			-- Check hex0 is a value between 0-F and Dash and Blank because those are the only things it should display
			ASSERT hex0_tb = ssd_array_C(TO_INTEGER(UNSIGNED(temp_4b)))
			REPORT "hex0 is incorrect. SHould be "&hstr(temp_4b) & LF SEVERITY ERROR;
	END PROCEDURE;
	
	PROCEDURE decimal_check(temp_signed_8nb : IN SIGNED(7 DOWNTO 0)) IS
		VARIABLE ones_dig : INTEGER;
		VARIABLE tens_dig : INTEGER;
	BEGIN
		-- Get the tens digit and ones digit in integer form through to int and absolute value
		tens_dig := ABS(TO_INTEGER(temp_signed_8b / 10));
		ones_dig := ABS(TO_INTEGER(temp_signed_8b rem 10));
		
		-- Check the value of the signed bit less than 100 as the max it can and should go is 99 for decimals
		IF temp_signed_8b < 100 THEN
			-- If the value of the 8bit is less than 0, hex2 should display a negative sign
			IF temp_signed_8b < 0 THEN
				ASSERT hex2_tb = DASH
				REPORT "hex2 is incorrect. Should be Dash" & LF SEVERITY ERROR;
			-- If the value of the 8 bit is greater than 0, hex2 should be blank
			ELSE
				ASSERT hex2_tb = BLANK
				REPORT "hex2 is incorrect. Should be Blank" & LF SEVERITY ERROR;
			END IF;
			
			-- Check that hex1 and hex0 are both displaying one of the constant options and the correct one after doing the operations from binary to decimal
			ASSERT hex1_tb = ssd_array_C(tens_dig)
			REPORT "hex1 is incorrect. Should be " &INTEGER'IMAGE(tens_dig) & LF SEVERITY ERROR;
			
			ASSERT hex0_tb = ssd_array_c(ones_dig)
			REPORT "hex0 is incorrect. Should be " &INTEGER'IMAGE(ones_dig) & LF SEVERITY ERROR;
		END IF;
	END PROCEDURE;
	
	BEGIN
	
		FOR k IN 0 TO 3 LOOP
			Sel_tb <= STD_LOGIC_VECTOR(TO_UNSIGNED(k, 2));
			-- Testing all values for the first number 0-15 or 0-F
			FOR i IN 0 TO 15 LOOP
				A_tb <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, 4));
				-- Testing all values for the second number 0-15 or 0-F
				FOR j in 0 TO 15 LOOP
					B_tb <= STD_LOGIC_VECTOR(TO_UNSIGNED(j, 4));
					WAIT FOR 10 ns;
					temp_4b := x"0";
					temp_signed_8b := x"00";
					
					CASE k IS
						-- 2 is 10, so checking for AND operations
						WHEN 2 =>
							temp_4b := A_tb AND B_tb;
							-- Put the solution into the hexadecimal check procedure. Make sure that the output matches the value of the procedure.
							hexadecimal_check(temp_4b);
						
						-- Checking OR operations
						WHEN 3 =>
							temp_4b := A_tb OR B_tb;
							-- Put the solution into the hexadecimal check procedure. Make sure that the output matches the value of the procedure.
							hexadecimal_check(temp_4b);
							
						-- Checking addition and subtraction through two's complement
						WHEN 0 =>
							-- Add A and B but make sure A and B are resized to 8 bits instead of 4 bits
							temp_signed_8b := RESIZE(SIGNED(A_tb), temp_signed_8b'LENGTH) + RESIZE(SIGNED(B_tb), temp_signed_8b'LENGTH);
							-- Put the solution into the decimal check procedure and make sure the output are accepted outputs.
							decimal_check(temp_signed_8b);
							
						-- Checking multiplication
						WHEN 1 =>
							-- Multiply A and B but make sure A and B are resized to 8 bits after operations
							temp_signed_8b := RESIZE(SIGNED(A_tb) * SIGNED(B_tb), temp_signed_8b'LENGTH);
							-- Put the solution into the decimal check procedure and make sure the output are accepted outputs.
							decimal_check(temp_signed_8b);
							
						WHEN OTHERS => NULL;
					END CASE;
				END LOOP;
			END LOOP;
		END LOOP;
		
		-- Check for addition
		N_tb <= '1';
		Sel_tb <= "00";
		FOR i IN 0 TO 15 LOOP
			A_tb <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, 4));
			FOR j IN 0 TO 15 LOOP
				B_tb <= STD_LOGIC_VECTOR(TO_UNSIGNED(j, 4));
				WAIT FOR 10 ns;
				temp_4b := x"0";
				temp_signed_8b := x"00";
				
				temp_signed_8b := RESIZE(SIGNED(A_tb), temp_signed_8b'LENGTH) - RESIZE(SIGNED(B_tb), temp_signed_8b'LENGTH);
				decimal_check(temp_signed_8b);
			END LOOP;
		END LOOP;
		
		Report LF& "**************************" &LF&
        					 "Simulation Complete" &LF&
        					 "**************************" SEVERITY NOTE;
		WAIT;
	END PROCESS stimulus;
	
END ARCHITECTURE test;
							