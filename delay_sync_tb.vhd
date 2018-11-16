
-- VHDL Test Bench Created from source file delay_sync.vhd -- Wed May 30 03:06:58 2018

--
-- Notes: 
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Lattice recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "source->import"
-- menu in the ispLEVER Project Navigator to import the testbench.
-- Then edit the user defined section below, adding code to generate the 
-- stimulus for your design.
-- 3) VHDL simulations will produce errors if there are Lattice FPGA library 
-- elements in your design that require the instantiation of GSR, PUR, and
-- TSALL and they are not present in the testbench. For more information see
-- the How To section of online help.  
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS 

	COMPONENT delay_sync 
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		d : IN std_logic;          
		q : OUT std_logic
		);
	END COMPONENT;

	SIGNAL clk :  std_logic;
	SIGNAL reset :  std_logic;
	SIGNAL d :  std_logic;
	SIGNAL q :  std_logic;

BEGIN

-- Please check and add your generic clause manually
	uut: delay_sync PORT MAP(
		clk => clk,
		reset => reset,
		d => d,
		q => q
	);


-- *** Test Bench - User Defined Section ***
    tb : PROCESS
    BEGIN
            clk <= '1'; wait for 15 ns;
            clk <= '0'; wait for 15 ns;
    END PROCESS;
   
    tb1: process
    begin
        reset <= '1';
	wait for 20ns;
	reset <= '0';
        d <= '1'; wait for 50 ns;
        d <= '0'; wait for 50 ns;
        d <= '1'; wait for 50 ns;
        d <= '0'; wait for 50 ns;
    end process;
-- *** End Test Bench - User Defined Section ***

END;
