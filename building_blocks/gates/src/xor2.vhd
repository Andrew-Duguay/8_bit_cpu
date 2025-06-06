library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity xor2 is
    port (
        a_in : in  std_logic;
        b_in : in  std_logic;
        z_out: out std_logic
    );
end xor2;

architecture rtl of xor2 is

begin
    z_out <= a_in xor b_in;
end architecture rtl;