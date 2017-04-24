library ieee;
use ieee.std_logic_1164.all;
USE work.fp_pkg.all;

entity ksa_16 is
    port(
        x   :   IN std_logic_vector(15 downto 0);
        y   :   IN std_logic_vector(15 downto 0);
        cin :   IN std_logic;
        sum :   OUT std_logic_vector(15 downto 0);
        cout:   OUT std_logic
    );
end ksa_16;

architecture arch of ksa_16 is


    signal g_in : std_logic_vector(15 downto 0);
    signal p_in : std_logic_vector(15 downto 0);

    signal g_1  : std_logic_vector(15 downto 0);
    signal p_1  : std_logic_vector(15 downto 0);

    signal g_2  : std_logic_vector(15 downto 0);
    signal p_2  : std_logic_vector(15 downto 0);
    
    signal g_3  : std_logic_vector(15 downto 0);
    signal p_3  : std_logic_vector(15 downto 0);

    signal g_4  : std_logic_vector(15 downto 0);
    signal p_4  : std_logic_vector(15 downto 0);

    signal c    : std_logic_vector(15 downto 0);

begin
    stage0 : for i in 0 to 15 generate
        gpgen : gp_generator PORT MAP (x(i), y(i), g_in(i), p_in(i));
    end generate ; -- stage0

    stage1buff : for i in 0 to 0 generate
        g_1(i) <= g_in(i);
        p_1(i) <= p_in(i);
    end generate ; -- stage1buff

    stage1 : for i in 0 to 14 generate
        gpgen : gp_combination PORT MAP (g_in(i), p_in(i), g_in(i+1), p_in(i+1), g_1(i+1), p_1(i+1));
    end generate ; -- stage1

    stage2buff : for i in 0 to 1 generate
        g_2(i) <= g_1(i);
        p_2(i) <= p_1(i);
    end generate ; -- stage2buff

    stage2 : for i in 0 to 13 generate
        gpgen : gp_combination PORT MAP (g_1(i), p_1(i), g_1(i+2), p_1(i+2), g_2(i+2), p_2(i+2));
    end generate ; -- stage2

    stage3buff : for i in 0 to 3 generate
        g_3(i) <= g_2(i);
        p_3(i) <= p_2(i);
    end generate ; -- stage3buff

    stage3 : for i in 0 to 11 generate
        gpgen : gp_combination PORT MAP (g_2(i), p_2(i), g_2(i+4), p_2(i+4), g_3(i+4), p_3(i+4));
    end generate ; -- stage3

    stage4buff : for i in 0 to 7 generate
        g_4(i) <= g_3(i);
        p_4(i) <= p_3(i);
    end generate ; -- stage4buff

    stage4 : for i in 0 to 7 generate
        gpgen : gp_combination PORT MAP (g_3(i), p_3(i), g_3(i+8), p_3(i+8), g_4(i+8), p_4(i+8));
    end generate ; -- stage4

    c_gen : for i in 0 to 15 generate
        c(i) <= g_4(i) or (cin AND p_4(i));
    end generate ; -- c_gen

    cout <= c(15);
    sum(0) <= cin XOR p_in(0);

    addin : for i in 1 to 15 generate
        sum(i) <= c(i-1) XOR p_in(i);
    end generate ; -- addin
end arch;
