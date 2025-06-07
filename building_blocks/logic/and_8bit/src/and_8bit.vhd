library ieee;
library building_blocks_lib;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity and_8bit is
    port (
        a_in : in STD_LOGIC_VECTOR(7 downto 0);
        b_in : in STD_LOGIC_VECTOR(7 downto 0);
        sum: out STD_LOGIC_VECTOR(7 downto 0)
    );
end and_8bit;

architecture dataFlow of and_8bit is
begin
    sum <= a_in and b_in;
end architecture dataFlow;

architecture structural of and_8bit is
begin
    GEN_AND_ARR: for i in a_in'range generate
        AND_GATE: entity building_blocks_lib.and2 
        port map(
            a_in  => a_in(i),
            b_in  => b_in(i),
            z_out  => sum(i)
        );
    end generate;

end architecture structural;