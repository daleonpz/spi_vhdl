-- SPI receiver 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity spi_rx is
    port (  clk: in std_logic;
            reset: in std_logic;
            edge: in std_logic;  
            rx: in std_logic;
            data: out std_logic_vector (7 downto 0);
            full_buf: out std_logic
         );
end entity spi_rx; 

architecture arch of spi_rx is
    type STATES is (IDLE, RECEIVE, STOP);
    signal state_next, state_reg: STATES;
    signal buf_next, buf_reg: std_logic_vector (7 downto 0);  
    signal count_next, count_reg: unsigned (3 downto 0); 
    signal full_next, full_reg: std_logic;
    constant DBIT: integer := 8;   
begin

    -- FSMD: state and data registers
    process (clk, reset)
    begin
        if (reset = '1') then
            state_reg <= IDLE;
            buf_reg <= (others => '0');
            count_reg <= (others => '0');
            full_reg <= '0';
	elsif ( rising_edge(clk) ) then 
            state_reg <= state_next;
            buf_reg <= buf_next;
            count_reg <= count_next;
            full_reg <= full_next;  
        end if;
    end process; 
    
    -- Control logic and data path
    process (edge, state_reg, count_reg, buf_reg,
         full_reg, data)
    begin
        state_next <= state_reg;
        count_next <= count_reg;
        buf_next <= buf_reg; --(others => '0'); 
        full_next <= full_reg;
        
        case state_reg is
            when IDLE =>
                if (edge ='1') then
                    state_next <= RECEIVE;
                end if;
                -- if there is not edge, it means the data
                -- can be read 
                full_next <= '1';
            when RECEIVE =>  
                full_next <= '0';
                if ( edge ='1') then 
                    if ( count_reg = DBIT  ) then
                        count_next <= (others => '0');
                        state_next <= STOP;
                        -- full_next <= '1';
                    else 
                        count_next <= (count_reg + 1);
                        -- LSB is received first
                        -- so we need to rotate the buffer
                        buf_next <= rx & buf_reg(7 downto 1);
                    end if; 
                else
                    buf_next <= buf_reg;
                end if;
            when STOP =>
                full_next <= '0'; 
                if ( edge = '1') then
                    full_next <= '1';
                    state_next <= IDLE;
                end if;
        end case;
    end process;  
    
    full_buf <= full_reg;
    data  <= buf_reg;
end architecture arch;
