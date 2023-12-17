LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY Binary_to_SSD IS
PORT(
	input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	select_input : IN STD_LOGIC;
	hex2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	hex1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	hex0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END Binary_to_SSD;

ARCHITECTURE beh OF Binary_to_SSD IS

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
	
	SIGNAL input_sig, abs_r : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL input_msb, input_lsb : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL tens_dig, ones_dig : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL hhex0, hhex1, dhex0, dhex1, dhex2 : STD_LOGIC_VECTOR(6 DOWNTO 0);

BEGIN

	input_sig <= input;
	input_msb <= input_sig(7 DOWNTO 4);
	input_lsb <= input_sig (3 DOWNTO 0);
	
	check_neg : PROCESS(input_sig, select_input)
	BEGIN
		IF (select_input = '0') THEN
			IF (input_sig(7) = '1') THEN
				-- Two's complement
				abs_r <= (NOT(input_sig) + "00000001");
			ELSE
				abs_r <= input_sig;
			END IF;
		ELSE
			abs_r <= "00000000";
		END IF;
	END PROCESS;
	
	tens_dig <= STD_LOGIC_VECTOR(UNSIGNED(abs_r)/10);
	ones_dig <= STD_LOGIC_VECTOR(UNSIGNED(abs_r)rem 10);

	output_hex2 : PROCESS(input_sig, select_input)
	BEGIN
		IF (select_input = '0') THEN
			CASE input_sig(7) IS
				WHEN '1' => dhex2 <= DASH;
				WHEN others => dhex2 <= BLANK;
			END CASE;
		ELSE
			dhex2 <= BLANK;
		END IF;
	END PROCESS;
	
	msb_hex : PROCESS(input_msb, select_input)
	BEGIN
		IF (select_input = '1') THEN
			CASE input_msb IS
				WHEN "0000" => hhex1 <= ZERO;
				WHEN "0001" => hhex1 <= ONE;
				WHEN "0010" => hhex1 <= TWO;
				WHEN "0011" => hhex1 <= THREE;
				WHEN "0100" => hhex1 <= FOUR;
				WHEN "0101" => hhex1 <= FIVE;
				WHEN "0110" => hhex1 <= SIX;
				WHEN "0111" => hhex1 <= SEVEN;
				WHEN "1000" => hhex1 <= EIGHT;
				WHEN "1001" => hhex1 <= NINE;
				WHEN "1010" => hhex1 <= LETTERA;
				WHEN "1011" => hhex1 <= LETTERB;
				WHEN "1100" => hhex1 <= LETTERC;
				WHEN "1101" => hhex1 <= LETTERD;
				WHEN "1110" => hhex1 <= LETTERE;
				WHEN "1111" => hhex1 <= LETTERF;
				WHEN others => hhex1 <= BLANK;	
			END CASE;
		ELSE
			hhex1 <= BLANK;
		END IF;
	END PROCESS;
	
	lsb_hex : PROCESS(input_lsb, select_input)
	BEGIN
		IF (select_input = '1') THEN
			CASE input_lsb IS
				WHEN "0000" => hhex0 <= ZERO;
				WHEN "0001" => hhex0 <= ONE;
				WHEN "0010" => hhex0 <= TWO;
				WHEN "0011" => hhex0 <= THREE;
				WHEN "0100" => hhex0 <= FOUR;
				WHEN "0101" => hhex0 <= FIVE;
				WHEN "0110" => hhex0 <= SIX;
				WHEN "0111" => hhex0 <= SEVEN;
				WHEN "1000" => hhex0 <= EIGHT;
				WHEN "1001" => hhex0 <= NINE;
				WHEN "1010" => hhex0 <= LETTERA;
				WHEN "1011" => hhex0 <= LETTERB;
				WHEN "1100" => hhex0 <= LETTERC;
				WHEN "1101" => hhex0 <= LETTERD;
				WHEN "1110" => hhex0 <= LETTERE;
				WHEN "1111" => hhex0 <= LETTERF;
				WHEN others => hhex0 <= BLANK;
			END CASE;
		ELSE
			hhex0 <= BLANK;
		END IF;
	END PROCESS;
	
	ten_decimal : PROCESS(select_input, tens_dig)
	BEGIN
		IF (select_input = '0') THEN
			CASE tens_dig IS
				WHEN "00000000" => dhex1 <= ZERO;
				WHEN "00000001" => dhex1 <= ONE;
				WHEN "00000010" => dhex1 <= TWO;
				WHEN "00000011" => dhex1 <= THREE;
				WHEN "00000100" => dhex1 <= FOUR;
				WHEN "00000101" => dhex1 <= FIVE;
				WHEN "00000110" => dhex1 <= SIX;
				WHEN "00000111" => dhex1 <= SEVEN;
				WHEN "00001000" => dhex1 <= EIGHT;
				WHEN "00001001" => dhex1 <= NINE;
				WHEN others => dhex1 <= BLANK;
			END CASE;
		ELSE
			dhex1 <= BLANK;
		END IF;
	END PROCESS;
	
	ones_decimal : PROCESS(select_input, ones_dig)
	BEGIN
		IF (select_input = '0') THEN
			CASE ones_dig IS
				WHEN "00000000" => dhex0 <= ZERO;
				WHEN "00000001" => dhex0 <= ONE;
				WHEN "00000010" => dhex0 <= TWO;
				WHEN "00000011" => dhex0 <= THREE;
				WHEN "00000100" => dhex0 <= FOUR;
				WHEN "00000101" => dhex0 <= FIVE;
				WHEN "00000110" => dhex0 <= SIX;
				WHEN "00000111" => dhex0 <= SEVEN;
				WHEN "00001000" => dhex0 <= EIGHT;
				WHEN "00001001" => dhex0 <= NINE;
				WHEN others => dhex0 <= BLANK;
			END CASE;
		ELSE
			dhex0 <= BLANK;
		END IF;
	END PROCESS;
	
	connect_output : PROCESS(dhex2, dhex1, dhex0, hhex1, hhex0, select_input)
	BEGIN
		hex2 <= dhex2;
		IF (select_input = '1') THEN
			hex1 <= hhex1;
			hex0 <= hhex0;
		ELSE
			hex1 <= dhex1;
			hex0 <= dhex0;
		END IF;
	END PROCESS;
	
END beh;