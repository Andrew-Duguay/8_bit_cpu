library IEEE;
library building_blocks_lib;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use building_blocks_lib.all;

entity encoder_8to3_tb_dataflow is
end entity encoder_8to3_tb_dataflow;

architecture behavioral of encoder_8to3_tb_dataflow is

    signal a_sig  : STD_LOGIC_VECTOR(7 downto 0) := (others=>'0'); 
    signal z_sig  : STD_LOGIC_VECTOR(2 downto 0) := (others=>'0');
    constant DELTA_DELAY : time :=  10 ns;

begin
    uut_encoder_8to3 : entity building_blocks_lib.encoder_8to3(dataFlow)
        port map (
            a_in    => a_sig,
            z_out   => z_sig
        );

    TB_PROCESS : process
    constant mask : std_logic_vector(7 downto 0) := "00000001";
    begin
        ADD1 : for i in 0 to 7 loop
            a_sig <= std_logic_vector( SHIFT_LEFT( unsigned(mask), i) );
            wait for DELTA_DELAY;
            assert (to_integer(unsigned(z_sig)) = i)
                report  LF & "     FAILURE:          a    |   z " & 
                        LF & "     OUTPUT:       " & to_string(a_sig) & " | " & to_string(z_sig)
                severity FAILURE;

            a_sig <= a_sig OR "10000001";
            wait for DELTA_DELAY;          
            assert (z_sig = "XXX")
                report  LF & "     FAILURE:          a    |   z " & 
                        LF & "     OUTPUT:       " & to_string(a_sig) & " | " & to_string(z_sig)
                severity FAILURE;
        end loop; -- ADD

        wait;

    end process TB_PROCESS;

end architecture behavioral;
