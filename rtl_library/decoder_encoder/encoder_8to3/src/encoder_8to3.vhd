library ieee;
library rtl_lib;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity encoder_8to3 is
    port (
        a_in : in STD_LOGIC_VECTOR(7 downto 0);
        z_out : out STD_LOGIC_VECTOR(2 downto 0)
    );
end encoder_8to3;

architecture rtl of encoder_8to3 is
begin
    with a_in select
        z_out <=    "000" when "00000001",
                    "001" when "00000010",
                    "010" when "00000100",
                    "011" when "00001000",
                    "100" when "00010000",
                    "101" when "00100000",
                    "110" when "01000000",
                    "111" when "10000000",
                    "XXX" when others;
                    
end architecture rtl;
