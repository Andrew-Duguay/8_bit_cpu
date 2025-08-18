library ieee;
library rtl_lib;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity not_8bit is
    port (
        a_in : in STD_LOGIC_VECTOR(7 downto 0);
        sum: out STD_LOGIC_VECTOR(7 downto 0)
    );
end not_8bit;

architecture dataFlow of not_8bit is
begin
    sum <= not a_in;
end architecture dataFlow;

architecture structural of not_8bit is
begin
    GEN_not_ARR: for i in a_in'range generate
        not_GATE: entity rtl_lib.not1
        port map(
            a_in  => a_in(i),
            z_out  => sum(i)
        );
    end generate;

end architecture structural;