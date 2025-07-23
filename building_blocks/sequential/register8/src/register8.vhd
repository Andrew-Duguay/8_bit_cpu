library ieee;
library building_blocks_lib;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register8 is
    port (
        a_in : in STD_LOGIC_VECTOR(7 downto 0);
        wr : in STD_LOGIC;
        rst : in STD_LOGIC;
        clk : in STD_LOGIC;
        z_out : out STD_LOGIC_VECTOR(7 downto 0)
    );
end register8;

architecture rtl of register8 is
    signal z : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
begin
    process (clk, rst)
        begin
            if rst = '1' then z <= ( others=> '0');
            elsif (wr = '1' and clk'event) then z <= a_in;
            end if;
    end process;
    z_out <= z;
end architecture rtl;
