LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY boolean1 IS
	PORT(
		a, b, c, d : IN std_logic;
		x : OUT std_logic);
END boolean1;

ARCHITECTURE arch OF boolean1 IS
	BEGIN
		x <= (a AND b) OR (c AND d);
END arch;