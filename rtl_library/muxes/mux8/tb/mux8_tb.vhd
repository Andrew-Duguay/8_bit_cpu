library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity mux8_tb is
end entity mux8_tb;

architecture behavioral of mux8_tb is

    component mux8 is
        port (
            sel : in  std_logic_vector(2 downto 0);
            a0 : in std_logic;
            a1 : in std_logic;
            a2 : in std_logic;
            a3 : in std_logic;
            a4 : in std_logic;
            a5 : in std_logic;
            a6 : in std_logic;
            a7 : in std_logic;
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
            a0    => a_sig(0),
            a1    => a_sig(1),
            a2    => a_sig(2),
            a3    => a_sig(3),
            a4    => a_sig(4),
            a5    => a_sig(5),
            a6    => a_sig(6), -- Assuming a6 and a7 are unused for now
            a7    => a_sig(7),
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
