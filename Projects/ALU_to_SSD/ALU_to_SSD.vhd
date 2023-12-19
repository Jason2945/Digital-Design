LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY ALU_to_SSD IS
PORT (
	N : IN STD_LOGIC;
	A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	Sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	hex2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	hex1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	hex0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END ALU_to_SSD;

ARCHITECTURE arch OF ALU_to_SSD IS

-- Declare signals
	SIGNAL Select_Sig : STD_LOGIC;
	SIGNAL Solution_Sig : STD_LOGIC_VECTOR(7 DOWNTO 0);

-- Declare component ALU that is going to be used.
COMPONENT ALU IS
	PORT(
		Number1, Number2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		N : IN STD_LOGIC;
		OpSelect : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		Solution : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

-- Declare component Binary to ssd that is going to be used
COMPONENT BINARY_to_SSD IS
	PORT(
		input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		select_input : IN STD_LOGIC;
		hex2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		hex1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		hex0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END COMPONENT;

BEGIN
	
	-- Control the ALU operation and the display on the Seven Segment Display.
	-- 00 and 01 shows decimal.
	-- 10 and 11 shows hexadecimal.
	-- Process to check display
	display_check : PROCESS(Sel)
	BEGIN
		CASE Sel IS
			WHEN "00" => Select_Sig <= '0';
			WHEN "01" => Select_Sig <= '0';
			WHEN "10" => Select_Sig <= '1';
			WHEN "11" => Select_Sig <= '1';
			WHEN OTHERS => Select_Sig <= '0';
		END CASE;
	END PROCESS;
	
	-- Initiate the component ALU for alu1
	alu1 : ALU
		PORT MAP(
			Number1 => A,
			Number2 => B,
			N => N,
			OpSelect => Sel,
			Solution => Solution_Sig);
			
	-- Initiate the component Binary to ssd to connect it to the ALU component and output it back to top level design
	ssd1 : BINARY_to_SSD
		PORT MAP(
			input => Solution_Sig,
			select_input => Select_Sig,
			hex2 => hex2,
			hex1 => hex1,
			hex0 => hex0);
			
END arch;