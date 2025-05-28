library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity and_4bit is
    port (
        a_in : in STD_LOGIC_VECTOR(3 downto 0);
        b_in : in STD_LOGIC_VECTOR(3 downto 0);
        sum: out STD_LOGIC_VECTOR(3 downto 0)
    );
end and_4bit;

architecture dataFlow of and_4bit is
begin
    sum <= a_in and b_in;
end architecture dataFlow;

architecture structural of and_4bit is
    component and2 is
        port (
            a_in : in std_logic;
            b_in : in std_logic;
            z_out: out std_logic
        );
    end component and2;

    signal c0, c1, c2 : std_logic;
begin
    bit_0: component and2 
        port map(
            a_in  => a_in(0),
            b_in  => b_in(0),
            z_out  => sum(0)
        );
    bit_1: component and2 
        port map(
            a_in  => a_in(1),
            b_in  => b_in(1),
            z_out  => sum(1)
        );
    bit_2: component and2 
        port map(
            a_in  => a_in(2),
            b_in  => b_in(2),
            z_out  => sum(2)
        );
    bit_3: component and2 
        port map(
            a_in  => a_in(3),
            b_in  => b_in(3),
            z_out  => sum(3)
        );

end architecture structural;