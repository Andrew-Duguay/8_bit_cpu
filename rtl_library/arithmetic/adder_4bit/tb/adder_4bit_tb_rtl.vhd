library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity adder_4bit_tb_rtl is
end entity adder_4bit_tb_rtl;

architecture behavioral of adder_4bit_tb_rtl is

    signal a_sig  : STD_LOGIC_VECTOR(3 downto 0) := "0000"; 
    signal b_sig  : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal c_in_sig  : std_logic := '0'; 
    signal sum_sig  : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal c_out_sig  : std_logic;  
    constant DELTA_DELAY : time :=  10 ns;

begin
    uut_adder_4bit : entity work.adder_4bit(rtl)
        port map (
            a_in    => a_sig,
            b_in    => b_sig,
            c_in    => c_in_sig,
            sum     => sum_sig,
            c_out   => c_out_sig
        );

    test : process
    variable a_var, b_var , temp_sum: INTEGER;
    variable temp_sum_vector : STD_LOGIC_VECTOR(4 downto 0);
    variable a_str, b_str, sum_str : string(1 to 4);
    begin
        ADD1 : for i in 0 to 15 loop
            ADD2 : for j in 0 to 15 loop
                a_sig <= STD_LOGIC_VECTOR(to_unsigned(i,4));
                b_sig <= STD_LOGIC_VECTOR(to_unsigned(j,4));
                a_var := i;
                b_var := j;
                temp_sum := a_var + b_var;
                temp_sum_vector := STD_LOGIC_VECTOR(to_unsigned(temp_sum,5));
                wait for DELTA_DELAY;

                CONVERT_TO_STRING_FOR_DEBUG: for k in 1 to 4  loop
                    a_str(5-k) := std_logic'image(a_sig(k-1))(2);
                    b_str(5-k) := std_logic'image(b_sig(k-1))(2);
                    sum_str(5-k) := std_logic'image(sum_sig(k-1))(2);
                end loop;         

                assert (sum_sig = temp_sum_vector(3 downto 0) AND c_out_sig = temp_sum_vector(4))
                    report  LF & "     FAILURE:        a  |   b  |  c_in |  sum  |  c_out " & 
                            LF & "     OUTPUT:       " & a_str & " | " & b_str & " |  " & 
                                        std_logic'image(c_in_sig) & "  | " &
                                        sum_str & "  | " & std_logic'image(c_out_sig) & 
                            LF & "     i:   " & INTEGER'image(i) & "      j:   " & INTEGER'image(j)
                    severity FAILURE;
            end loop;
        end loop; -- ADD

        wait;

    end process test;

end architecture behavioral;
