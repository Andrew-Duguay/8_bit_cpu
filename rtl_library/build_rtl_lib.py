import os
import glob
import shutil
import subprocess
import sys

# --- Configuration ---
VHDL_STANDARD = "--std=08"
LIBRARY_NAME = "rtl_lib"
SOURCE_DIR = "."
OUTPUT_DIR = os.path.join(".", "rtl_lib") # Use os.path.join for portability

# --- Setup ---
print(f"Building {LIBRARY_NAME}...")

# Remove existing output directory to ensure a clean slate
if os.path.exists(OUTPUT_DIR):
    shutil.rmtree(OUTPUT_DIR)
    print(f"    Removed old directory: {OUTPUT_DIR}")

# Create the output directory
os.makedirs(OUTPUT_DIR)
print(f"    Created output directory: {OUTPUT_DIR}")
print("-----------------------------------------------------")

# GHDL's internal library cleanup
subprocess.run(["ghdl", f"--remove-lib={LIBRARY_NAME}"])
print("-----------------------------------------------------")

# --- Find All Source Files ---
# Helper function to find files and handle empty directories
def find_files(path_pattern):
    return glob.glob(os.path.join(SOURCE_DIR, path_pattern), recursive=True)

# The order matters for compilation dependencies
source_file_groups = {
    "Util": find_files("util/**/*.vhd"),
    "Gates": find_files("gates/**/*.vhd"),
    "Muxes": find_files("muxes/**/*.vhd"),
    "Logic": find_files("logic/**/*.vhd"),
    "Arithmetic": find_files("arithmetic/**/*.vhd"),
    "Sequential": find_files("sequential/**/*.vhd"),
    "Decoder/Encoder": find_files("decoder_encoder/**/*.vhd")
}

# --- Compilation Step ---
print(f"[COMPILE] Analyzing all source files into library '{LIBRARY_NAME}'...")

success = True
for group_name, files in source_file_groups.items():
    if not files: # Skip if no files were found in this group
        continue
    
    print(f"  -> Analyzing {group_name} files...")
    command = [
        "ghdl", "-a", VHDL_STANDARD,
        f"--work={LIBRARY_NAME}",
        f"--workdir={OUTPUT_DIR}"
    ] + files
    
    result = subprocess.run(command, capture_output=True, text=True)
    
    if result.returncode != 0:
        print(f"\n[ERROR] VHDL analysis failed for group: {group_name}")
        print(result.stderr)
        success = False
        break # Stop compiling on the first error

# --- Final Status ---
if success:
    print(f"\n[SUCCESS] Library '{LIBRARY_NAME}' created successfully.")
else:
    print(f"\n[FAILURE] Library '{LIBRARY_NAME}' was not created successfully.")
    sys.exit(1) # Exit with an error code