# Python Project Environment Boostrapper

I have been tasked with using Bash Scripting to automate the Python project environment of my Data Engineering team. 

### Below are the project requirements:
  #### Create a Bash script named setup.sh that performs the following actions:
✅ Checks for an existing Python virtual environment; If one exists, activate it; Else, create and activate a new one.

✅ Upgrades pip

✅ Ensure the latest version of pip is installed in the environment.

✅ Generates a .gitignore file

✅ The file should include standard ignore rules for a Python project (e.g .venv ).

✅ Skip creation if it already exists, but display a warning message.

✅ Provides colorful, user-friendly feedback: Use color codes to display INFO, SUCCESS, WARNING, and ERROR messages.

✅ Includes structured functions

✅ Organize each task (virtual environment, pip upgrade, gitignore, etc.) into its own function.

✅ Include a main function that calls these functions in sequence.

✅ Handles errors gracefully

✅ The script should stop immediately if any command fails.

✅ Automatically install a few Python packages (like pandas or requests).

✅ Write a comprehensive log of all setup actions to a file called setup.log.

---

## What The Script Does
This project utilizes Bash Scripting to automate a Python development environment, create a virtual environment, upgrade pip, set up a .gitignore file, and install essential tools, while providing a detailed log file with different colour codes.

---

## Colour Codes Used and Their Meaning
RED="\033[0;31m" ========================== ERROR

GREEN="\033[0;32m" ======================== SUCCESS

YELLOW="\033[0;33m" ======================= WARNING

BLUE="\033[0;34m" ========================= INFO

NO_COLOUR="\033[0m" ======================= PLAIN TEXT

## How To Execute It

To execute the setup.sh script, use `./setup.sh`

To check the setup.log file for the log output, use `less setup.log`

To check the setup.sh script file, use `vi setup.sh`

To edit the setup.sh script file using vim, press `i` to insert; `esc` key to enter command mode; and then `:wq` to save and exit the script.

---

## Example Outputs
Sun Nov 16 19:42:47 WAT 2025: [SUCCESS] The setup.sh file is running...

Sun Nov 16 19:42:47 WAT 2025: [WARNING] The virtual environment was not found. Create a Virtual environment to continue...

Sun Nov 16 19:42:51 WAT 2025: [SUCCESS] The virtual environment was successfully created in this project folder.

Sun Nov 16 19:42:51 WAT 2025: [SUCCESS] The virtual environment has been successfully activated in this project folder.

Sun Nov 16 19:42:51 WAT 2025 [INFO] About to upgrade pip to its latest version. Wait a little while...

Sun Nov 16 19:42:55 WAT 2025: [SUCCESS] ...Pip has been successfully upgraded in this project folder.

Sun Nov 16 19:42:55 WAT 2025: [ERROR] The file .gitignore does not exists in your project folder. Create this file!

Sun Nov 16 19:42:55 WAT 2025: [SUCCESS] The file .gitignore was successfully created.

Sun Nov 16 19:42:55 WAT 2025: [SUCCESS] Installing package:  pandas

Sun Nov 16 19:43:14 WAT 2025: [SUCCESS]  pandas has been installed successfully!

Sun Nov 16 19:43:14 WAT 2025: [SUCCESS] Installing package: requests

Sun Nov 16 19:43:22 WAT 2025: [SUCCESS] requests has been installed successfully!

Sun Nov 16 19:43:22 WAT 2025: [SUCCESS] Installing package: matplotlib

Sun Nov 16 19:43:33 WAT 2025: [SUCCESS] matplotlib has been installed successfully!

Sun Nov 16 19:43:33 WAT 2025: [SUCCESS] Installing package: seaborn

Sun Nov 16 19:27:52 WAT 2025: [SUCCESS] seaborn has been installed successfully!

Sun Nov 16 19:27:52 WAT 2025: [SUCCESS] The setup is complete!


---

## Challenges Faced and Lessons Learned

1. The first challenge I faced was how to use the colour codes for the various display outputs in my log_message_output function.
   I initially used the tee -a setup.log command with the echo statement inside each case statement:  `echo -e "$(date): ${GREEN}[SUCCESS]${NO_COLOUR} \ tee -a setup.log`
   After I ran the setup.sh file and read through the setup.log file, I noticed that it threw an error `command not found`. I was initially confused until I did my research. I got to understand that the `tee -a setup.log` command I used was interpreting the colour variables by outputting their colour code.
   I really wanted to use the CASE statement, so I decided to split both commands, and it worked:
   `echo -e "$(date): ${GREEN}[SUCCESS]${NO_COLOUR} $message"
   echo "$(date): [SUCCESS] $message" >> setup.log`

  2. The command `python3 -m pip install --upgrade pip` did a Python-wide level pip install and upgrade, which made pip available beyond the virtual environment.

  3. Since the pip install was initially at the Python-wide level, using pip install "$package" to install some Python packages made the installation global and not strictly for the virtual environment. I had to specify the pip install path: `.venv/bin/pip install "$package".



