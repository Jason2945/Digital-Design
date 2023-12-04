LIBRARY ieee ;
USE ieee.std_logic_1164.all;

-- ENTITY

ENTITY ASCII_Name IS
PORT ( X,B,C,D,E,F,Y : IN STD_LOGIC;
		 J,A,S,O,N,W,G,first_cond,last_cond,first_sel,last_sel : OUT STD_LOGIC);
END ASCII_Name;

-- ARCHITECTURE

ARCHITECTURE beh OF ASCII_Name IS
signal selects : STD_LOGIC_VECTOR (6 DOWNTO 0);
BEGIN
selects <= X & B & C & D & E & F & Y;

J <= (X AND B AND NOT C AND D AND NOT E AND F AND NOT Y);
A <= (X AND B AND NOT C AND NOT D AND NOT E AND NOT F AND Y);
S <= (X AND B AND C AND NOT D AND NOT E AND F AND Y);
O <= (X AND B AND NOT C AND D AND E AND F AND Y);
N <= (X AND B AND NOT C AND D AND E AND F AND NOT Y);
W <= (X AND B AND C AND NOT D AND E AND F AND Y);
G <= (X AND B AND NOT C AND NOT D AND E AND F AND Y);

first_cond <= '1' WHEN selects = "1101010"or selects ="1100001" or selects ="1110011"or selects ="1101111"or selects ="1101110" ELSE '0';

last_cond <= '1' WHEN selects = "1110111"or selects ="1100001"or selects ="1101110"or selects ="1100111" ELSE '0';


WITH selects SELECT
	first_sel <= '1' WHEN "1101010"|"1100001"|"1110011"|"1101111"|"1101110",'0' WHEN OTHERS;
	
WITH selects SELECT
	last_sel <= '1' WHEN "1110111"|"1100001"|"1101110"|"1100111",'0' WHEN OTHERS;
	
End beh;
