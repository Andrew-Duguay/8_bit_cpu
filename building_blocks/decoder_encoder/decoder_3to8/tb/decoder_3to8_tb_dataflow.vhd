library IEEE;
library building_blocks_lib;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use building_blocks_lib.all;

entity decoder_3to8_tb_dataflow is
end entity decoder_3to8_tb_dataflow;

architecture behavioral of decoder_3to8_tb_dataflow is

    signal a_sig  : STD_LOGIC_VECTOR(2 downto 0) := (others=>'0'); 
    signal z_sig  : STD_LOGIC_VECTOR(7 downto 0) := (others=>'0');
    constant DELTA_DELAY : time :=  10 ns;

begin
    uut_decoder_3to8 : entity building_blocks_lib.decoder_3to8(dataFlow)
        port map (
            a_in    => a_sig,
            z_out   => z_sig
        );

    TB_PROCESS : process
    variable z_size : integer := z_sig'length;
    constant z_exp : STD_LOGIC_VECTOR(7 downto 0) := "00000001";
    begin
        ADD1 : for i in 0 to 7 loop
            a_sig <= std_logic_vector( to_unsigned(i,3));
            wait for DELTA_DELAY;

            assert (z_sig = std_logic_vector( SHIFT_LEFT( unsigned(z_exp), i) ))
                report  LF & "     FAILURE:        a   |    z " & 
                        LF & "     OUTPUT:       " & to_string(a_sig) & " | " & to_string(z_sig)
                severity FAILURE;
        end loop; -- ADD

        wait;

    end process TB_PROCESS;

end architecture behavioral;
