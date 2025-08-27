import os
import glob

old_scripts = glob.glob(os.path.join('**', 'run_tests.bat'), recursive=True)
for this_one in old_scripts:
    os.remove(this_one)