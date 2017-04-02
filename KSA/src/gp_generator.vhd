library ieee;
use ieee.std_logic_1164.all;

entity gp_generator IS
	port(
			x : IN std_logic;
			y : IN std_logic;
			g : OUT std_logic;
			p : OUT std_logic
		);
end gp_generator;

architecture arch of gp_generator IS
begin
		g <= x AND y;
		p <= x XOR y;
end arch;