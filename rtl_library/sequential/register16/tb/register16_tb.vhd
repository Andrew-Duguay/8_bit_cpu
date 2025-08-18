library IEEE;
library rtl_lib;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use rtl_lib.all;

entity register16_tb is
end entity register16_tb;

architecture behavioral of register16_tb is

    signal a_sig  : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0'); 
    signal z_sig  : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
    signal wr_sig : STD_LOGIC := '0';
    signal clk_sig : STD_LOGIC := '0';
    signal rst_sig : STD_LOGIC := '0';
    signal done : STD_LOGIC := '0';
    constant DELTA_DELAY : time :=  10 ns;

begin
    uut_register16 : entity work.register16(rtl)
        port map (
            a_in  => a_sig,
            wr    => wr_sig,
            rst   => rst_sig,
            clk   => clk_sig,
            z_out => z_sig
        );

    CLK_PROCESS : process
        begin
            clk_sig <= '0';
            wait for 100 ns;
            clk_sig <= '1';
            wait for 100 ns;
            if done = '1' then 
                wait;
            end if;
        end process CLK_PROCESS;

    TB_PROCESS : process
        constant q1 : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000001";
        variable q2 : STD_LOGIC_VECTOR(15 downto 0);
        begin
            TEST_1 : for i in 0 to 15 loop
                q2 := STD_LOGIC_VECTOR( SHIFT_LEFT( UNSIGNED(q1), i));
                wr_sig <= '0';
                a_sig <= q2;
                assert (not (z_sig = q2))
                    report  "FAILURE: Register contents updated without wr and clk edge" &
                            LF & "                     a    |    z " & 
                            LF & "                   " & to_string(a_sig) & " | " & to_string(z_sig)
                    severity FAILURE;

                wait until rising_edge(clk_sig);
                wait for DELTA_DELAY;

                assert (not (z_sig = q2))
                    report  "FAILURE: Register contents updated without wr signal" &
                            LF & "                     a    |    z " & 
                            LF & "                   " & to_string(a_sig) & " | " & to_string(z_sig)
                    severity FAILURE;

                wr_sig <= '1';
                wait until rising_edge(clk_sig);
                wait for DELTA_DELAY;
                    
                assert (z_sig = q2)
                    report  "FAILURE: Register contents not updated after write conditions met" &
                            LF & "                     a    |    z " & 
                            LF & "                   " & to_string(a_sig) & " | " & to_string(z_sig)
                    severity FAILURE;
            end loop;

            rst_sig <= '1';
            wait for DELTA_DELAY;
            assert (z_sig = (z_sig'range => '0'))
                    report  "FAILURE: Register contents not reset asynch from clk" &
                            LF & "                     a    |    z " & 
                            LF & "                   " & to_string(a_sig) & " | " & to_string(z_sig)
                    severity FAILURE;   
            
            done <= '1';
            wait;

        end process TB_PROCESS;

end architecture behavioral;
