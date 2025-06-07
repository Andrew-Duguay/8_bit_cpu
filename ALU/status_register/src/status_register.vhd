library ieee;
use ieee.std_logic_1164.all;

entity status_register is
    port (
        z_flag   : out STD_LOGIC;
        n_flag   : out STD_LOGIC;
        v_flag   : out STD_LOGIC;
        c_flag   : out STD_LOGIC
    );
end entity status_register;

architecture rtl of status_register is
begin
    
end architecture rtl;    