library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shifter_8bit is
    port (
        a_in : in STD_LOGIC_VECTOR(7 downto 0);
        arith : in STD_LOGIC;
        rot : in STD_LOGIC;
        direction : in STD_LOGIC;           -- 0 = left, 1 = right
        num_bits : in std_logic_vector(2 downto 0);
        result: out STD_LOGIC_VECTOR(7 downto 0)
    );
end shifter_8bit;


architecture dataFlow of shifter_8bit is

    signal status_bits : std_logic_vector(2 downto 0);
    signal shift_amount : integer range 0 to 7;
begin
    status_bits <= direction & rot & arith;
    shift_amount <= to_integer(unsigned(num_bits));
    result <=   std_logic_vector(shift_left(unsigned(a_in), shift_amount))    when (status_bits = "000") else -- LOGICAL SHIFT LEFT
                std_logic_vector(shift_left(signed(a_in), shift_amount))      when (status_bits = "001") else -- ARITHMETIC SHIFT LEFT
                std_logic_vector(rotate_left(unsigned(a_in), shift_amount))   when (status_bits = "010") else -- ROTATE LEFT
                std_logic_vector(shift_right(unsigned(a_in), shift_amount))   when (status_bits = "100") else -- LOGICAL SHIFT RIGHT
                std_logic_vector(shift_right(signed(a_in), shift_amount))     when (status_bits = "101") else -- ARITHMETIC SHIFT RIGHT
                std_logic_vector(rotate_right(unsigned(a_in), shift_amount))  when (status_bits = "110") else -- ROTATE RIGHT
                (others => 'X');
end architecture dataFlow;