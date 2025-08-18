library IEEE;
library rtl_lib;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use rtl_lib.util_pkg.all;

entity not_8bit_tb_structural is
end entity not_8bit_tb_structural;

architecture behavioral of not_8bit_tb_structural is

    signal a_sig  : STD_LOGIC_VECTOR(7 downto 0); 
    signal sum_sig  : STD_LOGIC_VECTOR(7 downto 0);
    constant DELTA_DELAY : time :=  10 ns;

begin
    uut_not_8bit : entity work.not_8bit(structural)
        port map (
            a_in    => a_sig,
            sum     => sum_sig
        );

    test : process
        variable sum_var : STD_LOGIC_VECTOR(7 downto 0);
        begin
            a_loop : for i in 0 to 255 loop
                a_sig <= STD_LOGIC_VECTOR(to_unsigned(i,8));
                wait for DELTA_DELAY;
                sum_var := not a_sig;   

                assert (sum_sig = sum_var)
                    report  LF & "     FAILURE:        a  |  sum  " & 
                            LF & "     OUTPUT:       " & to_string(a_sig)  & " |  " & to_string(sum_sig) & 
                            LF & "     i:   " & INTEGER'image(i)
                    severity FAILURE;
            end loop; -- ADD
            wait;
    end process test;

end architecture behavioral;
