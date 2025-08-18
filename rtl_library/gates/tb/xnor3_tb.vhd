library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity xnor3_tb is
end entity xnor3_tb;

architecture behavioral of xnor3_tb is

    component xnor3 is
        port (
            a_in  : in  std_logic;
            b_in  : in  std_logic;
            c_in  : in  std_logic;
            z_out : out std_logic
        );
    end component xnor3;

    signal a_sig  : std_logic := '0'; 
    signal b_sig  : std_logic := '0'; 
    signal c_sig  : STD_LOGIC := '0';
    signal z_sig : std_logic; 
    constant DELTA_DELAY : time :=  1 ns;

begin
    uut_xnor3 : component xnor3
        port map (
            a_in  => a_sig,
            b_in  => b_sig,
            c_in  => c_sig,
            z_out => z_sig
        );

    test : process
    begin
        a_sig <= '0';
        b_sig <= '0';
        c_sig <= '0';
        wait for DELTA_DELAY;
        assert z_sig = '1'
            report "Failure: input == 000,  Output == " & std_logic'image(z_sig);

        a_sig <= '0';
        b_sig <= '0';
        c_sig <= '1';
        wait for DELTA_DELAY;
        assert (z_sig = '0')
            report "Failure: input == 001,  Output == " & std_logic'image(z_sig);

        a_sig <= '0';
        b_sig <= '1';
        c_sig <= '0';
        wait for DELTA_DELAY;
        assert (z_sig = '0')
            report "Failure: input == 010,  Output == " & std_logic'image(z_sig);

        a_sig <= '0';
        b_sig <= '1';
        c_sig <= '1';
        wait for DELTA_DELAY;
        assert (z_sig = '1')
            report "Failure: input == 011,  Output == " & std_logic'image(z_sig);

        a_sig <= '1';
        b_sig <= '0';
        c_sig <= '0';
        wait for DELTA_DELAY;
        assert z_sig = '0'
            report "Failure: input == 100,  Output == " & std_logic'image(z_sig);

        a_sig <= '1';
        b_sig <= '0';
        c_sig <= '1';
        wait for DELTA_DELAY;
        assert (z_sig = '1')
            report "Failure: input == 101,  Output == " & std_logic'image(z_sig);

        a_sig <= '1';
        b_sig <= '1';
        c_sig <= '0';
        wait for DELTA_DELAY;
        assert (z_sig = '1')
            report "Failure: input == 110,  Output == " & std_logic'image(z_sig);

        a_sig <= '1';
        b_sig <= '1';
        c_sig <= '1';
        wait for DELTA_DELAY;
        assert (z_sig = '0')
            report "Failure: input == 111,  Output == " & std_logic'image(z_sig);
            
        wait;

    end process test;

end architecture behavioral;
