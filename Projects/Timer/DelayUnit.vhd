LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY DelayUnit IS
	PORT(
	MaxValue : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
	Clk : IN STD_LOGIC;
	Reset_N : IN STD_LOGIC;
	Flag : OUT STD_LOGIC;
	Test_pt : OUT STD_LOGIC
	);
END DelayUnit;

ARCHITECTURE arch OF Delay_Unit IS

SIGNAl IntCount : STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL Flag_Bit : STD_LOGIC;

BEGIN

	PROCESS (Clk, Reset_N)
		BEGIN
			-- If reset is active low, reset the delay unit to zero
			IF (Reset_N = '0') THEN
				IntCount <= (OTHERS => '0');
			-- Check on every rising edge clock that the int count increments. Once it hits the max value, reset the value of int count back to 0
			ELSIF (Rising_Edge(Clk)) THEN
				IF (IntCount = MaxValue) THEN
					IntCount <= (OTHERS => '0');
				ELSE
					IntCount <= IntCount + 1;
				END IFl
			END IF;
	END PROCESS;
	
	-- This process checks that when max value is equal to int count, output the flag bit to one, or else it is zero.
	PROCESS (IntCount)
		BEGIN
		Flag_Bit <= '1' WHEN IntCount = MaxValue ELSE
								'0';
	END PROCESS;
	
	
	Flag <= Flag_Bit;
	Test_pt <= Flag_Bit;