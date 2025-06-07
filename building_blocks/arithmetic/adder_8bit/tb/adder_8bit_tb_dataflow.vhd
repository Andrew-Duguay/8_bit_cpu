library IEEE;
library building_blocks_lib;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use building_blocks_lib.util_pkg.all;

entity adder_8bit_tb_dataflow is
end entity adder_8bit_tb_dataflow;

architecture behavioral of adder_8bit_tb_dataflow is

    signal a_sig  : STD_LOGIC_VECTOR(7 downto 0) := "00000000"; 
    signal b_sig  : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
    signal c_in_sig  : std_logic := '0'; 
    signal sum_sig  : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
    signal c_out_sig  : std_logic;  
    constant DELTA_DELAY : time :=  10 ns;

begin
    uut_adder_8bit : entity work.adder_8bit(dataFlow)
        port map (
            a_in    => a_sig,
            b_in    => b_sig,
            c_in    => c_in_sig,
            sum     => sum_sig,
            c_out   => c_out_sig
        );

    test : process
    variable a_var, b_var , temp_sum: INTEGER;
    variable temp_sum_vector : STD_LOGIC_VECTOR(8 downto 0);
    begin
        ADD1 : for i in 0 to 255 loop
            ADD2 : for j in 0 to 255 loop
                a_sig <= STD_LOGIC_VECTOR(to_unsigned(i,8));
                b_sig <= STD_LOGIC_VECTOR(to_unsigned(j,8));
                a_var := i;
                b_var := j;
                temp_sum := a_var + b_var;
                temp_sum_vector := STD_LOGIC_VECTOR(to_unsigned(temp_sum,9));
                wait for DELTA_DELAY;   

                assert (sum_sig = temp_sum_vector(7 downto 0) AND c_out_sig = temp_sum_vector(8))
                    report  LF & "     FAILURE:         a     |    b     |  c_in |   sum     |  c_out " & 
                            LF & "     OUTPUT:       " & to_string(a_sig) & " | " & to_string(b_sig) & " |  " & 
                                        std_logic'image(c_in_sig) & "  | " &
                                        to_string(sum_sig) & "  | " & std_logic'image(c_out_sig) & 
                            LF & "     i:   " & INTEGER'image(i) & "      j:   " & INTEGER'image(j)
                    severity FAILURE;
            end loop;
        end loop; -- ADD

        wait;

    end process test;

end architecture behavioral;
