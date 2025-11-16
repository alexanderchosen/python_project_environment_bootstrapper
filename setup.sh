#!/bin/bash

set -e
set -u
set -o pipefail


# this is where i define my colour variables
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
NO_COLOUR="\033[0m"

# the log_message_output function expects 2 local parameters, which are the exit_code and the message.
# I used a case statement to check the exit_code variable, then, I used the various exit_code values to output a log to the stdout and to the setup.log file
log_message_output() {
	local exit_code=$1
	local message=$2

	case "$exit_code" in
		0)
			echo -e "$(date): ${GREEN}[SUCCESS]${NO_COLOUR} $message"
			echo "$(date): [SUCCESS] $message" >> setup.log
			;;
		1)
			echo -e "$(date): ${RED}[ERROR]${NO_COLOUR} $message"
			echo "$(date): [ERROR] $message" >> setup.log
			;;
		2)
			echo -e "$(date): ${YELLOW}[WARNING]${NO_COLOUR} $message"
			echo "$(date): [WARNING] $message" >> setup.log
			;;
		*)
			echo -e "$(date): ${BLUE}[INFO]${NO_COLOUR} $message"
			echo "$(date): [INFO] $message" >> setup.log
			;;
	esac
}

# I created the venv_setup function to check, create, and activate the virtual environment for the project.
# It first checks if the .venv file exist, and if it doesnt exist, it creates a virtual environment in the existing project directory
# afterwards, it activates the  virtual environment
venv_setup(){
	if [[ -f ".venv/bin/activate" ]]; then
		log_message_output 0 "The virtual environment already exists in this project folder!"
	else
		log_message_output 2 "The virtual environment was not found. Create a Virtual environment to continue..."
	
		python3 -m venv .venv
		if [[ $? -eq 0 ]]; then
		       	log_message_output 0 "The virtual environment was successfully created in this project folder."
		else
			log_message_output $? "The virtual environment creation failed. Try again!"
			exit 1
		fi
	fi

	source .venv/bin/activate
	if [[ $? -eq 0 ]]; then
		log_message_output 0 "The virtual environment has been successfully activated in this project folder."
	else	
		log_message_output 1 "The virtual environment was not activated in this project folder."
		exit 1
	fi
}


# The pip_upgrade function upgrades the pip used in the virtual environment to its latest version.
pip_upgrade(){
	log_message_output 3 "About to upgrade pip to its latest version. Wait a little while..."

	python3 -m pip install --upgrade pip
	if [[ $? -eq 0 ]]; then
		log_message_output 0 "...Pip has been successfully upgraded in this project folder."
	else
		log_message_output 1 "...Pip upgrade failed. Check your internet connection and try again!"
		exit 1
	fi
}


# The create_gitignore function checks if a .gitignore file exist in the project folder, if it doesn't exist, it creates one and adds some files to it.
create_gitignore(){
	if [[ -f ".gitignore" ]]; then
		log_message_output 2 "The file .gitignore already exists in your project folder!"
	else
		log_message_output 1 "The file .gitignore does not exists in your project folder. Create this file!"
	
		echo "__pycache__/\n.venv/" > .gitignore
		if [[ $? -eq 0 ]]; then
			log_message_output 0 "The file .gitignore was successfully created."
		else
			log_message_output 1 "The file .gitignore was not created. Try again!"
			exit 1
		fi
	fi
}


# This function helps to install some python packages automatically when the setup.sh script is run.
install_packages(){
	packages_install=("pandas" "requests" "matplotlib" "seaborn")

	for package in " ${packages_install[@]} "; do
		log_message_output 0 "Installing package: $package "
		
		.venv/bin/pip install "$package"
		if [[ $? -eq 0 ]]; then
			log_message_output 0 "$package has been installed successfully!"
		else
			log_message_output 1 "$package was not installed. Try again!"
			exit 1
		fi
	done
}


main(){
	log_message_output 0 "The setup.sh file is running..."
	venv_setup
	pip_upgrade
	create_gitignore
	install_packages
	log_message_output 0 "The setup is complete!"
}

main
