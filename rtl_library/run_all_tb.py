import glob
import subprocess
import os

print("========================== [MASTER SCRIPT] Starting all component testbench scripts... ==========================")
my_scripts = glob.glob(os.path.join('**', 'run_tests.py'), recursive=True)

for script in my_scripts:
    component_sim_dir = os.path.dirname(script)
    component = os.path.basename(os.path.dirname(component_sim_dir))
    command = ["python", "run_tests.py"]
    print(f"Running test script for {component}...")
    result = subprocess.run(command, capture_output=True, text=True, cwd=component_sim_dir)
    if result.returncode != 0:
        print(f"    [ERROR] Testing on {component} failed")
        print("             --- GHDL Error ---")
        print(result.stderr)
        continue
    else:
        print(f"    [SUCCESS]")


print("========================== [MASTER SCRIPT] All component testbench scripts processed. ==========================")