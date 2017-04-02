library ieee;
use ieee.std_logic_1164.all;

entity gp_combination is
    port(
        g1 : IN std_logic;
        p1 : IN std_logic;
        g2 : IN std_logic;
        p2 : IN std_logic;
        go : OUT std_logic;
        po : OUT std_logic
    );
end gp_combination;

architecture arch of gp_combination is
    begin
        go <= g2 or (g1 and p2);
        po <= p2 and p1;
    end arch;