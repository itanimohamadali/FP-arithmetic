library ieee;
use ieee.std_logic_1164.all;
USE work.fp_pkg.all;
use ieee.numeric_std.all;

entity fp_compare is
    port(
        x   :   IN std_logic_vector(31 downto 0);
        y   :   IN std_logic_vector(31 downto 0);
        z   :   IN std_logic;
        comp :   OUT std_logic_vector(1 downto 0)
    );
end fp_compare;

architecture arch of fp_compare is
signal zero_mantissa : std_logic_vector(22 downto 0) := (others => '0');
signal max_exp : std_logic_vector(7 downto 0) := (others => '1');
begin
    add : process(x,y,z)
    variable s1 : std_logic;
    variable s2 : std_logic;
    variable e1: std_logic_vector(7 downto 0);
    variable e2: std_logic_vector(7 downto 0);
    variable m1: std_logic_vector(22 downto 0);
    variable m2: std_logic_vector(22 downto 0);
    begin
        s1 := x(31);
        s2 := y(31);
        e1 := x(30 downto 23);
        e2 := y(30 downto 23);
        m1 := x(22 downto 0);
        m2 := y(22 downto 0);

        if x(30 downto 23) = max_exp and x(22 downto 0) /= zero_mantissa then
            comp <= "11";
        elsif y(30 downto 23) = max_exp and y(22 downto 0) /= zero_mantissa then
            comp <= "11";
        elsif s1 = '1' and s2 = '0' then
            comp <= "01";
        elsif s1 = '0' and s2 = '1' then
            comp <= "10";
        else
            if e1 > e2 then
                comp <= "10";
            elsif e1 < e2 then
                comp <= "01";
            else
                if m1 > m2 then
                    comp <= "10";
                elsif m1 < m2 then
                    comp <= "01";
                else
                    comp <= "00";
                end if;
            end if;
        end if;
    end process;   
end arch;