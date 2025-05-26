library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder8 is
    port (
        a_in : in STD_LOGIC_VECTOR(7 downto 0);
        b_in : in STD_LOGIC_VECTOR(7 downto 0);
        c_in: in std_logic;
        sum: out STD_LOGIC_VECTOR(7 downto 0);
        c_out: out std_logic
    );
end adder8;

architecture behavioral of fullAdder is
begin
    sum <= a_in xor b_in xor c_in;
    c_out <= (a_in and b_in) or (c_in and (a_in xor b_in));
end architecture behavioral;

architecture structural of fullAdder is
    component and2 is
        port (
            a_in  : in  std_logic;
            b_in  : in  std_logic;
            z_out : out std_logic
        );
    end component and2;
    component or2 is
        port (
            a_in  : in  std_logic;
            b_in  : in  std_logic;
            z_out : out std_logic
        );
    end component or2;
    component xor2 is
        port (
            a_in  : in  std_logic;
            b_in  : in  std_logic;
            z_out : out std_logic
        );
    end component xor2;
    component xor3 is
        port (
            a_in  : in  std_logic;
            b_in  : in  std_logic;
            c_in  : in  std_logic;
            z_out : out std_logic
        );
    end component xor3;

signal a_XOR_b : STD_LOGIC;
signal a_AND_b : STD_LOGIC;
signal cin_AND_aXORb : STD_LOGIC;
begin
    xor_sum : component xor3
     port map(
        a_in => a_in,
        b_in => b_in,
        c_in => c_in,
        z_out => sum
    );

    xor_a_b : component xor2
     port map(
        a_in => a_in,
        b_in => b_in,
        z_out => a_XOR_b
    );

    and_a_b : component and2
     port map(
        a_in => a_in,
        b_in => b_in,
        z_out => a_AND_b 
    );

    and_c_aXORb : component and2
     port map(
        a_in => c_in,
        b_in => a_XOR_b,
        z_out => cin_AND_aXORb 
    );

    or_Cout : component or2
     port map(
        a_in => cin_and_aXORb,
        b_in => a_AND_b,
        z_out => c_out 
    );

end architecture structural;