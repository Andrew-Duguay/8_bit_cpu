library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux8 is
    port (
        sel : in  std_logic_vector(2 downto 0);
        a : in std_logic_vector(7 downto 0);
        z_out : out std_logic
    );
end mux8;

architecture rtl of mux8 is

begin
z_out <=    a(0) when sel = "000" else 
            a(1) when sel = "001" else
            a(2) when sel = "010" else
            a(3) when sel = "011" else
            a(4) when sel = "100" else 
            a(5) when sel = "101" else
            a(6) when sel = "110" else
            a(7) when sel = "111";
end architecture rtl;