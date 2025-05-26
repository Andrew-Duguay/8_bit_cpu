library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity mux4_tb is
end entity mux4_tb;

architecture behavioral of mux4_tb is

    component mux4 is
        port (
            sel : in  std_logic_vector(1 downto 0);
            a0  : in  std_logic;
            a1  : in  std_logic;
            a2  : in  std_logic;
            a3  : in  std_logic;
            z_out : out std_logic
        );
    end component mux4;

    signal sel_sig  : std_logic_vector(1 downto 0) := "00"; 
    signal a0_sig  : std_logic := '0'; 
    signal a1_sig  : std_logic := '0'; 
    signal a2_sig  : std_logic := '0'; 
    signal a3_sig  : std_logic := '0'; 
    signal z_sig : std_logic; 
    constant DELTA_DELAY : time :=  1 ns;

begin
    uut_mux4 : component mux4
        port map (
            sel  => sel_sig,
            a0  => a0_sig,
            a1 => a1_sig,
            a2  => a2_sig,
            a3 => a3_sig,
            z_out => z_sig
        );

    test : process
    begin
        report "mux4_tb----------------";

        sel_sig <= "00"; -- select 0 -----------------------------------
        a0_sig <= '0';
        
        wait for DELTA_DELAY;
        assert (z_sig = a0_sig and z_sig = '0')
            report  "Failure: sel == " & integer'image(to_integer(unsigned(sel_sig))) & 
                    ", a0 == " & std_logic'image(a0_sig) & 
                    ", Output == " & std_logic'image(z_sig);

        a0_sig <= '1';
        wait for DELTA_DELAY;
        assert (z_sig = a0_sig and z_sig = '1')
            report  "Failure: sel == " & integer'image(to_integer(unsigned(sel_sig))) & 
                    ", a0 == " & std_logic'image(a0_sig) & 
                    ", Output == " & std_logic'image(z_sig);

        sel_sig <= "01";  -- select 1 -----------------------------------
        a1_sig <= '0';
        wait for DELTA_DELAY;
        assert (z_sig = a1_sig and z_sig = '0')
            report  "Failure: sel == " & integer'image(to_integer(unsigned(sel_sig))) & 
                    ", a1 == " & std_logic'image(a1_sig) & 
                    ", Output == " & std_logic'image(z_sig);

        a1_sig <= '1';
        wait for DELTA_DELAY;
        assert (z_sig = a1_sig and z_sig = '1')
            report  "Failure: sel == " & integer'image(to_integer(unsigned(sel_sig))) & 
                    ", a1 == " & std_logic'image(a1_sig) & 
                    ", Output == " & std_logic'image(z_sig);
        
        sel_sig <= "10"; -- select 2 -----------------------------------
        a2_sig <= '0';
        
        wait for DELTA_DELAY;
        assert (z_sig = a2_sig and z_sig = '0')
            report  "Failure: sel == " & integer'image(to_integer(unsigned(sel_sig))) & 
                    ", a2 == " & std_logic'image(a2_sig) & 
                    ", Output == " & std_logic'image(z_sig);

        a2_sig <= '1';
        wait for DELTA_DELAY;
        assert (z_sig = a2_sig and z_sig = '1')
            report  "Failure: sel == " & integer'image(to_integer(unsigned(sel_sig))) & 
                    ", a2 == " & std_logic'image(a2_sig) & 
                    ", Output == " & std_logic'image(z_sig);

        sel_sig <= "11";  -- select 3 -----------------------------------
        a3_sig <= '0';
        wait for DELTA_DELAY;
        assert (z_sig = a3_sig and z_sig = '0')
            report  "Failure: sel == " & integer'image(to_integer(unsigned(sel_sig))) & 
                    ", a3 == " & std_logic'image(a3_sig) & 
                    ", Output == " & std_logic'image(z_sig);

        a3_sig <= '1';
        wait for DELTA_DELAY;
        assert (z_sig = a3_sig and z_sig = '1')
            report  "Failure: sel == " & integer'image(to_integer(unsigned(sel_sig))) & 
                    ", a3 == " & std_logic'image(a3_sig) & 
                    ", Output == " & std_logic'image(z_sig);

        report "mux4_tb complete---------------";
        
        wait;

    end process test;

end architecture behavioral;
