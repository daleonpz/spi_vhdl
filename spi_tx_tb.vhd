
-- VHDL Test Bench Created from source file spi_tx.vhd -- Fri Jun  1 21:45:15 2018

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

	COMPONENT spi_tx
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		edge : IN std_logic;
		data : IN std_logic_vector(7 downto 0);          
		empty_buf : OUT std_logic;
		tx : OUT std_logic
		);
	END COMPONENT;

	SIGNAL clk :  std_logic;
	SIGNAL reset :  std_logic;
	SIGNAL edge :  std_logic;
	SIGNAL data :  std_logic_vector(7 downto 0);
	SIGNAL empty_buf :  std_logic;
	SIGNAL tx :  std_logic;

BEGIN

-- Please check and add your generic clause manually
	uut: spi_tx PORT MAP(
		clk => clk,
		reset => reset,
		edge => edge,
		data => data,
		empty_buf => empty_buf,
		tx => tx
	);


-- *** Test Bench - User Defined Section ***
    tb0 : PROCESS
   BEGIN
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
   END PROCESS;
   
   tb1 : PROCESS
   BEGIN
        edge <= '0'; wait for 50 ns;
        edge <= '1'; wait for 10 ns;
   END PROCESS;
   
   tb2: process
   begin
        reset <= '1';
        wait for 25 ns;
        reset <= '0';
        data <= "11111111";
        wait for 400 ns;
        data <= "10101010";
        wait for 400 ns;
        data <= "01100110";
        wait for 400 ns;
        data <= "10011001";
        wait for 400 ns;
     
    end process;
-- *** End Test Bench - User Defined Section ***

END;
