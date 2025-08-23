library IEEE;
library rtl_lib;
use rtl_lib.all;
use IEEE.STD_LOGIC_1164.all;

package ALU_config_pkg is
    type opcode_sel_LUT is array (0 to 15) of STD_LOGIC_VECTOR(2 downto 0);
    constant output_mux_sel_LUT : opcode_sel_LUT := (
        0  => "000",  -- Opcode: 0000  Select: 000
        1  => "000",  -- Opcode: 0001  Select: 000
        2  => "001",  -- Opcode: 0010  Select: 001
        3  => "010",  -- Opcode: 0011  Select: 010
        4  => "011",  -- Opcode: 0100  Select: 011
        5  => "100",  -- Opcode: 0101  Select: 100
        6  => "101",  -- Opcode: 0110  Select: 101
        7  => "101",  -- Opcode: 0111  Select: 101
        8  => "101",  -- Opcode: 1000  Select: 101
        9  => "101",  -- Opcode: 1001  Select: 101
        10 => "101",  -- Opcode: 1010  Select: 101
        11 => "101",  -- Opcode: 1011  Select: 101
        others => "111" 
    );
    constant shifter_ctrl_LUT : opcode_sel_LUT := (     --DIR & ROT & ARITH
        6  => "000",  -- Opcode: 0110 
        7  => "001",  -- Opcode: 0111  
        8  => "010",  -- Opcode: 1000  
        9  => "100",  -- Opcode: 1001 
        10 => "101",  -- Opcode: 1010 
        11 => "110",  -- Opcode: 1011  
        others => "XXX"
    );
end package ALU_config_pkg;