library ieee;
use ieee.std_logic_1164.all;
USE work.fp_pkg.all;
use ieee.numeric_std.all;

entity fp_adder is
    port(
        x   :   IN std_logic_vector(31 downto 0);
        y   :   IN std_logic_vector(31 downto 0);
        z   :   IN std_logic;
        sum :   OUT std_logic_vector(31 downto 0)
    );
end fp_adder;

architecture arch of fp_adder is

signal final_m1: std_logic_vector(31 downto 0);
signal final_m2: std_logic_vector(31 downto 0);

signal zero_mantissa : std_logic_vector(22 downto 0) := (others => '0');
signal max_exp : std_logic_vector(7 downto 0) := (others => '1');
signal addition_result : std_logic_vector(31 downto 0);
signal overflow : std_logic;
signal result : std_logic_vector(31 downto 0) := (others => '0');

begin
    
    add_positive : ksa_32 PORT MAP (final_m1,final_m2,'0', addition_result, overflow);
    sum <= result;
    add : process(x,y,z)
    variable shift : std_logic_vector(31 downto 0) := (others => '0');
    variable s1 : std_logic;
    variable s2 : std_logic;
    variable e1: std_logic_vector(7 downto 0);
    variable e2: std_logic_vector(7 downto 0);
    variable m1: std_logic_vector(31 downto 0);
    variable m2: std_logic_vector(31 downto 0);
    variable skip : std_logic;
    variable final_mantissa : std_logic_vector(22 downto 0);
    variable check_for_underflow : std_logic;
    begin
        --sum <= result;
        check_for_underflow := '0';
        s1 := x(31);
        skip := '0';
        s2 := y(31);
        e1 := x(30 downto 23);
        e2 := y(30 downto 23);
        m1 := std_logic_vector("1" & x(22 downto 0) & "00000000");
        m2 := std_logic_vector("1" & y(22 downto 0) & "00000000");
         if x = ("0" & max_exp & zero_mantissa) then -- inf
             result <= x;
         elsif y = ("0" & max_exp & zero_mantissa) then -- inf
             result <= y;
         elsif x = ("1" & max_exp & zero_mantissa) then -- neg inf
             result <= x;
         elsif y = ("1" & max_exp & zero_mantissa) then --neg inf
             result <= y;
         elsif (y(30 downto 23) = not max_exp) and (x(22 downto 0) = zero_mantissa) then --zero
             result <= x;
         elsif (x(30 downto 23) = not max_exp) and (x(22 downto 0) = zero_mantissa) then -- zero
             result <= y;
         elsif (x(30 downto 23) = max_exp) and (x(22 downto 0) /= zero_mantissa) then --NaN
             result <= y;
         elsif (y(30 downto 23) = max_exp) and (y(22 downto 0) /= zero_mantissa) then --NaN
             result <= x;
         else
            if e1 > e2 and (unsigned(e1) - unsigned(e2) <= 31) then 
            result(30 downto 23) <= e1;
            shift((31 - to_integer(unsigned(e1)-unsigned(e2))) downto 0) := m2(31 downto to_integer(unsigned(e1)-unsigned(e2)));
            final_m2 <= shift;
            final_m1 <= m1;
            elsif e2 > e1 and (unsigned(e2) - unsigned(e1) <= 31) then 
            result(30 downto 23) <= e2;
            shift((31 - to_integer(unsigned(e2)-unsigned(e1))) downto 0) := m1(31 downto to_integer(unsigned(e2)-unsigned(e1)));
            final_m1 <= shift;
            final_m2 <= m2;
            elsif e1 = e2 then
                result(30 downto 23) <= e1;
                final_m1 <= m1;
                final_m2 <= m2;
            else
                skip := '1';
                if (e1 > e2) then result <= x;
                final_m1 <= m1;
                final_m2 <= "00000000000000000000000000000000";
                else result <= y;
                final_m2 <= m2;
                final_m1 <= "00000000000000000000000000000000";
                end if;
            end if;

            if skip = '1' then
                null;
            elsif s1 = s2 then
                result(31) <= s1;
                if (overflow = '1') then
                    result(30 downto 23) <= std_logic_vector(unsigned(result(30 downto 23)) + 1);
                    final_mantissa := addition_result(31 downto 9);
                else
                    final_mantissa := addition_result(30 downto 8);
                end if;   
            elsif s1 = '1' then
                check_for_underflow := '1';
                final_m1 <= std_logic_vector(unsigned(not(final_m1))+1);
                if (m1 < m2) then
                    result(31) <= s2;
                    final_mantissa := addition_result(31 downto 9);
                elsif (m1 > m2) then
                    result(31) <= s1;
                    final_mantissa := not std_logic_vector(unsigned(addition_result(31 downto 9))-1);
                else
                    result <= "0" & not max_exp & zero_mantissa;
                end if;
            else
                check_for_underflow := '1';
                final_m1 <= std_logic_vector(unsigned(not(final_m1))+1);
                if (m1 < m2) then
                    result(31) <= s2;
                    final_mantissa := not std_logic_vector(unsigned(addition_result(31 downto 9))-1);
                elsif (m1 > m2) then
                    result(31) <= s1;
                    final_mantissa := addition_result(31 downto 9);
                else
                    result <= "0" & not max_exp & zero_mantissa;
                end if;
            end if;

            if check_for_underflow = '1' then
                for i in 22 downto 0 loop
                    if (final_mantissa(22) = '1') then
                        final_mantissa := std_logic_vector(shift_left(unsigned(final_mantissa), 1));
                        result(30 downto 23) <= std_logic_vector(unsigned(result(30 downto 23)) - 1);
                        exit;
                    else 
                        final_mantissa := std_logic_vector(shift_left(unsigned(final_mantissa), 1));
                        result(30 downto 23) <= std_logic_vector(unsigned(result(30 downto 23)) - 1);
                    end if;
                end loop;
            end if;
            if skip = '0' then
            result(22 downto 0) <= final_mantissa;
            end if;
            if result(30 downto 23) = max_exp then
                result(22 downto 0) <= zero_mantissa;
            end if;
         end if; 
    end process;   
end arch;