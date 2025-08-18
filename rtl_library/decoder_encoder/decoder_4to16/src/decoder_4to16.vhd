library ieee;
library rtl_lib;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder_4to16 is
    port (
        a_in : in STD_LOGIC_VECTOR(3 downto 0);
        z_out : out STD_LOGIC_VECTOR(15 downto 0)
    );
end decoder_4to16;

architecture rtl of decoder_4to16 is
begin
    z_out <= std_logic_vector( SHIFT_LEFT( to_unsigned(1,16), TO_INTEGER( unsigned(a_in) ) ) );
end architecture rtl;
