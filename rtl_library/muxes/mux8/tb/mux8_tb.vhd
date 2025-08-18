library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity mux8_tb is
end entity mux8_tb;

architecture behavioral of mux8_tb is

    component mux8 is
        port (
            sel : in  std_logic_vector(2 downto 0);
            a  : in  std_logic_vector(7 downto 0);
            z_out : out std_logic
        );
    end component mux8;

    signal sel_sig  : std_logic_vector(2 downto 0) := "000"; 
    signal a_sig  : std_logic_vector(7 downto 0) := "00000000";
    signal z_sig : std_logic; 
    constant DELTA_DELAY : time :=  1 ns;

begin
    uut_mux8 : component mux8
        port map (
            sel  => sel_sig,
            a  => a_sig,
            z_out => z_sig
        );

    test : process
    begin

        THE_LOOP : for i in 0 to 7 loop
            sel_sig <= STD_LOGIC_VECTOR(to_unsigned(i, 3));
            a_sig(i) <= '1';
            wait for DELTA_DELAY;
            assert (z_sig = a_sig(i))
                report  "Failure: sel == " & integer'image(to_integer(unsigned(sel_sig))) & 
                        ", a(i) == " & std_logic'image(a_sig(i)) & 
                        ", Output == " & std_logic'image(z_sig);
            a_sig(i) <= '0';
            wait for DELTA_DELAY;
            assert (z_sig = a_sig(i))
                report  "Failure: sel == " & integer'image(to_integer(unsigned(sel_sig))) & 
                        ", a(i) == " & std_logic'image(a_sig(i)) & 
                        ", Output == " & std_logic'image(z_sig);
        end loop; -- 

        wait;

    end process test;

end architecture behavioral;
