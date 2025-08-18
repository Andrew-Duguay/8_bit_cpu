library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package util_pkg is	 
	impure function to_string( vec : std_logic_vector) return string;
end package util_pkg;	 	

package body util_pkg is																   

    impure function to_string ( vec : std_logic_vector) return string is
        constant size : integer := vec'length;
        variable str : string (1 to size);
        begin 	   
            for i in 1 to size loop
                str(i)  := std_logic'image(vec(size - i))(2);
            end loop;     		  
        return str;
    end function to_string;

end package body;  


