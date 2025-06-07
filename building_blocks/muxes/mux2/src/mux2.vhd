library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2 is
    port (
        sel : in  std_logic;
        a0 : in std_logic;
        a1 : in std_logic;
        z_out : out std_logic
    );
end mux2;

architecture rtl of mux2 is

begin
z_out <= a0 when sel = '0' else a1;
end architecture rtl;