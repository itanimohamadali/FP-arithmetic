LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.fp_pkg.all;

ENTITY fp_subtractor_tb IS
END fp_subtractor_tb;
 
ARCHITECTURE behavior OF fp_subtractor_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
   

   --Inputs
   signal  B : std_logic_vector(31 downto 0) := "00100001101010100110001101101010";
   signal  A : std_logic_vector(31 downto 0) := "00000100101100001010010010000001";
   signal  C : std_logic := '0';
 	--Outputs
   signal S : std_logic_vector(31 downto 0) := (others => '0');
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fp_subtractor PORT MAP (
          A,B,C, S);

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

     

      -- insert stimulus here 	
		C <= '1';
      wait for 1000 ns;
      wait;
   end process;

END;
