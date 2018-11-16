-- Update data to send

USE ieee.numeric_std.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS 

	COMPONENT spi_block_rx
	PORT(
            clk : IN std_logic;
            reset : IN std_logic;
            clk_spi: in std_logic;
            rx: in std_logic;
            data: out std_logic_vector (7 downto 0);
            full_buf: out std_logic
            );
	END COMPONENT;

	SIGNAL clk :  std_logic;
	SIGNAL reset :  std_logic;
	SIGNAL clk_spi :  std_logic;
	SIGNAL rx :  std_logic;
	SIGNAL data :  std_logic_vector(7 downto 0);
	SIGNAL full_buf :  std_logic;

BEGIN

-- Please check and add your generic clause manually
	uut: spi_block_rx PORT MAP(
		clk => clk,
		reset => reset,
		clk_spi => clk_spi,
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
        rx <= '0';
        clk_spi <= '1'; wait for 20 ns; 
        clk_spi <= '0'; wait for 20 ns;
        -- reception starts here 0101 0101
        clk_spi <= '1'; wait for 15 ns; 
        rx <= '1'; wait for 5 ns;
        clk_spi <= '0'; wait for 20 ns;
        
        clk_spi <= '1'; wait for 15 ns; 
        rx <= '0'; wait for 5 ns;
        clk_spi <= '0'; wait for 20 ns;
        
        clk_spi <= '1'; wait for 15 ns; 
        rx <= '1'; wait for 5 ns;
        clk_spi <= '0'; wait for 20 ns;
        
        clk_spi <= '1'; wait for 15 ns; 
        rx <= '0'; wait for 5 ns;
        clk_spi <= '0'; wait for 20 ns;
       
        clk_spi <= '1'; wait for 15 ns; 
        rx <= '1'; wait for 5 ns;
        clk_spi <= '0'; wait for 20 ns;
        
        clk_spi <= '1'; wait for 15 ns; 
        rx <= '0'; wait for 5 ns;
        clk_spi <= '0'; wait for 20 ns;
        
        clk_spi <= '1'; wait for 15 ns; 
        rx <= '1'; wait for 5 ns;
        clk_spi <= '0'; wait for 20 ns;
        
        clk_spi <= '1'; wait for 15 ns; 
        rx <= '0'; wait for 5 ns;
        clk_spi <= '0'; wait for 20 ns;
        
        -- two more clk_spi
        clk_spi <= '1'; wait for 15 ns; 
        rx <= '0'; wait for 5 ns;
        clk_spi <= '0'; wait for 20 ns;
        
        clk_spi <= '1'; wait for 15 ns; 
        rx <= '0'; wait for 5 ns;
        clk_spi <= '0'; wait for 20 ns;
 
        wait for 200 ns;

        -- sync
        rx <= '0';
        clk_spi <= '1'; wait for 20 ns; 
        clk_spi <= '0'; wait for 20 ns;
        -- reception of 1100 1100 starts here 
        clk_spi <= '1'; wait for 15 ns; 
        rx <= '0'; wait for 5 ns;
        clk_spi <= '0'; wait for 20 ns;
        
        clk_spi <= '1'; wait for 15 ns; 
        rx <= '0'; wait for 5 ns;
        clk_spi <= '0'; wait for 20 ns;
        
        clk_spi <= '1'; wait for 15 ns; 
        rx <= '1'; wait for 5 ns;
        clk_spi <= '0'; wait for 20 ns;
        
        clk_spi <= '1'; wait for 15 ns; 
        rx <= '1'; wait for 5 ns;
        clk_spi <= '0'; wait for 20 ns;
        
        clk_spi <= '1'; wait for 15 ns; 
        rx <= '0'; wait for 5 ns;
        clk_spi <= '0'; wait for 20 ns;
        
        clk_spi <= '1'; wait for 15 ns; 
        rx <= '0'; wait for 5 ns;
        clk_spi <= '0'; wait for 20 ns;
        
        clk_spi <= '1'; wait for 15 ns; 
        rx <= '1'; wait for 5 ns;
        clk_spi <= '0'; wait for 20 ns;
        
        clk_spi <= '1'; wait for 15 ns; 
        rx <= '1'; wait for 5 ns;
        clk_spi <= '0'; wait for 20 ns;
        
        -- two more clk_spi
        clk_spi <= '1'; wait for 15 ns; 
        rx <= '0'; wait for 5 ns;
        clk_spi <= '0'; wait for 20 ns;
        
        clk_spi <= '1'; wait for 15 ns; 
        rx <= '0'; wait for 5 ns;
        clk_spi <= '0'; wait for 20 ns;
 
        wait for 200 ns;
   END PROCESS;
   
-- *** End Test Bench - User Defined Section ***

END;

