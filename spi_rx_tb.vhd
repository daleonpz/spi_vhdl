
-- VHDL Test Bench Created from source file spi_rx.vhd -- Fri Jun  1 21:45:15 2018

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

	COMPONENT spi_rx
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		edge : IN std_logic;
		rx: IN std_logic;
		data : out std_logic_vector(7 downto 0);          
		full_buf : OUT std_logic
		);
	END COMPONENT;

	SIGNAL clk :  std_logic;
	SIGNAL reset :  std_logic;
	SIGNAL edge :  std_logic;
	SIGNAL rx :  std_logic;
	SIGNAL data :  std_logic_vector(7 downto 0);
	SIGNAL full_buf :  std_logic;

BEGIN

-- Please check and add your generic clause manually
	uut: spi_rx PORT MAP(
		clk => clk,
		reset => reset,
		edge => edge,
		rx => rx,
		data => data,
		full_buf => full_buf
	);


-- *** Test Bench - User Defined Section ***
    tb0 : PROCESS
   BEGIN
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
   END PROCESS;
   
   tb1 : PROCESS
   BEGIN
        rx <= '0';
        reset <= '1';
        wait for 15 ns;
        reset <= '0';
        wait for 60 ns;
        
        -- sync
        edge <= '0'; wait for 30 ns; 
        rx <= '0'; wait for 20 ns;
        edge <= '1'; wait for 10 ns;
        -- transmition starts here 0011 0011
        edge <= '0'; wait for 30 ns; 
        rx  <= '1'; wait for 20 ns;
        edge <= '1'; wait for 10 ns;
        
        edge <= '0'; wait for 30 ns; 
        rx  <= '1'; wait for 20 ns;
        edge <= '1'; wait for 10 ns;
        
        edge <= '0'; wait for 30 ns; 
        rx  <= '0'; wait for 20 ns;
        edge <= '1'; wait for 10 ns;
        
        edge <= '0'; wait for 30 ns; 
        rx  <= '0'; wait for 20 ns;
        edge <= '1'; wait for 10 ns;
       
        edge <= '0'; wait for 30 ns; 
        rx  <= '1'; wait for 20 ns;
        edge <= '1'; wait for 10 ns;
        
        edge <= '0'; wait for 30 ns; 
        rx  <= '1'; wait for 20 ns;
        edge <= '1'; wait for 10 ns;
        
        edge <= '0'; wait for 30 ns; 
        rx  <= '0'; wait for 20 ns;
        edge <= '1'; wait for 10 ns;
        
        edge <= '0'; wait for 30 ns; 
        rx  <= '0'; wait for 20 ns;
        edge <= '1'; wait for 10 ns;
        
 
        -- one more clk_spi
        edge <= '0'; wait for 30 ns; 
        rx  <= '0'; wait for 20 ns;
        edge <= '1'; wait for 10 ns;
        
        edge <= '0'; 
        wait for 200 ns;
        
         -- sync
        edge <= '0'; wait for 30 ns; 
        rx <= '0'; wait for 20 ns;
        edge <= '1'; wait for 10 ns;
        -- transmition starts here 0110 0110
        edge <= '0'; wait for 30 ns; 
        rx  <= '0'; wait for 20 ns;
        edge <= '1'; wait for 10 ns;
        
        edge <= '0'; wait for 30 ns; 
        rx  <= '1'; wait for 20 ns;
        edge <= '1'; wait for 10 ns;
        
        edge <= '0'; wait for 30 ns; 
        rx  <= '1'; wait for 20 ns;
        edge <= '1'; wait for 10 ns;
        
        edge <= '0'; wait for 30 ns; 
        rx  <= '0'; wait for 20 ns;
        edge <= '1'; wait for 10 ns;
       
        edge <= '0'; wait for 30 ns; 
        rx  <= '0'; wait for 20 ns;
        edge <= '1'; wait for 10 ns;
        
        edge <= '0'; wait for 30 ns; 
        rx  <= '1'; wait for 20 ns;
        edge <= '1'; wait for 10 ns;
        
        edge <= '0'; wait for 30 ns; 
        rx  <= '1'; wait for 20 ns;
        edge <= '1'; wait for 10 ns;
        
        edge <= '0'; wait for 30 ns; 
        rx  <= '0'; wait for 20 ns;
        edge <= '1'; wait for 10 ns;
        
 
         -- one more clk_spi
        edge <= '0'; wait for 30 ns; 
        rx  <= '0'; wait for 20 ns;
        edge <= '1'; wait for 10 ns;
        
        edge <= '0'; 
        wait for 500 ns;
   END PROCESS;
   
-- *** End Test Bench - User Defined Section ***

END;
