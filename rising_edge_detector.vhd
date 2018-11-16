-- rising edge detector
-- It will be used to detect the rising edge of the SPI clk

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rising_edge_detector is
    port (  clk: in std_logic;
            reset: in std_logic; 
            clk_in: in std_logic;
            edge: out std_logic
         ); 
end entity rising_edge_detector;

architecture arch of rising_edge_detector is
    type STATES is (ONE, ZERO, R_EDGE);
    signal state_next, state_reg: STATES;
    signal q_next, q_reg: std_logic; -- used to detect edges
begin
    
    -- FSMD: state and data registers
    process (clk, reset)
    begin
        if (reset = '1') then
            state_reg <= ZERO;
            q_reg <= '0';
        elsif (rising_edge(clk)) then
            state_reg <= state_next;
            q_reg <= q_next; 
        end if;
    end process;  

    -- control flow and data path
    process (state_reg, clk_in)
    begin
        state_next <= state_reg;
        q_next <= '0'; 
        case state_reg is
            when ZERO =>
                if ( clk_in ='1') then
                    state_next <= R_EDGE;
                end if;
            when ONE =>
                if ( clk_in = '0') then
                    state_next <= ZERO;
                end if;
            when R_EDGE =>  
                q_next <= '1';
                if ( clk_in = '0') then
                    state_next <= ZERO;
                else
                    state_next <= ONE;
                end if;
        end case;  
    end process; 

    edge <= q_reg;
end architecture arch; 
