library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity and2_tb is
end entity and2_tb;

architecture behavioral of and2_tb is

    component and2 is
        port (
            a_in  : in  std_logic;
            b_in  : in  std_logic;
            z_out : out std_logic
        );
    end component and2;

    signal a_sig  : std_logic := '0'; 
    signal b_sig  : std_logic := '0'; 
    signal z_sig : std_logic; 
    constant DELTA_DELAY : time :=  1 ns;

begin
    uut_and2 : component and2
        port map (
            a_in  => a_sig,
            b_in  => b_sig,
            z_out => z_sig
        );

    test : process
    begin
        a_sig <= '0';
        b_sig <= '0';
        wait for DELTA_DELAY;
        assert z_sig = '0'
            report "Failure: input == 00,  Output == " & std_logic'image(z_sig);

        a_sig <= '0';
        b_sig <= '1';
        wait for DELTA_DELAY;
        assert (z_sig = '0')
            report "Failure: input == 01,  Output == " & std_logic'image(z_sig);

        a_sig <= '1';
        b_sig <= '0';
        wait for DELTA_DELAY;
        assert (z_sig = '0')
            report "Failure: input == 10,  Output == " & std_logic'image(z_sig);

        a_sig <= '1';
        b_sig <= '1';
        wait for DELTA_DELAY;
        assert (z_sig = '1')
            report "Failure: input == 11,  Output == " & std_logic'image(z_sig);

        wait;

    end process test;

end architecture behavioral;
