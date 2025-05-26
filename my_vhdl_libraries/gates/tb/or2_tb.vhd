library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity or2_tb is
end entity or2_tb;

architecture behavioral of or2_tb is

    component or2 is
        port (
            a_in  : in  std_logic;
            b_in  : in  std_logic;
            z_out : out std_logic
        );
    end component or2;

    signal a_sig  : std_logic := '0'; 
    signal b_sig  : std_logic := '0'; 
    signal z_sig : std_logic; 
    constant DELTA_DELAY : time :=  1 ns;

begin
    uut_or2 : component or2
        port map (
            a_in  => a_sig,
            b_in  => b_sig,
            z_out => z_sig
        );

    test : process
    begin
        report "or2_tb----------------";

        a_sig <= '0';
        b_sig <= '0';
        wait for DELTA_DELAY;
        assert z_sig = '0'
            report "Failure: input == 00,  Output == " & std_logic'image(z_sig);

        a_sig <= '0';
        b_sig <= '1';
        wait for DELTA_DELAY;
        assert (z_sig = '1')
            report "Failure: input == 01,  Output == " & std_logic'image(z_sig);

        a_sig <= '1';
        b_sig <= '0';
        wait for DELTA_DELAY;
        assert (z_sig = '1')
            report "Failure: input == 10,  Output == " & std_logic'image(z_sig);

        a_sig <= '1';
        b_sig <= '1';
        wait for DELTA_DELAY;
        assert (z_sig = '1')
            report "Failure: input == 11,  Output == " & std_logic'image(z_sig);

        report "or2_tb complete---------------";
        
        wait;

    end process test;

end architecture behavioral;
