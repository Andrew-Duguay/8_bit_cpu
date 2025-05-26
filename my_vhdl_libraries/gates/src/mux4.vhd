library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4 is
    port (
        sel : in  std_logic_vector(1 downto 0);
        a0 : in std_logic;
        a1 : in std_logic;
        a2 : in std_logic;
        a3 : in std_logic;
        z_out : out std_logic
    );
end mux4;

architecture rtl of mux4 is

begin
z_out <=    a0 when sel = "00" else 
            a1 when sel = "01" else
            a2 when sel = "10" else
            a3 when sel = "11";
end architecture rtl;