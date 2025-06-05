@echo off
REM Batch file to compile basic gate components into a library named "gate_lib".

REM --- Configuration ---
SETLOCAL
SET VHDL_STANDARD=--std=08
SET LIBRARY_NAME=gate_lib
SET GATE_SOURCE_DIR=.\src
SET OUTPUT_DIR=.\gate_lib

echo [INFO] Creating VHDL library: %LIBRARY_NAME%
echo [INFO] VHDL Standard: %VHDL_STANDARD:~6%
echo [INFO] Gate source directory: %GATE_SOURCE_DIR%
echo [INFO] Compiled library output directory: %OUTPUT_DIR%
echo -----------------------------------------------------

REM Create the output directory if it doesn't exist
IF NOT EXIST "%OUTPUT_DIR%" (
    echo [SETUP] Creating output directory: %OUTPUT_DIR%
    mkdir "%OUTPUT_DIR%"
    IF ERRORLEVEL 1 (
        echo [ERROR] Failed to create output directory. Exiting.
        goto :eof
    )
)

REM --- Compilation Step ---
echo [COMPILE] Analyzing gate files into library '%LIBRARY_NAME%'...

REM The --workdir option tells GHDL where to place the compiled library files
REM The --work option tells GHDL the logical name of the library to compile into
ghdl -a %VHDL_STANDARD% --work=%LIBRARY_NAME% --workdir="%OUTPUT_DIR%" %GATE_SOURCE_DIR%\*.vhd

REM Check for analysis errors
IF ERRORLEVEL 1 (
    echo.
    echo [ERROR] VHDL analysis of gates failed. Library not created successfully.
    goto :eof
)

echo.
echo [SUCCESS] Library '%LIBRARY_NAME%' created successfully in '%OUTPUT_DIR%'.
echo -----------------------------------------------------

ENDLOCAL
goto :eof