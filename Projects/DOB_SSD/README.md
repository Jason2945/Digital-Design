- Create a project to display my birthday (09-12-97) on the DE10-Standard Board.

- Created a truth table to find out the values of a-g on the seven segment display board. X,Y,Z are the switch inputs.

- Used boolean algebra and K-maps to simplify equations.

- Programmed the board and display it in DE-10 Birthday.mp4

Create a truth table with DOB 09/12/97

SSD is inverted, so to display LED 0 is high.

|X|Y|Z|Date Of Birth|a|b|c|d|e|f|g|
|-|-|-|-|-|-|-|-|-|-|-|
|0|0|0|0|0|0|0|0|0|0|1|
|0|0|1|9|0|0|0|1|1|0|0|
|0|1|0|-|1|1|1|1|1|1|0|
|0|1|1|1|1|0|0|1|1|1|1|
|1|0|0|2|0|0|1|0|0|1|0|
|1|0|1|-|1|1|1|1|1|1|0|
|1|1|0|9|0|0|0|1|1|0|0|
|1|1|1|7|0|0|0|1|1|1|1|

# Simplified Boolean Equation For Birthday

- a = (XNOT * Y) + (X * YNOT * Z)
- b = (XNOT * Y * ZNOT) + (X * YNOT * Z)
- c = (X * YNOT) + (XNOT * Y * ZNOT)
- d = Y + Z
- e = d
- f = (XNOT * Y) + (X * YNOT) + (X * Z)
- g = (Y * Z) + (XNOT * YNOT * ZNOT)