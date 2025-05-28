library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity and_4bit_tb_structural is
end entity and_4bit_tb_structural;

architecture behavioral of and_4bit_tb_structural is

    signal a_sig  : STD_LOGIC_VECTOR(3 downto 0); 
    signal b_sig  : STD_LOGIC_VECTOR(3 downto 0);
    signal sum_sig  : STD_LOGIC_VECTOR(3 downto 0);
    constant DELTA_DELAY : time :=  10 ns;

begin
    uut_and_4bit : entity work.and_4bit(structural)
        port map (
            a_in    => a_sig,
            b_in    => b_sig,
            sum     => sum_sig
        );

    test : process
        variable sum_var : STD_LOGIC_VECTOR(3 downto 0);
        variable a_str, b_str, sum_str : string(1 to 4);
        begin
            a_loop : for i in 0 to 15 loop
                b_loop : for j in 0 to 15 loop
                    a_sig <= STD_LOGIC_VECTOR(to_unsigned(i,4));
                    b_sig <= STD_LOGIC_VECTOR(to_unsigned(j,4));
                    sum_var := STD_LOGIC_VECTOR(to_unsigned(i,4)) AND STD_LOGIC_VECTOR(to_unsigned(j,4));
                    wait for DELTA_DELAY;

                    CONVERT_TO_STRING_FOR_DEBUG: for k in 1 to 4  loop
                        a_str(5-k) := std_logic'image(a_sig(k-1))(2);
                        b_str(5-k) := std_logic'image(b_sig(k-1))(2);
                        sum_str(5-k) := std_logic'image(sum_sig(k-1))(2);
                    end loop;         

                    assert (sum_sig = sum_var)
                        report  LF & "     FAILURE:        a  |   b  |  sum  " & 
                                LF & "     OUTPUT:       " & a_str & " | " & b_str & " |  " & sum_str & 
                                LF & "     i:   " & INTEGER'image(i) & "      j:   " & INTEGER'image(j)
                        severity FAILURE;
                end loop;
            end loop; -- ADD
            wait;
    end process test;

end architecture behavioral;
