library IEEE;
library rtl_lib;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use rtl_lib.util_pkg.all;

entity shifter_8bit_tb_dataflow is
end entity shifter_8bit_tb_dataflow;

architecture behavioral of shifter_8bit_tb_dataflow is

    signal a_sig  : STD_LOGIC_VECTOR(7 downto 0) := (others=> '0'); 
    signal stat_sig  : STD_LOGIC_VECTOR(2 downto 0):= (others=> '0');  -- arith & rot & dir
    signal n_bit_sig  : STD_LOGIC_VECTOR(2 downto 0):= (others=> '0'); 
    signal result_sig : STD_LOGIC_VECTOR(7 downto 0):= (others=> '0');  
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
            arith       => stat_sig(2),
            rot         => stat_sig(1),
            direction   => stat_sig(0),  
            num_bits    => n_bit_sig,
            result      => result_sig
        );

    TB_PROCESS : process
    variable a_var, r_var : std_logic_vector(7 downto 0);
    begin
        --Logical shift left
        
        SHIFT_TYPES_LOOP: for h in 0 to 7 loop
            stat_sig <= std_logic_vector(to_unsigned(h,3));
            L_S_L : for i in test_cases'range loop
                a_sig <= test_cases(i); 
                a_var := test_cases(i);
                SHIFT_AMOUNT_LOOP: for j in 0 to 7 loop                            
                    n_bit_sig   <= std_logic_vector(to_unsigned(j, 3));
                    wait for DELTA_DELAY;

                    if(h=0)     then  r_var := (a_var sll j);                                   -- arith = 0,  rot = 0,  dir = 0
                    elsif(h=1)  then  r_var := (a_var srl j);                                   -- arith = 0,  rot = 0,  dir = 1
                    elsif(h=2)  then  r_var := (a_var rol j);                                   -- arith = 0,  rot = 1,  dir = 0
                    elsif(h=3)  then  r_var := (a_var ror j);                                   -- arith = 0,  rot = 1,  dir = 1
                    elsif(h=4)  then  r_var := std_logic_vector(shift_left(signed(a_var), j));  -- arith = 1,  rot = 0,  dir = 0
                    elsif(h=5)  then  r_var := std_logic_vector(shift_right(signed(a_var), j)); -- arith = 1,  rot = 0,  dir = 1
                    elsif(h=6)  then  r_var := (others => 'X');                                 -- arith = 1,  rot = 1,  dir = 0
                    elsif(h=7)  then  r_var := (others => 'X');                                 -- arith = 1,  rot = 1,  dir = 1
                    end if;

                    assert (result_sig = r_var)
                        report  LF & "     FAILURE:       di |  ar |  ro | n |    a     |    r    " & 
                                LF & "     OUTPUT:       " &    std_logic'image(stat_sig(0)) & " | " & 
                                                                std_logic'image(stat_sig(2)) & " | " & 
                                                                std_logic'image(stat_sig(1)) & " | " & 
                                                                integer'image(j) & " | " & 
                                                                to_string(a_sig)  & " | " & 
                                                                to_string(result_sig)  &                                       
                                LF & "     EXPECTED:     " &    std_logic'image(stat_sig(0)) & " | " & 
                                                                std_logic'image(stat_sig(2)) & " | " & 
                                                                std_logic'image(stat_sig(1)) & " | " & 
                                                                integer'image(j) & " | " & 
                                                                to_string(a_var)  & " | " & 
                                                                to_string(r_var) 
                        severity FAILURE;
                end loop;
            end loop;
        end loop;
        wait;

    end process TB_PROCESS;

end architecture behavioral;
