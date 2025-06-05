library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity shifter_8bit_tb_dataflow is
end entity shifter_8bit_tb_dataflow;

architecture behavioral of shifter_8bit_tb_dataflow is

    signal a_sig  : STD_LOGIC_VECTOR(7 downto 0); 
    signal arith_sig  : STD_LOGIC;
    signal rot_sig  : STD_LOGIC; 
    signal dir_sig  : STD_LOGIC;
    signal n_bit_sig  : STD_LOGIC_VECTOR(2 downto 0); 
    signal result_sig : STD_LOGIC_VECTOR(7 downto 0);  
    constant DELTA_DELAY : time :=  10 ns;
    type test_case_array is array (natural range<>) of std_logic_vector(7 downto 0);
    constant test_cases : test_case_array := (
            0  => "00000000",    -- zeroes
            1  => "00000001",    -- smallest positive
            2  => "11111111",    -- ones
            3  => "10000000",    -- smallest negative
            4  => "01111111",    -- largest positive
            5  => "01010101",    -- pattern a
            6  => "10101010",    -- pattern b
            7  => "11001100",    -- pattern c
            8  => "11100111",    -- pattern d
            9  => "11110000",    -- pattern e
            10 => "11000011",    -- pattern f
            11 => "10000001"     -- pattern g
        );

begin
    
    uut_shifter_8bit : entity work.shifter_8bit(dataFlow)
        port map (
            a_in        => a_sig,
            arith       => arith_sig,
            rot         => rot_sig,
            direction   => dir_sig,  
            num_bits    => n_bit_sig,
            result      => result_sig
        );

    TB_PROCESS : process
    variable a_str, r_str, a_exp, r_exp : string(1 to 8);
    variable a_var, r_var : std_logic_vector(7 downto 0);
    begin
        --Logical shift left
        arith_sig <= '0';
        rot_sig <= '0';
        dir_sig <= '0';
        L_S_L : for i in test_cases'range loop
            SHIFT_AMOUNT_LOOP: for j in 0 to 7 loop
                a_sig       <= test_cases(i);          
                n_bit_sig   <= std_logic_vector(to_unsigned(j, 3));
                wait for DELTA_DELAY;
                a_var := test_cases(i);
                r_var := (a_var sll j);

                CONVERT_TO_STRING_FOR_DEBUG: for k in 1 to 8  loop
                    a_str(9-k) := std_logic'image(a_sig(k-1))(2);
                    r_str(9-k) := std_logic'image(result_sig(k-1))(2);
                    a_exp(9-k) := std_logic'image(a_var(k-1))(2);
                    r_exp(9-k) := std_logic'image(r_var(k-1))(2);
                end loop; 

                assert (result_sig = r_var)
                    report  LF & "     FAILURE:       di |  ar |  ro | n |    a     |    r    " & 
                            LF & "     OUTPUT:       " &    std_logic'image(dir_sig) & " | " & 
                                                            std_logic'image(arith_sig) & " | " & 
                                                            std_logic'image(rot_sig) & " | " & 
                                                            integer'image(j) & " | " & 
                                                            a_str & " | " & 
                                                            r_str &                                       
                            LF & "     EXPECTED:     " &    std_logic'image(dir_sig) & " | " & 
                                                            std_logic'image(arith_sig) & " | " & 
                                                            std_logic'image(rot_sig) & " | " & 
                                                            integer'image(j) & " | " & 
                                                            a_exp & " | " & 
                                                            r_exp 
                    severity FAILURE;
            end loop;
        end loop;
        wait;

    end process TB_PROCESS;

end architecture behavioral;
