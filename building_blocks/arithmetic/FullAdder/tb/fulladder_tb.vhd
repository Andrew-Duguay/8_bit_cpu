library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity fullAdder_tb is
end entity fullAdder_tb;

architecture behavioral of fullAdder_tb is

    signal a_sig  : std_logic := '0'; 
    signal b_sig  : std_logic := '0'; 
    signal c_in_sig  : std_logic := '0'; 
    signal sum_sig_beh  : std_logic; 
    signal c_out_sig_beh  : std_logic;  
    signal sum_sig_struc  : std_logic; 
    signal c_out_sig_struc  : std_logic; 
    constant DELTA_DELAY : time :=  10 ns;

begin
    uut_fullAdder_beh : entity work.fullAdder(behavioral)
        port map (
            a_in    => a_sig,
            b_in    => b_sig,
            c_in    => c_in_sig,
            sum     => sum_sig_beh,
            c_out   => c_out_sig_beh
        );
    uut_fullAdder_struc : entity work.fullAdder(structural)
        port map (
            a_in    => a_sig,
            b_in    => b_sig,
            c_in    => c_in_sig,
            sum     => sum_sig_struc,
            c_out   => c_out_sig_struc
        );

    test : process
    begin

        a_sig <= '0';
        b_sig <= '0';
        c_in_sig <= '0';
        wait for DELTA_DELAY;
        assert (sum_sig_beh = '0' AND c_out_sig_beh = '0')
            report LF & 
                    "     FAILURE:   a  |  b  | c_in | sum | c_out" & LF & 
                    "     EXPECTED: '0' | '0' | '0'  | '0' | '0' " & LF & 
                    "     BEH:      " &   std_logic'image(a_sig) & " | " & 
                                        std_logic'image(b_sig) & " | " & 
                                        std_logic'image(c_in_sig) & "  | " & 
                                        std_logic'image(sum_sig_beh) & " | " & std_logic'image(c_out_sig_beh) & LF &
                    "     STRUCT:   " &   std_logic'image(a_sig) & " | " & 
                                        std_logic'image(b_sig) & " | " & 
                                        std_logic'image(c_in_sig) & "  | " & 
                                        std_logic'image(sum_sig_struc) & " | " & std_logic'image(c_out_sig_struc) & LF;

        a_sig <= '1';
        b_sig <= '0';
        c_in_sig <= '0';
        wait for DELTA_DELAY;
        assert (sum_sig_beh = '1' AND c_out_sig_beh = '0')
            report LF & 
                    "     FAILURE:   a  |  b  | c_in | sum | c_out" & LF & 
                    "     EXPECTED: '1' | '0' | '0'  | '1' | '0' " & LF & 
                    "     ACTUAL:   " &   std_logic'image(a_sig) & " | " & 
                                        std_logic'image(b_sig) & " | " & 
                                        std_logic'image(c_in_sig) & "  | " & 
                                        std_logic'image(sum_sig_beh) & " | " & std_logic'image(c_out_sig_beh) & LF &
                    "     STRUCT:   " &   std_logic'image(a_sig) & " | " & 
                                        std_logic'image(b_sig) & " | " & 
                                        std_logic'image(c_in_sig) & "  | " & 
                                        std_logic'image(sum_sig_struc) & " | " & std_logic'image(c_out_sig_struc) & LF;

        a_sig <= '0';
        b_sig <= '1';
        c_in_sig <= '0';
        wait for DELTA_DELAY;
        assert (sum_sig_beh = '1' AND c_out_sig_beh = '0')
            report LF & 
                    "     FAILURE:   a  |  b  | c_in | sum | c_out" & LF & 
                    "     EXPECTED: '0' | '1' | '0'  | '1' | '0' " & LF & 
                    "     ACTUAL:   " &   std_logic'image(a_sig) & " | " & 
                                        std_logic'image(b_sig) & " | " & 
                                        std_logic'image(c_in_sig) & "  | " & 
                                        std_logic'image(sum_sig_beh) & " | " & std_logic'image(c_out_sig_beh) & LF &
                    "     STRUCT:   " &   std_logic'image(a_sig) & " | " & 
                                        std_logic'image(b_sig) & " | " & 
                                        std_logic'image(c_in_sig) & "  | " & 
                                        std_logic'image(sum_sig_struc) & " | " & std_logic'image(c_out_sig_struc) & LF;

        a_sig <= '1';
        b_sig <= '1';
        c_in_sig <= '0';
        wait for DELTA_DELAY;
        assert (sum_sig_beh = '0' AND c_out_sig_beh = '1')
            report LF & 
                    "     FAILURE:   a  |  b  | c_in | sum | c_out" & LF & 
                    "     EXPECTED: '1' | '1' | '0'  | '0' | '1' " & LF & 
                    "     ACTUAL:   " &   std_logic'image(a_sig) & " | " & 
                                        std_logic'image(b_sig) & " | " & 
                                        std_logic'image(c_in_sig) & "  | " & 
                                        std_logic'image(sum_sig_beh) & " | " & std_logic'image(c_out_sig_beh) & LF &
                    "     STRUCT:   " &   std_logic'image(a_sig) & " | " & 
                                        std_logic'image(b_sig) & " | " & 
                                        std_logic'image(c_in_sig) & "  | " & 
                                        std_logic'image(sum_sig_struc) & " | " & std_logic'image(c_out_sig_struc) & LF;                              
        
        a_sig <= '0';
        b_sig <= '0';
        c_in_sig <= '1';
        wait for DELTA_DELAY;
        assert (sum_sig_beh = '1' AND c_out_sig_beh = '0')
            report LF & 
                    "     FAILURE:   a  |  b  | c_in | sum | c_out" & LF & 
                    "     EXPECTED: '0' | '0' | '1'  | '1' | '0' " & LF & 
                    "     ACTUAL:   " &   std_logic'image(a_sig) & " | " & 
                                        std_logic'image(b_sig) & " | " & 
                                        std_logic'image(c_in_sig) & "  | " & 
                                        std_logic'image(sum_sig_beh) & " | " & std_logic'image(c_out_sig_beh) & LF &
                    "     STRUCT:   " &   std_logic'image(a_sig) & " | " & 
                                        std_logic'image(b_sig) & " | " & 
                                        std_logic'image(c_in_sig) & "  | " & 
                                        std_logic'image(sum_sig_struc) & " | " & std_logic'image(c_out_sig_struc) & LF;

        a_sig <= '1';
        b_sig <= '0';
        c_in_sig <= '1';
        wait for DELTA_DELAY;
        assert (sum_sig_beh = '0' AND c_out_sig_beh = '1')
            report LF & 
                    "     FAILURE:   a  |  b  | c_in | sum | c_out" & LF & 
                    "     EXPECTED: '1' | '0' | '1'  | '0' | '1' " & LF & 
                    "     ACTUAL:   " &   std_logic'image(a_sig) & " | " & 
                                        std_logic'image(b_sig) & " | " & 
                                        std_logic'image(c_in_sig) & "  | " & 
                                        std_logic'image(sum_sig_beh) & " | " & std_logic'image(c_out_sig_beh) & LF &
                    "     STRUCT:   " &   std_logic'image(a_sig) & " | " & 
                                        std_logic'image(b_sig) & " | " & 
                                        std_logic'image(c_in_sig) & "  | " & 
                                        std_logic'image(sum_sig_struc) & " | " & std_logic'image(c_out_sig_struc) & LF;

        a_sig <= '0';
        b_sig <= '1';
        c_in_sig <= '1';
        wait for DELTA_DELAY;
        assert (sum_sig_beh = '0' AND c_out_sig_beh = '1')
            report LF & 
                    "     FAILURE:   a  |  b  | c_in | sum | c_out" & LF & 
                    "     EXPECTED: '0' | '1' | '1'  | '0' | '1' " & LF & 
                    "     ACTUAL:   " &   std_logic'image(a_sig) & " | " & 
                                        std_logic'image(b_sig) & " | " & 
                                        std_logic'image(c_in_sig) & "  | " & 
                                        std_logic'image(sum_sig_beh) & " | " & std_logic'image(c_out_sig_beh) & LF &
                    "     STRUCT:   " &   std_logic'image(a_sig) & " | " & 
                                        std_logic'image(b_sig) & " | " & 
                                        std_logic'image(c_in_sig) & "  | " & 
                                        std_logic'image(sum_sig_struc) & " | " & std_logic'image(c_out_sig_struc) & LF;

        a_sig <= '1';
        b_sig <= '1';
        c_in_sig <= '1';
        wait for DELTA_DELAY;
        assert (sum_sig_beh = '1' AND c_out_sig_beh = '1')
            report LF & 
                    "     FAILURE:   a  |  b  | c_in | sum | c_out" & LF & 
                    "     EXPECTED: '1' | '1' | '1'  | '1' | '1' " & LF & 
                    "     ACTUAL:   " &   std_logic'image(a_sig) & " | " & 
                                        std_logic'image(b_sig) & " | " & 
                                        std_logic'image(c_in_sig) & "  | " & 
                                        std_logic'image(sum_sig_beh) & " | " & std_logic'image(c_out_sig_beh) & LF &
                    "     STRUCT:   " &   std_logic'image(a_sig) & " | " & 
                                        std_logic'image(b_sig) & " | " & 
                                        std_logic'image(c_in_sig) & "  | " & 
                                        std_logic'image(sum_sig_struc) & " | " & std_logic'image(c_out_sig_struc) & LF;
        
        wait;

    end process test;

end architecture behavioral;
