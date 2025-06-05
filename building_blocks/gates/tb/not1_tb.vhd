library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity not1_tb is
end entity not1_tb;

architecture behavioral of not1_tb is

    component not1 is
        port (
            a_in  : in  std_logic;
            z_out : out std_logic
        );
    end component not1;

    signal a_sig  : std_logic := '0'; 
    signal z_sig : std_logic; 
    constant DELTA_DELAY : time :=  1 ns;

begin
    uut_not1 : component not1
        port map (
            a_in  => a_sig,
            z_out => z_sig
        );

    test : process
    begin
        a_sig <= '0';
        wait for DELTA_DELAY;
        assert (z_sig = '1')
            report "Failure: input == 0,  Output == " & std_logic'image(z_sig);

        a_sig <= '1';
        wait for DELTA_DELAY;
        assert (z_sig = '0')
            report "Failure: input == 1,  Output == " & std_logic'image(z_sig);

        wait;

    end process test;

end architecture behavioral;
