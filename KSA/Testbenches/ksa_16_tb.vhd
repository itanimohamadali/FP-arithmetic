LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY ksa_16_tb IS
END ksa_16_tb;
 
ARCHITECTURE behavior OF ksa_16_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ksa_16
    PORT(
        x   :   IN std_logic_vector(15 downto 0);
        y   :   IN std_logic_vector(15 downto 0);
        cin :   IN std_logic;
        sum :   OUT std_logic_vector(15 downto 0);
        cout:   OUT std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal  A : std_logic_vector(15 downto 0) := "1000010000100000";
   signal  B : std_logic_vector(15 downto 0) := "1000000010000000";
   signal Carry_in : std_logic := '0';

 	--Outputs
   signal S : std_logic_vector(15 downto 0);
   signal Carry_out : std_logic;
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ksa_16 PORT MAP (
          A,B,Carry_in, S, Carry_out
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

     

      -- insert stimulus here 	
		

      wait;
   end process;

END;
