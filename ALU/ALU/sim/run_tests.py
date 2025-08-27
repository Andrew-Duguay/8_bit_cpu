import subprocess #To run other programs
import glob #To find my files
import sys #to let my script interact with python itself
import os  # To manipulate paths and make system independent

ARGS = [
    "--std=08",
    "-P../../../rtl_library/rtl_lib"
]

# Find and categorize all files needed to run TB
config_files = glob.glob(os.path.join('..', 'config', '*.vhd'))
src_files = glob.glob(os.path.join('..', 'src', '*.vhd'))
tb_files = glob.glob(os.path.join('..', 'tb', '*.vhd'))
TEST_BENCHES = [ os.path.splitext( os.path.basename(file_path) )[0] for file_path in tb_files ]

# Analyze configuration files and utility files
print("[STEP 1]     Analyzing dependencies...")
if config_files:
    config_cmd = ["ghdl", "-a"] + ARGS + config_files
    result = subprocess.run(config_cmd, capture_output=True, text=True)
    if result.returncode != 0 :
        print("[ERROR]      Analysis of config and util files failed. Dependencies not analyzed")
        print("             --- GHDL Error ---")
        print(result.stderr)
        sys.exit(1)
    print("[SUCCESS]    Dependencies succesfully analyzed.")
else:
    print("[INFO]     No dependencies in config folder, skipping...")


# Analyze the files under test
print("[STEP 2]     Analyzing src and tb files...")
analyze_cmd = ["ghdl", "-a"] + ARGS + src_files + tb_files
result = subprocess.run(analyze_cmd, capture_output=True, text=True)
if result.returncode != 0 : 
    print("[ERROR]      Analysis failed. Halting script.")
    print("             --- GHDL Error ---")
    print(result.stderr)
    sys.exit(1)
print("[SUCCESS]    Files succesfully analyzed.")

# Elaborate and run each tb file
print("[STEP 3] Running specified testbenches...")
for tb in TEST_BENCHES:
    passed = True
    print(f"          Running: {tb}")
    # Elaborate
    elaborate_command = ["ghdl", "-e"] + ARGS + [tb]
    result = subprocess.run(elaborate_command, capture_output=True, text=True)
    if result.returncode != 0:
        passed = False
        print(f"            [ERROR] Elaboration failed. GHDL error:")
        print(result.stderr)
        continue # Skip to the next testbench

    # Running
    run_command = ["ghdl", "-r"] + ARGS + [tb, f"--fst={tb}.fst"]
    result = subprocess.run(run_command, capture_output=True, text=True)
    if result.returncode != 0:
        passed = False
        print(f"            [ERROR] Failed to run. GHDL error:")
        print(result.stderr)
    if passed:
        print(f"            [SUCCESS]")
