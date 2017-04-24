LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE fp_pkg IS

	--g,p generator--
	COMPONENT gp_generator IS
		PORT(
			x : IN std_logic;
			y : IN std_logic;
			g : OUT std_logic;
			p : OUT std_logic
		);
	END COMPONENT;

	--carry operator--
	COMPONENT gp_combination IS
		PORT(
			g1 : IN std_logic;
			p1 : IN std_logic;
			g2 : IN std_logic;
			p2 : IN std_logic;
			go : OUT std_logic;
			po : OUT std_logic
		);
	END COMPONENT;

    COMPONENT ksa_32
    PORT(
        x   :   IN std_logic_vector(31 downto 0);
        y   :   IN std_logic_vector(31 downto 0);
        cin :   IN std_logic;
        sum :   OUT std_logic_vector(31 downto 0);
        cout:   OUT std_logic
        );
    END COMPONENT;

    COMPONENT ksa_16
    PORT(
        x   :   IN std_logic_vector(15 downto 0);
        y   :   IN std_logic_vector(15 downto 0);
        cin :   IN std_logic;
        sum :   OUT std_logic_vector(15 downto 0);
        cout:   OUT std_logic
        );
    END COMPONENT;
	
	COMPONENT fp_adder is
    port(
        x   :   IN std_logic_vector(31 downto 0);
        y   :   IN std_logic_vector(31 downto 0);
        z   :   IN std_logic;
        sum :   OUT std_logic_vector(31 downto 0)
    );
    END COMPONENT;

	COMPONENT fp_subtractor is
    port(
        x   :   IN std_logic_vector(31 downto 0);
        y   :   IN std_logic_vector(31 downto 0);
        z   :   IN std_logic;
        result :   OUT std_logic_vector(31 downto 0)
    );
    END COMPONENT;

    COMPONENT fp_compare is
    port(
        x   :   IN std_logic_vector(31 downto 0);
        y   :   IN std_logic_vector(31 downto 0);
        z   :   IN std_logic;
        comp :   OUT std_logic_vector(1 downto 0)
    );
    end COMPONENT;
END fp_pkg;
