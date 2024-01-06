LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Counter IS
	PORT(
		Clk, Enable, Reset_N : IN STD_LOGIC;
		BCD3, BCD2, BCD1, BCD0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END Counter;

ARCHITECTURE arch OF Counter IS

	SIGNAL internal_count : STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL NINENINENINE : STD_LOGIC_VECTOR(9 DOWNTO 0) := "1111100111";
	
BEGIN
	counter : PROCESS(Clk, Reset_N, Enable)
	BEGIN
		IF (Reset_N = '0') THEN
			internal_count <= (OTHERS => '0');
		ELSIF (RISING_EDGE(Clk) AND Enable = '1') THEN
			IF (internal_count = "1111100111") THEN
				internal_count <= "0000000000");
			ELSE
				internal_count <= internal_count + 1;
			END IF;
		END IF;
	END PROCESS;
	
	
	

END arch;