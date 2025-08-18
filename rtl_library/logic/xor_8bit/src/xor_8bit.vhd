library ieee;
library rtl_lib;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity xor_8bit is
    port (
        a_in : in STD_LOGIC_VECTOR(7 downto 0);
        b_in : in STD_LOGIC_VECTOR(7 downto 0);
        sum: out STD_LOGIC_VECTOR(7 downto 0)
    );
end xor_8bit;

architecture dataFlow of xor_8bit is
begin
    sum <= a_in xor b_in;
end architecture dataFlow;

architecture structural of xor_8bit is
begin
    GEN_xor_ARR: for i in a_in'range generate
        xor_GATE: entity rtl_lib.xor2 
        port map(
            a_in  => a_in(i),
            b_in  => b_in(i),
            z_out  => sum(i)
        );
    end generate;

end architecture structural;