library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity mux2_tb is
end entity mux2_tb;

architecture behavioral of mux2_tb is

    component mux2 is
        port (
            sel  : in  std_logic;
            a0  : in  std_logic;
            a1  : in  std_logic;
            z_out : out std_logic
        );
    end component mux2;

    signal sel_sig  : std_logic := '0'; 
    signal a0_sig  : std_logic := '0'; 
    signal a1_sig  : std_logic := '0'; 
    signal z_sig : std_logic; 
    constant DELTA_DELAY : time :=  1 ns;

begin
    uut_mux2 : component mux2
        port map (
            sel  => sel_sig,
            a0  => a0_sig,
            a1 => a1_sig,
            z_out => z_sig
        );

    test : process
    begin
        report "mux2_tb----------------";

        sel_sig <= '0'; -- select option 0 -------------------------
        a0_sig <= '0';
        
        wait for DELTA_DELAY;
        assert (z_sig = a0_sig and z_sig = '0')
            report  "Failure: sel == " & std_logic'image(sel_sig) & 
                    ", a0 == " & std_logic'image(a0_sig) & 
                    ", Output == " & std_logic'image(z_sig);

        a0_sig <= '1';
        wait for DELTA_DELAY;
        assert (z_sig = a0_sig and z_sig = '1')
            report  "Failure: sel == " & std_logic'image(sel_sig) & 
                    ", a0 == " & std_logic'image(a0_sig) & 
                    ", Output == " & std_logic'image(z_sig);

        sel_sig <= '1'; -- select option 1 -------------------------
        a1_sig <= '0';
        wait for DELTA_DELAY;
        assert (z_sig = a1_sig and z_sig = '0')
            report  "Failure: sel == " & std_logic'image(sel_sig) & 
                    ", a1 == " & std_logic'image(a1_sig) & 
                    ", Output == " & std_logic'image(z_sig);

        a1_sig <= '1';
        wait for DELTA_DELAY;
        assert (z_sig = a1_sig and z_sig = '1')
            report  "Failure: sel == " & std_logic'image(sel_sig) & 
                    ", a1 == " & std_logic'image(a1_sig) & 
                    ", Output == " & std_logic'image(z_sig);

        report "mux2_tb complete---------------";
        
        wait;

    end process test;

end architecture behavioral;
