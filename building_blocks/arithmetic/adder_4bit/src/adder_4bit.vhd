library ieee;
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

architecture dataFlow of adder_4bit is
    signal temp : STD_LOGIC_VECTOR(4 downto 0);
begin
    temp <= STD_LOGIC_VECTOR(('0' & unsigned(a_in)) + unsigned(b_in) + c_in);
    c_out <= temp(4);
    sum <= temp(3 downto 0);
end architecture dataFlow;

architecture structural of adder_4bit is
    component fullAdder is
        port (
            a_in : in std_logic;
            b_in : in std_logic;
            c_in: in std_logic;
            sum: out std_logic;
            c_out: out std_logic
        );
    end component fullAdder;

    signal c0, c1, c2 : std_logic;
begin
    bit_0: component fullAdder 
        port map(
            a_in  => a_in(0),
            b_in  => b_in(0),
            c_in  => c_in,
            sum  => sum(0),
            c_out => c0
        );
    bit_1: component fullAdder 
        port map(
            a_in  => a_in(1),
            b_in  => b_in(1),
            c_in  => c0,
            sum  => sum(1),
            c_out => c1
        );
    bit_2: component fullAdder 
        port map(
            a_in  => a_in(2),
            b_in  => b_in(2),
            c_in  => c1,
            sum  => sum(2),
            c_out => c2
        );
    bit_3: component fullAdder 
        port map(
            a_in  => a_in(3),
            b_in  => b_in(3),
            c_in  => c2,
            sum  => sum(3),
            c_out => c_out
        );

end architecture structural;