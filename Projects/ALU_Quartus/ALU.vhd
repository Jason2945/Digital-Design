LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY ALU IS
	PORT(
		Number1, Number2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		N : IN STD_LOGIC;
		OpSelect : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		Solution : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
END ALU;

ARCHITECTURE ALU_arch OF ALU IS

	SIGNAL signedA : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL signedB : STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	SIGNAL signedA_3bit : SIGNED(3 DOWNTO 0);
	SIGNAL signedB_3bit : SIGNED(3 DOWNTO 0);
	
	SIGNAL unsignedA : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL unsignedB : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL two_c_b : STD_LOGIC_VECTOR(7 DOWNTO 0);
	
BEGIN

	signedA_3bit <= SIGNED(Number1);
	signedB_3bit <= SIGNED(Number2);
----------------------------------------------------------------------------------------------------------------------------------------
	signed_num1 : PROCESS(Number1)
	BEGIN
		IF Number1(3) = '1' THEN
			signedA <= "1111" & Number1;
		ELSE
			signedA <= "0000" & Number1;
		END IF;
	END PROCESS;
----------------------------------------------------------------------------------------------------------------------------------------
	signed_num2 : PROCESS(Number2)
	BEGIN
		IF Number2(3) = '1' THEN
			signedB <= "1111" & Number2;
		ELSE
			signedB <= "0000" & Number2;
		END IF;
	END PROCESS;
----------------------------------------------------------------------------------------------------------------------------------------
	unsigned_num1 : PROCESS(Number1)
	BEGIN
		unsignedA <= "0000" & Number1;
	END PROCESS;
	
	unsigned_num2 : PROCESS(Number2)
	BEGIN
		unsignedB <= "0000" & Number2;
	END PROCESS;
----------------------------------------------------------------------------------------------------------------------------------------
	two_complement : PROCESS(Number2)
	BEGIN
		two_c_b <= NOT(Number2) + "00000001";
	END PROCESS;
----------------------------------------------------------------------------------------------------------------------------------------
	
	operations : PROCESS(signedA_3bit, signedB_3bit, signedA, signedB, unsignedA, unsignedB, two_c_b, OpSelect, N)
	BEGIN
		
		CASE OpSelect IS
			WHEN "00" =>
				IF N = '0' THEN
					Solution <= signedA + signedB;
				ELSE
					Solution <= signedA + two_c_b;
				END IF;
			WHEN "01" =>
				Solution <= STD_LOGIC_VECTOR(signedA_3bit * signedB_3bit);
			WHEN "10" =>
				Solution <= unsignedA AND unsignedB;
			WHEN "11" =>
				Solution <= unsignedA OR unsignedB;
			WHEN OTHERS =>
				Solution <= "00000000";
		END CASE;
	END PROCESS;

END ALU_arch;

