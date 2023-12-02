LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY JK_Flip_Flop IS
	PORT (
		clk, j, k, clear, preset : IN std_logic;
		q :BUFFER std_logic -- This allows the q to be read as input or output
		);
END JK_Flip_Flop;

ARCHITECTURE arch OF JK_Flip_Flop IS

SIGNAL jk : std_logic_vector(1 downto 0);

BEGIN

	jk <= J & k; -- Concatenate j & k
	PROCESS(clk, clear, preset)
	BEGIN
		IF (clear = '0') THEN -- Active Low
			q <= '0';
		ELSIF (preset = '0') THEN -- Active Low
			q <= '1';
		ELSIF (clk'EVENT and clk = '1') THEN -- Check for positive edge trigger
			CASE jk IS
				WHEN "00" => q <= q; -- HOLD
				WHEN "01" => q <= '0'; --q gets 0
				WHEN "10" => q <= '1'; --q gets 1
				WHEN "11" => q <= NOT q; --invert q because of Toggle
				WHEN OTHERS => q <= q;
			END CASE;
		END IF;
	END PROCESS;
END arch;