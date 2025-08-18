library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fullAdder is
    port (
        a_in : in std_logic;
        b_in : in std_logic;
        c_in: in std_logic;
        sum: out std_logic;
        c_out: out std_logic
    );
end fullAdder;

architecture rtl of fullAdder is
begin
    sum <= a_in xor b_in xor c_in;
    c_out <= (a_in and b_in) or (c_in and (a_in xor b_in));
end architecture rtl;
