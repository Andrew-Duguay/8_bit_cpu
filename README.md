Reccomended toolchain:
1. GHDL
2. Vscode
   a. GHDL Vscode extension
   b. GHDL LS extension

Directory Structure:
8_bit_cpu (root)     -  Root folder. Supporting components placed here 
.\my_vhdl_libraries  -  Basic components needed to build the ALU
.\src                -  stores source code
.\tb                 -  stores testbench code
.\sim                -  store work file and testing script
.\run_tests.bat      -  Test file. Executes all testbenches for that component.

Testing a Component:
1. Clone repository
2. Navigate to that component from the command line.
3. Execute run_tests.bat

Testing All Components:
1. Clone repository
2. Navigate to .\8_bit_cpu\my_vhdl_libraries
3. Execute master_run_tests.bat


Each component has sim folder where testbench code is to be analyzed, elaborated and ran.
In the sim folder is a run_tests.bat that executes all testbenches.
All Testbenches outline comprehensive assert statements and neatly formatted debug information printed to terminal
