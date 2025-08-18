library IEEE;
library rtl_lib;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use rtl_lib.util_pkg.all;

entity or_8bit_tb_dataflow is
end entity or_8bit_tb_dataflow;

architecture behavioral of or_8bit_tb_dataflow is

    signal a_sig  : STD_LOGIC_VECTOR(7 downto 0); 
    signal b_sig  : STD_LOGIC_VECTOR(7 downto 0);
    signal sum_sig  : STD_LOGIC_VECTOR(7 downto 0);
    constant DELTA_DELAY : time :=  10 ns;

begin
    uut_or_8bit : entity work.or_8bit(dataflow)
        port map (
            a_in    => a_sig,
            b_in    => b_sig,
            sum     => sum_sig
        );

    test : process
        variable sum_var : STD_LOGIC_VECTOR(7 downto 0);
        begin
            a_loop : for i in 0 to 255 loop
                b_loop : for j in 0 to 255 loop
                    a_sig <= STD_LOGIC_VECTOR(to_unsigned(i,8));
                    b_sig <= STD_LOGIC_VECTOR(to_unsigned(j,8));
                    sum_var := STD_LOGIC_VECTOR(to_unsigned(i,8)) OR STD_LOGIC_VECTOR(to_unsigned(j,8));
                    wait for DELTA_DELAY;
     

                    assert (sum_sig = sum_var)
                        report  LF & "     FAILURE:        a  |   b  |  sum  " & 
                                LF & "     OUTPUT:       " & to_string(a_sig) & " | " & to_string(b_sig) & " |  " & to_string(sum_sig) & 
                                LF & "     i:   " & INTEGER'image(i) & "      j:   " & INTEGER'image(j)
                        severity FAILURE;
                end loop;
            end loop; -- ADD
            wait;
    end process test;

end architecture behavioral;
