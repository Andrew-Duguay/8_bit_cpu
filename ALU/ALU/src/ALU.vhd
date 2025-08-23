library ieee;
library rtl_lib;

use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;
use work.ALU_config_pkg;
-- Op code
--  ADD     0000
--  SUB     0001
--  AND     0010
--  NOT     0011
--  XOR     0100
--  OR      0101
--  SLL     0110 -> status bits: d & r & a = 000
--  SLA     0111 -> status bits: d & r & a = 001
--  ROL     1000 -> status bits: d & r & a = 010
--  SRL     1001 -> ...
--  SRA     1010
--  R0R     1011


entity ALU is
    port (
        a_in   : in STD_LOGIC_VECTOR(7 downto 0);
        b_in   : in STD_LOGIC_VECTOR(7 downto 0);
        op_code : in STD_LOGIC_VECTOR(3 downto 0); 
        num_bits : in STD_LOGIC_VECTOR(2 downto 0); -- for shifting
        z_out  : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity ALU;

architecture rtl of ALU is
    signal output_mux_sel       : STD_LOGIC_VECTOR(2 downto 0);
    signal shifter_status_bits  : STD_LOGIC_VECTOR(2 downto 0);
    signal z_adder  : STD_LOGIC_VECTOR(7 downto 0);
    signal z_and    : STD_LOGIC_VECTOR(7 downto 0);
    signal z_not    : STD_LOGIC_VECTOR(7 downto 0);
    signal z_xor    : STD_LOGIC_VECTOR(7 downto 0);
    signal z_or     : STD_LOGIC_VECTOR(7 downto 0);
    signal z_shift  : STD_LOGIC_VECTOR(7 downto 0);
    signal z_ALU    : STD_LOGIC_VECTOR(7 downto 0);

    begin
        output_mux_sel       <= output_mux_sel_LUT(TO_INTEGER(UNSIGNED(op_code)));
        shifter_status_bits  <= shifter_ctrl_LUT(TO_INTEGER(UNSIGNED(op_code)));
       
        adder_unit : entity rtl_lib.adder_8bit(rtl)
            port map (
                a_in    => a_in,
                b_in    => b_in,
                c_in    => c_in,
                sum     => z_adder,
                c_out   => c_out
            );
        and_unit : entity rtl_lib.and_8bit(dataflow)
            port map (
                a_in    => a_in,
                b_in    => b_in,
                sum     => z_and
            );
        not_unit : entity rtl_lib.not_8bit(dataflow)
            port map (
                a_in    => a_in,
                sum     => z_not
            );
        xor_unit : entity rtl_lib.xor_8bit(dataflow)
            port map (
                a_in    => a_in,
                b_in    => b_in,
                sum     => z_xor
            );
        or_unit : entity rtl_lib.or_8bit(dataflow)
            port map (
                a_in    => a_in,
                b_in    => b_in,
                sum     => z_or
            );
        shift_unit : entity rtl_lib.shifter_8bit(dataFlow)
            port map (
                a_in        => a_in,
                arith       => shifter_status_bits(0),
                rot         => shifter_status_bits(1),
                direction   => shifter_status_bits(2),  
                num_bits    => num_bits,
                result      => z_shift
            );
        
            
        output_muxes : for i in 0 to 7 generate 
            muxes : entity rtl_lib.mux8(rtl)  
                port map (
                    sel  => output_mux_sel,
                    a0    => z_adder(i),
                    a1    => z_and(i),
                    a2    => z_not(i),
                    a3    => z_xor(i),
                    a4    => z_or(i),
                    a5    => z_shift(i),
                    a6    => '0', -- Assuming a6 and a7 are unused for now
                    a7    => '0',
                    z_out => z_ALU(i)
                );
        end generate;
        z_out <= z_ALU;
end architecture rtl;    