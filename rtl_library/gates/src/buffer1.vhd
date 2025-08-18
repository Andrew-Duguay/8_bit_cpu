library ieee;
use ieee.std_logic_1164.all;

entity buffer1 is
    port (
        a_in : in  std_logic;
        z_out: out std_logic
    );
end entity buffer1;

architecture rtl of buffer1 is
begin
    z_out <= a_in;
end architecture rtl;