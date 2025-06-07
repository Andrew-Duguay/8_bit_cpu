# --- Configuration ---
$VHDL_STANDARD = "--std=08"
$LIBRARY_NAME = "building_blocks_lib"
$SOURCE_DIR = "."
$OUTPUT_DIR = ".\building_blocks_lib"

# --- Setup ---
Write-Host "[INFO] Creating VHDL library: $LIBRARY_NAME"
# Create the output directory if it doesn't exist
if (-not (Test-Path -Path $OUTPUT_DIR)) {
    New-Item -ItemType Directory -Path $OUTPUT_DIR
    Write-Host "[SETUP] Created output directory: $OUTPUT_DIR"
}
Write-Host "-----------------------------------------------------"

# --- Find All Source Files ---
# Recursively find all .vhd files in the specified subdirectories
$UtilFiles  = (Get-ChildItem -Path "$SOURCE_DIR\util" -Recurse -Filter *.vhd).FullName
$GateFiles  = (Get-ChildItem -Path "$SOURCE_DIR\gates" -Recurse -Filter *.vhd).FullName
$MuxFiles   = (Get-ChildItem -Path "$SOURCE_DIR\muxes" -Recurse -Filter *.vhd).FullName
$LogicFiles = (Get-ChildItem -Path "$SOURCE_DIR\logic" -Recurse -Filter *.vhd).FullName
$ArithFiles = (Get-ChildItem -Path "$SOURCE_DIR\arithmetic" -Recurse -Filter *.vhd).FullName
$SeqFiles = (Get-ChildItem -Path "$SOURCE_DIR\sequential" -Recurse -Filter *.vhd).FullName
$de_encodeFiles = (Get-ChildItem -Path "$SOURCE_DIR\decoder_encoder" -Recurse -Filter *.vhd).FullName


# --- Compilation Step ---
Write-Host "[COMPILE] Analyzing all source files into library '$LIBRARY_NAME'..."

# The order matters: dependencies first.
ghdl -a $VHDL_STANDARD --work=$LIBRARY_NAME --workdir="$OUTPUT_DIR" $UtilFiles
ghdl -a $VHDL_STANDARD --work=$LIBRARY_NAME --workdir="$OUTPUT_DIR" $GateFiles
ghdl -a $VHDL_STANDARD --work=$LIBRARY_NAME --workdir="$OUTPUT_DIR" "$SOURCE_DIR\fulladder\src\fulladder.vhd"
ghdl -a $VHDL_STANDARD --work=$LIBRARY_NAME --workdir="$OUTPUT_DIR" $MuxFiles
ghdl -a $VHDL_STANDARD --work=$LIBRARY_NAME --workdir="$OUTPUT_DIR" $LogicFiles
ghdl -a $VHDL_STANDARD --work=$LIBRARY_NAME --workdir="$OUTPUT_DIR" $ArithFiles
ghdl -a $VHDL_STANDARD --work=$LIBRARY_NAME --workdir="$OUTPUT_DIR" $SeqFiles
ghdl -a $VHDL_STANDARD --work=$LIBRARY_NAME --workdir="$OUTPUT_DIR" $de_encodeFiles

# Check for errors after the last command
if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "[ERROR] VHDL analysis failed. Library not created successfully." -ForegroundColor Red
} else {
    Write-Host ""
    Write-Host "[SUCCESS] Library '$LIBRARY_NAME' created successfully." -ForegroundColor Green
}