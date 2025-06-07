library ieee;
library building_blocks_lib;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder_3to8 is
    port (
        a_in : in STD_LOGIC_VECTOR(2 downto 0);
        z_out : out STD_LOGIC_VECTOR(7 downto 0)
    );
end decoder_3to8;

architecture dataFlow of decoder_3to8 is
begin
    z_out <= std_logic_vector( SHIFT_LEFT( to_unsigned(1,8), TO_INTEGER( unsigned(a_in) ) ) );
end architecture dataFlow;
