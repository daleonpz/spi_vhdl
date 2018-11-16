-- spi block tx

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity spi_block_tx is
    port (  clk: in std_logic; 
            reset: in std_logic; 
            data: in std_logic_vector (7 downto 0);
            en: in std_logic; 
            empty_buf: out std_logic; 
            clk_spi: out std_logic;
            tx: out std_logic
        );
end entity spi_block_tx; 

architecture arch of spi_block_tx is 

component clk_generator
    port (
            clk : in std_logic;
	    reset : in std_logic;
	    en : in std_logic;          
	    clk_out : out std_logic
	);
end component;

component spi_tx 
    port (
            clk: in std_logic;
            reset: in std_logic;
            edge: in std_logic;  
            data: in std_logic_vector (7 downto 0);
            empty_buf: out std_logic;
            tx: out std_logic
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
signal iclk_spi: std_logic;
signal iclk_delayed: std_logic; 
signal irising_edge: std_logic;

begin

    SPI_CLK_GEN: clk_generator port map (
        clk => clk,
        reset => reset, 
        en => en,
        clk_out => iclk_spi);  
         
    DELAY_1: delay_sync port map(
        clk => clk,
        reset => reset,
        d => iclk_spi,
        q => iclk_delayed);

    RISING_EDGE_TX: rising_edge_detector port map(
        clk => clk,
        reset => reset,
	clk_in => iclk_delayed,
	edge => irising_edge);
 
    SPI_TX_Blk: spi_tx port map(
        clk => clk,
	reset => reset,
	edge => irising_edge,
	data => data,
	empty_buf => empty_buf,
	tx => tx);

    clk_spi <= iclk_delayed; 
end architecture arch; 
