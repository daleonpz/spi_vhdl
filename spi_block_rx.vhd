-- spi block rx

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity spi_block_rx is
    port (  clk: in std_logic; 
            reset: in std_logic; 
            clk_spi: in std_logic;
            rx: in std_logic;
            data: out std_logic_vector (7 downto 0);
            full_buf: out std_logic
        );
end entity spi_block_rx; 

architecture arch of spi_block_rx is 

component spi_rx 
    port (  clk: in std_logic;
            reset: in std_logic;
            edge: in std_logic;  
            rx: in std_logic;
            data: out std_logic_vector (7 downto 0);
            full_buf: out std_logic
         );
end component;

component  delay_sync 
    port (  
            clk: in std_logic;
            reset: in std_logic;
            d: in std_logic;
            q: out std_logic
         );
end component;

component rising_edge_detector 
    port (  
            clk: in std_logic;
            reset: in std_logic; 
            clk_in: in std_logic;
            edge: out std_logic
         ); 
end component; 

-- Internal signals
signal iclk_delayed: std_logic; 
signal irising_edge: std_logic;

begin

    SYNCHRONIZER: delay_sync port map(
        clk => clk,
        reset => reset,
        d => clk_spi,
        q => iclk_delayed);

    RISING_EDGE_TX: rising_edge_detector port map(
        clk => clk,
        reset => reset,
	clk_in => iclk_delayed,
	edge => irising_edge);
 
    SPI_RX_Blk: spi_rx port map(
        clk => clk,
	reset => reset,
	edge => irising_edge,
	rx => rx,
	data => data,
        full_buf => full_buf);

end architecture arch; 
