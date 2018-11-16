LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS 

    COMPONENT spi_block_tx
    PORT(
        clk : IN std_logic;
        reset : IN std_logic;
        data : IN std_logic_vector(7 downto 0);  
        en: in std_logic; 
        empty_buf : OUT std_logic;
        clk_spi: out std_logic;
        tx : OUT std_logic
    );
    END COMPONENT;

    SIGNAL clk :  std_logic;
    SIGNAL reset :  std_logic;
    SIGNAL data :  std_logic_vector(7 downto 0);
    SIGNAL en: std_logic; 
    SIGNAL empty_buf :  std_logic;
    SIGNAL clk_spi: std_logic;
    SIGNAL tx :  std_logic;

BEGIN

-- Please check and add your generic clause manually
    uut: spi_block_tx PORT MAP(
        clk => clk,
        reset => reset,
        data => data,
        en => en,
        empty_buf => empty_buf,
        clk_spi => clk_spi,
        tx => tx
	);


-- *** Test Bench - User Defined Section ***
    tb0 : PROCESS
   BEGIN
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
   END PROCESS;
   
   
   tb2: process
   begin
        reset <= '1';
        wait for 25 ns;
        reset <= '0';
        data <= "11111111";
        en <= '0';
        wait for 40 ns;
        en <= '1';
     	wait for 100 ns;
        data <= "00000000";
        wait for 400 ns;
        en <= '0';
        data <= "10011001";
        wait for 100 ns;
        en <= '1';
        wait for 400 ns;
    end process;
-- *** End Test Bench - User Defined Section ***

END;
