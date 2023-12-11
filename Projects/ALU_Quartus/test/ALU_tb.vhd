-- File Name : alu_tb
-- ALU testbench

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Testbench does not have ports in entity
ENTITY alu_tb IS
END ENTITY alu_tb;

ARCHITECTURE test OF alu_tb IS

	-- Component Declaration for the unit to be tested
	COMPONENT ALU
		PORT(
			Number1, Number2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			N : IN STD_LOGIC;
			OpSelect : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			Solution : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;
	
	-- Signals connected to the component
	SIGNAL num1_tb : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL num2_tb : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL n_tb : STD_LOGIC;
	SIGNAL OpSelect_tb : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL Solution_tb : STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	-- Convert a std_logic_vector into a hex string. Taken from txt_util package. Package obtained from http://www.stefanvhdl.com/
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
		UUT : ALU PORT MAP(
			Number1 => num1_tb,
			Number2 => num2_tb,
			N => n_tb,
			OpSelect => OpSelect_tb,
			Solution => Solution_tb
			);
			
		stimulus : PROCESS
			VARIABLE temp_8b : STD_LOGIC_VECTOR(7 DOWNTO 0);
			VARIABLE temp_signed_8b : SIGNED(7 DOWNTO 0);
			VARIABLE temp_unsigned : UNSIGNED(7 DOWNTO 0);
		BEGIN
		
			n_tb <= '0';
			
			-- Run through all options of select and all options of Number 1 and Number 2
			FOR k IN 0 TO 3 LOOP
				OpSelect_tb <= STD_LOGIC_VECTOR(TO_UNSIGNED(k, 2));
				FOR i IN 0 TO 15 LOOP
					num1_tb <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, 4));
					FOR j IN 0 TO 15 LOOP
						num2_tb <= STD_LOGIC_VECTOR(TO_UNSIGNED(j, 4));
						WAIT FOR 10 ns;
						
						CASE k IS
						
							-- Test addition
							WHEN 0 =>
								-- Convert the length of Num1 and Num2 to the length of the solution (8 bit)
								temp_signed_8b := RESIZE(SIGNED(num1_tb), Solution_tb'Length) + RESIZE(SIGNED(num2_tb), Solution_tb'Length);
								-- Check the solution testbench is the same as temp_signed_8b
								ASSERT Solution_tb = STD_LOGIC_VECTOR(temp_signed_8b)
								REPORT "Sum Operation Failed." &LF&
										 "Num1="&INTEGER'IMAGE(TO_INTEGER(SIGNED(Num1_tb)))&", Num2="&INTEGER'IMAGE(TO_INTEGER(SIGNED(Num2_tb)))&", Solution="&INTEGER'IMAGE(TO_INTEGER(SIGNED(Solution_tb)))&LF&
										 "Result should be "&INTEGER'IMAGE(TO_INTEGER(temp_signed_8b))
								SEVERITY error;
							
							-- Test multiplication
							WHEN 1 =>
								-- Multiplication output needs to be the same length as the sum of the two inputs
								temp_signed_8b := RESIZE(SIGNED(num1_tb) * SIGNED(num2_tb), Solution_tb'LENGTH);
								-- Check the solution testbench is the same as temp_signed_8b
								ASSERT Solution_tb = STD_LOGIC_VECTOR(temp_signed_8b)
								REPORT "Multiplication Operation Failed." &LF&
										 "Num1="&INTEGER'IMAGE(TO_INTEGER(SIGNED(Num1_tb)))&", Num2="&INTEGER'IMAGE(TO_INTEGER(SIGNED(Num2_tb)))&", Solution="&INTEGER'IMAGE(TO_INTEGER(SIGNED(Solution_tb)))&LF&
										 "Result should be "&INTEGER'IMAGE(TO_INTEGER(temp_signed_8b))
								SEVERITY error;
							
							-- Test AND
							WHEN 2 =>
								-- Convert the length of Num1 and Num2 to the length of the solution (8 bit)
								temp_8b := X"0" & (Num1_tb AND Num2_tb);
								-- Check the solution testbench is the same as temp_signed_8b
								ASSERT Solution_tb = temp_8b
								REPORT "And Operation Failed." &LF&
										 "Num1="&hstr(num1_tb)&", Num2="&hstr(Num2_tb)&", Solution="&hstr(Solution_tb)&LF&
										 "Result should be "&hstr(temp_8b)
								SEVERITY error;
								
							-- Test OR
							WHEN 3 =>
								-- Convert the length of Num1 and Num2 to the length of the solution (8 bit)
								temp_8b := X"0" & (Num1_tb OR Num2_tb);
								-- Check the solution testbench is the same as temp_signed_8b
								ASSERT Solution_tb = temp_8b
								REPORT "And Operation Failed." &LF&
										 "Num1="&hstr(num1_tb)&", Num2="&hstr(Num2_tb)&", Solution="&hstr(Solution_tb)&LF&
										 "Result should be "&hstr(temp_8b)
								SEVERITY error;
								
							WHEN OTHERS => NULL;
						END CASE;
					END LOOP;
				END LOOP;
			END LOOP;
			
			-- Test subtraction at the end
			n_tb <= '1';
			OpSelect_tb <="00";
			FOR i IN 0 TO 15 LOOP
				num1_tb <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, 4));
				FOR j IN 0 TO 15 LOOP
					num2_tb <= STD_LOGIC_VECTOR(TO_UNSIGNED(j, 4));
					WAIT FOR 10 ns;
						
					-- Convert the length of Num1 and Num2 to the length of the solution (8 bit)
					temp_signed_8b := RESIZE(SIGNED(num1_tb), Solution_tb'Length) - RESIZE(SIGNED(num2_tb), Solution_tb'Length);
					-- Check the solution testbench is the same as temp_signed_8b
					ASSERT Solution_tb = STD_LOGIC_VECTOR(temp_signed_8b)
					REPORT "Subtraction Operation Failed." &LF&
							"Num1="&INTEGER'IMAGE(TO_INTEGER(SIGNED(Num1_tb)))&", Num2="&INTEGER'IMAGE(TO_INTEGER(SIGNED(Num2_tb)))&", Solution="&INTEGER'IMAGE(TO_INTEGER(SIGNED(Solution_tb)))&LF&
							"Result should be "&INTEGER'IMAGE(TO_INTEGER(temp_signed_8b))
					SEVERITY error;
				END LOOP;
			END LOOP;
			REPORT LF&"Simulation Done" SEVERITY Note;
			WAIT;
		END PROCESS stimulus;
		
END test;
								
								
								
								