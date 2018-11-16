-- Delay based on 2 Flip flops type D
-- One clock delay
-- This block will delay the input of the SPI RX
-- can be seen as synchronization block

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity  delay_sync is
    port (  clk: in std_logic;
            reset: in std_logic;
            d: in std_logic;
            q: out std_logic
         );
end entity delay_sync;

architecture arch of delay_sync is
    signal q1_next, q1_reg: std_logic; 
    signal q2_next, q2_reg: std_logic;
begin
    -- FSMD: state and data registers
    process (clk, reset)
    begin
        if (reset  = '1') then
            q1_reg <= '0';
            q2_reg <= '0';
        elsif ( rising_edge(clk)) then
            q1_reg <= q1_next;
            q2_reg <= q2_next;
        end if;
    end process;  

-- Control logic and data path
    process (d, q1_reg)
    begin
        q1_next <= d;
        q2_next <= q1_reg;
    end process; 

    q <= q2_reg;   
end architecture arch; 
