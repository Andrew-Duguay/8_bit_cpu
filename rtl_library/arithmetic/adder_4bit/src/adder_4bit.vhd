library ieee;
library rtl_lib;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_4bit is
    port (
        a_in : in STD_LOGIC_VECTOR(3 downto 0);
        b_in : in STD_LOGIC_VECTOR(3 downto 0);
        c_in: in std_logic;
        sum: out STD_LOGIC_VECTOR(3 downto 0);
        c_out: out std_logic
    );
end adder_4bit;

architecture behavioral of adder_4bit is
begin
    beh_process: process (a_in, b_in, c_in)
    variable a : integer;
    variable b : integer; 
    variable sum_v : integer;
    begin
        a := to_integer(unsigned(a_in));
        b := to_integer(unsigned(b_in));
        sum_v := a + b;
        if (c_in = '1') then
            sum_v := sum_v + 1;
        end if;
        if (sum_v > 15) then
            c_out <= '1';
        else 
            c_out <= '0';
        end if;
        sum <= Std_Logic_Vector(to_unsigned(sum_v mod 16, 4));
    end process;
end architecture behavioral;

architecture rtl of adder_4bit is
    signal temp : STD_LOGIC_VECTOR(4 downto 0);
begin
    temp <= STD_LOGIC_VECTOR(('0' & unsigned(a_in)) + unsigned(b_in) + c_in);
    c_out <= temp(4);
    sum <= temp(3 downto 0);
end architecture rtl;