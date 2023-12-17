-- File Name : Binary_to_SSD_tb
-- Binary to SSD testbench

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Testbench does not have ports in entity
ENTITY Binary_to_SSD_tb IS
END Binary_to_SSD_tb;

ARCHITECTURE test OF Binary_to_SSD_tb IS

	-- Component Declaration for the unit to be tested
	COMPONENT Binary_to_SSD
		PORT(
			input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			select_input : IN STD_LOGIC;
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
	
	TYPE ssd_array_type IS ARRAY (0 TO 17) OF STD_LOGIC_VECTOR(6 DOWNTO 0);
	CONSTANT ssd_array_C : ssd_array_type := (
		ZERO, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, LETTERA, LETTERB, LETTERC, LETTERD, LETTERE, LETTERF, BLANK, DASH);
	
	-- Signals connected to the component	
	SIGNAL input_tb : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL select_input_tb : STD_LOGIC;
	SIGNAL hex2_tb : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL hex1_tb : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL hex0_tb : STD_LOGIC_VECTOR(6 DOWNTO 0);
	
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
	UUT : Binary_to_SSD
	PORT MAP(
		input => input_tb,
		select_input => select_input_tb,
		hex2 => hex2_tb,
		hex1 => hex1_tb,
		hex0 => hex0_tb
		);
		
	stimulus : PROCESS
	
		VARIABLE input_tb_msb : STD_LOGIC_VECTOR(3 DOWNTO 0);
		VARIABLE input_tb_lsb : STD_LOGIC_VECTOR(3 DOWNTO 0);
		VARIABLE ones_dig : INTEGER;
		VARIABLE tens_dig : INTEGER;
	BEGIN
	
		-- Start testing when select input is 0 for decimal displays
		select_input_tb <= '0';
		FOR j IN 0 TO 255 LOOP
			-- Test every input
			input_tb <= STD_LOGIC_VECTOR(TO_UNSIGNED(j, 8));
			tens_dig := j/10;
			ones_dig := j rem 10;
			WAIT FOR 10 ns;
			IF j < 100 THEN
				-- Check the signs of HEX2
				IF TO_SIGNED(j, 8) < 0 THEN
					ASSERT hex2_tb = DASH
					REPORT "Hex2 is incorrect. Should be negative" & LF SEVERITY ERROR;
				ELSE
					ASSERT hex2_tb = BLANK
					REPORT "Hex2 is incorrect. Should be blank" & LF SEVERITY ERROR;
				END IF;
				-- Check the tens digits
				ASSERT hex1_tb = ssd_array_C(tens_dig)
				REPORT "Hex1 is incorrect. Should be "& INTEGER'image(tens_dig) & LF SEVERITY ERROR;
				-- Check the ones digits
				ASSERT hex0_tb = ssd_array_C(ones_dig)
				REPORT "Hex0 is incorrect. Should be "& INTEGER'image(ones_dig) & LF SEVERITY ERROR;
			END IF;
		END LOOP;
			
		-- Start testing when select input is 1 for hex displays
		select_input_tb <= '1';
		FOR J IN 0 TO 255 LOOP
			input_tb <= STD_LOGIC_VECTOR(TO_UNSIGNED(j, 8));
			input_tb_msb := STD_LOGIC_VECTOR(TO_UNSIGNED(j, 8)(7 DOWNTO 4));
			input_tb_lsb := STD_LOGIC_VECTOR(TO_UNSIGNED(j, 8)(3 DOWNTO 0));
			WAIT FOR 10 ns;
			ASSERT hex2_tb = Blank
			REPORT "Hex2 is incorrect. Should always be blank for hex"& LF SEVERITY ERROR;

			ASSERT hex1_tb = ssd_array_C(TO_INTEGER(UNSIGNED(input_tb_msb)))
         REPORT "HEX1 Incorrect. Should be "&hstr(input_tb_msb) & LF SEVERITY ERROR;
                    
			ASSERT hex0_tb = ssd_array_C(TO_INTEGER(UNSIGNED(input_tb_lsb)))
         REPORT "HEX0 Incorrect. Should be "&hstr(input_tb_lsb) & LF SEVERITY ERROR;
		END LOOP;
		
		Report LF& "**************************" &LF&
        					 "Simulation Complete" &LF&
        					 "**************************" SEVERITY NOTE;
		WAIT;
    END PROCESS stimulus;
	 
END ARCHITECTURE test;
