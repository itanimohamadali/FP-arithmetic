library ieee;
use ieee.std_logic_1164.all;
USE work.fp_pkg.all;
use ieee.numeric_std.all;
use IEEE.math_real.all;

entity real_to_fp is
    port(
        x   :   IN real;
        z   :   IN std_logic;
        fp :   OUT std_logic_vector(31 downto 0)
    );
end real_to_fp;

architecture arch of fp_compare is
signal zero_mantissa : std_logic_vector(22 downto 0) := (others => '0');
signal max_exp : std_logic_vector(7 downto 0) := (others => '1');
begin
    add : process(x,y,z)
    variable s : std_logic;
    variable e: std_logic_vector(7 downto 0);
    variable m: std_logic_vector(23 downto 0);
    
    begin
        if SIGN(x) = 0.0 then
            fp <= "0" & not max_exp & zero_mantissa;
        else
            if SIGN(x) = 1.0 then s := '0';
            e := std_logic_vector(FLOOR(LOG(2, x)));
            else s := '1';
            e := std_logic_vector(CEIL(LOG(2, x*(-1.0))));
            end if;
        end if;
    end process;   
end arch;