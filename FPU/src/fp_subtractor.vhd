library ieee;
use ieee.std_logic_1164.all;
USE work.fp_pkg.all;
use ieee.numeric_std.all;

entity fp_subtractor is
    port(
        x   :   IN std_logic_vector(31 downto 0);
        y   :   IN std_logic_vector(31 downto 0);
        z   :   IN std_logic;
        result :   OUT std_logic_vector(31 downto 0)
    );
end fp_subtractor;

architecture arch of fp_subtractor is
signal y_prime : std_logic_vector(31 downto 0) := y;
begin
    y_prime(31) <= not y(31);
    uut: fp_adder PORT MAP (x,y_prime,z,result);
end arch;