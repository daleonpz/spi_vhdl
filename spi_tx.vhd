-- SPI transmitter 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity spi_tx is
    port (  clk: in std_logic;
            reset: in std_logic;
            edge: in std_logic;  
            data: in std_logic_vector (7 downto 0);
            empty_buf: out std_logic;
            tx: out std_logic
         );
end entity spi_tx; 

architecture arch of spi_tx is
    type STATES is (IDLE, SEND, STOP);
    signal state_next, state_reg: STATES;
    signal buf_next, buf_reg: std_logic_vector (7 downto 0);  
    signal count_next, count_reg: unsigned (3 downto 0); 
    signal empty_next, empty_reg: std_logic;
    signal tx_next, tx_reg: std_logic;  
    constant DBIT: integer := 8;   
begin

    -- FSMD: state and data registers
    process ( clk, reset)
    begin
        if (reset = '1') then
            state_reg <= IDLE;
            buf_reg <= (others => '0');
            count_reg <= (others => '0');
            empty_reg <= '1';
            tx_reg <= '0';
	elsif ( rising_edge(clk) ) then 
            state_reg <= state_next;
            buf_reg <= buf_next;
            count_reg <= count_next;
            empty_reg <= empty_next;  
            tx_reg <= tx_next; 
        end if;
    end process; 
    
    -- Control logic and data path
    process (edge, state_reg, count_reg, buf_reg,
         empty_reg, tx_reg, data)
    begin
        state_next <= state_reg;
        count_next <= count_reg;
        buf_next <= buf_reg; 
        empty_next <= '1';
        tx_next <= '0';
        
        case state_reg is
            when IDLE =>
                if (edge ='1') then
                    state_next <= SEND;
                    buf_next <= data; 
                end if; 
            when SEND =>  
                empty_next <= '0';
                if ( edge ='1') then 
                    if ( count_reg = DBIT  ) then
                        count_next <= (others => '0');
                        state_next <= STOP;
            --            empty_next <= '1';
                    else 
                        count_next <= (count_reg + 1);
                        -- LSB is sent first
                        -- so we need to rotate the buffer
                        buf_next <= '0' & buf_reg(7 downto 1);
                        tx_next <= buf_reg(0);
                    end if; 
                else
                    tx_next <= tx_reg;
                end if;
            when STOP => 
                empty_next <= '0';
                if ( edge = '1') then
                    empty_next <= '1';
                    state_next <= IDLE;
                end if;
        end case;
    end process;  
    
    empty_buf <= empty_reg;
    tx <= tx_reg;
end architecture arch;
