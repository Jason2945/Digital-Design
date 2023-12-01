LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sr_flipflop IS
	PORT(
		set, reset, clk : IN std_logic;
		q, qnot : OUT std_logic
		);
END sr_flipflop;

ARCHITECTURE arch OF sr_flipflop IS

BEGIN

PROCESS(clk)

	VARIABLE temp : std_logic; 
	
	BEGIN
		IF (clk = '1' AND clk'EVENT) THEN
			IF (set='0' AND reset='0') THEN
				temp := temp;
			ELSIF(set='1' AND reset='1') THEN
				temp :='Z';
			ELSIF(set='0' AND reset='1') THEN
				temp := '0';
			ELSE
				temp := '1';
			END IF;
		END IF;
	q <= temp;
	qnot <= NOT(temp);
END PROCESS;

END arch;