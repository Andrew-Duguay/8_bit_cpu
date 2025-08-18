@echo off

echo =================================================================================================================
echo ========================== [MASTER SCRIPT] Starting all component testbench scripts... ==========================
echo =================================================================================================================

REM Use FOR /F to process the output of the 'dir' command.
REM 'dir /s /b run_tests.bat' finds every file named "run_tests.bat"
REM in the current directory and all subdirectories, and lists its full path.
FOR /F "delims=" %%F IN ('dir /s /b run_tests.bat') DO (


    REM %%~dpF gets the drive and path of the found file (e.g., C:\path\to\component\sim\)
    echo.
    FOR %%P IN ("%%~dpF..") DO echo ----- STARTING TESTS FOR: %%~nxP -----
    pushd "%%~dpF"
    
    
    REM %%~nxF gets the name and extension of the file (e.g., run_tests.bat)
    call "%%~nxF"
    
    popd
)

echo.
echo ================================================================================================================
echo ========================== [MASTER SCRIPT] All component testbench scripts processed. ==========================
echo ================================================================================================================