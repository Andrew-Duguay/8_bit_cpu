@echo off
rem Script to analyze all VHDL files and then run each testbench individually.

rem --- Configuration ---
echo [CONFIG]      Setting VHDL standard to 2008.
set GHDL_ARGS=--std=08

rem A list of all your testbench entity names, separated by spaces.
set TESTBENCHES=fullAdder_tb

rem --- Step 1: Analyze all source files at once ---
echo [STEP 1]      Analyzing all src and Testbench files...
ghdl -a %GHDL_ARGS% ..\src\*.vhd ..\tb\*.vhd ..\..\gates\src\*.vhd

rem Check if analysis was successful. If not, stop the script.
if %errorlevel% neq 0 (
    echo [ERROR]       VHDL analysis failed. Halting script.
    goto :eof
)
echo [SUCCESS]     All files analyzed successfully.

rem --- Step 2: Loop through each testbench to elaborate and run ---
echo [STEP 2]      Running all specified testbenches...

for %%T in (%TESTBENCHES%) do (
echo               Running: %%T 
    ghdl -e %GHDL_ARGS% %%T
    ghdl -r %GHDL_ARGS% %%T --fst=%%T.fst
)

echo [SUCCESS] All testbenches have been run.