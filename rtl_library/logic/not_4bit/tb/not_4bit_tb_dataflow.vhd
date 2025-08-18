library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity not_4bit_tb_dataflow is
end entity not_4bit_tb_dataflow;

architecture behavioral of not_4bit_tb_dataflow is

    signal a_sig  : STD_LOGIC_VECTOR(3 downto 0); 
    signal sum_sig  : STD_LOGIC_VECTOR(3 downto 0);
    constant DELTA_DELAY : time :=  10 ns;

begin
    uut_not_4bit : entity work.not_4bit(dataFlow)
        port map (
            a_in    => a_sig,
            sum     => sum_sig
        );

    test : process
        variable sum_var : STD_LOGIC_VECTOR(3 downto 0);
        variable a_str, sum_str : string(1 to 4);
        begin
            a_loop : for i in 0 to 15 loop
                a_sig <= STD_LOGIC_VECTOR(to_unsigned(i,4));
                wait for DELTA_DELAY;
                sum_var := not a_sig;

                CONVERT_TO_STRING_FOR_DEBUG: for k in 1 to 4  loop
                    a_str(5-k) := std_logic'image(a_sig(k-1))(2);
                    sum_str(5-k) := std_logic'image(sum_sig(k-1))(2);
                end loop;         

                assert (sum_sig = sum_var)
                    report  LF & "     FAILURE:        a  |  sum  " & 
                            LF & "     OUTPUT:       " & a_str  & " |  " & sum_str & 
                            LF & "     i:   " & INTEGER'image(i)
                    severity FAILURE;
            end loop; -- ADD
            wait;
    end process test;

end architecture behavioral;
