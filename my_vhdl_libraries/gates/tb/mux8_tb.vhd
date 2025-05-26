library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity mux8_tb is
end entity mux8_tb;

architecture behavioral of mux8_tb is

    component mux8 is
        port (
            sel : in  std_logic_vector(2 downto 0);
            a0  : in  std_logic;
            a1  : in  std_logic;
            a2  : in  std_logic;
            a3  : in  std_logic;
            a4  : in  std_logic;
            a5  : in  std_logic;
            a6  : in  std_logic;
            a7  : in  std_logic;
            z_out : out std_logic
        );
    end component mux8;

    signal sel_sig  : std_logic_vector(2 downto 0) := "000"; 
    signal a0_sig  : std_logic := '0'; 
    signal a1_sig  : std_logic := '0'; 
    signal a2_sig  : std_logic := '0'; 
    signal a3_sig  : std_logic := '0'; 
    signal a4_sig  : std_logic := '0'; 
    signal a5_sig  : std_logic := '0'; 
    signal a6_sig  : std_logic := '0'; 
    signal a7_sig  : std_logic := '0'; 
    signal z_sig : std_logic; 
    constant DELTA_DELAY : time :=  1 ns;

begin
    uut_mux8 : component mux8
        port map (
            sel  => sel_sig,
            a0  => a0_sig,
            a1 => a1_sig,
            a2  => a2_sig,
            a3 => a3_sig,
            a4  => a4_sig,
            a5 => a5_sig,
            a6  => a6_sig,
            a7 => a7_sig,
            z_out => z_sig
        );

    test : process
    begin
        report "mux8_tb----------------";

        sel_sig <= "000"; -- select 0 -----------------------------------
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

        sel_sig <= "001";  -- select 1 -----------------------------------
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
        
        sel_sig <= "010"; -- select 2 -----------------------------------
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

        sel_sig <= "011";  -- select 3 -----------------------------------
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
        
        sel_sig <= "100"; -- select 4 -----------------------------------
        a4_sig <= '0';
        
        wait for DELTA_DELAY;
        assert (z_sig = a4_sig and z_sig = '0')
            report  "Failure: sel == " & integer'image(to_integer(unsigned(sel_sig))) & 
                    ", a4 == " & std_logic'image(a4_sig) & 
                    ", Output == " & std_logic'image(z_sig);

        a4_sig <= '1';
        wait for DELTA_DELAY;
        assert (z_sig = a4_sig and z_sig = '1')
            report  "Failure: sel == " & integer'image(to_integer(unsigned(sel_sig))) & 
                    ", a4 == " & std_logic'image(a4_sig) & 
                    ", Output == " & std_logic'image(z_sig);

        sel_sig <= "101";  -- select 5 -----------------------------------
        a5_sig <= '0';
        wait for DELTA_DELAY;
        assert (z_sig = a5_sig and z_sig = '0')
            report  "Failure: sel == " & integer'image(to_integer(unsigned(sel_sig))) & 
                    ", a5 == " & std_logic'image(a5_sig) & 
                    ", Output == " & std_logic'image(z_sig);

        a5_sig <= '1';
        wait for DELTA_DELAY;
        assert (z_sig = a5_sig and z_sig = '1')
            report  "Failure: sel == " & integer'image(to_integer(unsigned(sel_sig))) & 
                    ", a5 == " & std_logic'image(a5_sig) & 
                    ", Output == " & std_logic'image(z_sig);
        
        sel_sig <= "110"; -- select 6 -----------------------------------
        a6_sig <= '0';
        
        wait for DELTA_DELAY;
        assert (z_sig = a6_sig and z_sig = '0')
            report  "Failure: sel == " & integer'image(to_integer(unsigned(sel_sig))) & 
                    ", a6 == " & std_logic'image(a6_sig) & 
                    ", Output == " & std_logic'image(z_sig);

        a6_sig <= '1';
        wait for DELTA_DELAY;
        assert (z_sig = a6_sig and z_sig = '1')
            report  "Failure: sel == " & integer'image(to_integer(unsigned(sel_sig))) & 
                    ", a6 == " & std_logic'image(a6_sig) & 
                    ", Output == " & std_logic'image(z_sig);

        sel_sig <= "111";  -- select 7 -----------------------------------
        a7_sig <= '0';
        wait for DELTA_DELAY;
        assert (z_sig = a7_sig and z_sig = '0')
            report  "Failure: sel == " & integer'image(to_integer(unsigned(sel_sig))) & 
                    ", a7 == " & std_logic'image(a7_sig) & 
                    ", Output == " & std_logic'image(z_sig);

        a7_sig <= '1';
        wait for DELTA_DELAY;
        assert (z_sig = a7_sig and z_sig = '1')
            report  "Failure: sel == " & integer'image(to_integer(unsigned(sel_sig))) & 
                    ", a7 == " & std_logic'image(a7_sig) & 
                    ", Output == " & std_logic'image(z_sig);

        report "mux8_tb complete---------------";
        
        wait;

    end process test;

end architecture behavioral;
