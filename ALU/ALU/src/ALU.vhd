library ieee;
use ieee.std_logic_1164.all;
-- Operations
--  ADD     0000
--  SUB     0001
--  AND     0010
--  NOT     0100
--  XOR     0101
--  OR      0110
--  SLL     0111
--  SRL     1000
--  SLA     1001
--  SRA     1010
--  ROL     1011
--  R0R     1100
--       1101
--       1110

entity ALU is
    port (
        z_flag   : out STD_LOGIC;
        n_flag   : out STD_LOGIC;
        v_flag   : out STD_LOGIC;
        c_flag   : out STD_LOGIC
    );
end entity ALU;

architecture rtl of ALU is
begin
    
end architecture rtl;    