#!/bin/bash
#
# version: 0.0.1
# date: 1/30/2020
#
# Initialize a new environment in mac

source "${BASH_SOURCE%/*}/../init_config.sh"
source "${BASH_SOURCE%/*}/../bash/functions/os.sh"
source "${BASH_SOURCE%/*}/../bash/functions/install.sh"
source "${BASH_SOURCE%/*}/../bash/functions/output.sh"
source "${BASH_SOURCE%/*}/../bash/functions/git.sh"

echo "                         ____  _____";
echo "   ____ ___  ____ ______/ __ \/ ___/";
echo "  / __ \`__ \/ __ \`/ ___/ / / /\__ \ ";
echo " / / / / / / /_/ / /__/ /_/ /___/ / ";
echo "/_/ /_/ /_/\__,_/\___/\____//____/  ";
echo "                                    ";

make_dir "${USER_BIN}"
make_dir "${USER_DEVELOPMENT}"

# Prompt user to install command line utilities
output "Installing commmand line developer tools" --header
if ! git --version &> /dev/null; then
    output "Installing via separate dialog" --start
    sleep 1
    install_pid="$(ps -ef | grep 'Install Command Line' | head -1 | tr -s ' ' | cut -d' ' -f3)"
    lsof -p $install_pid +r 1 &> /dev/null
    output "Installing via separate dialog" --end
    if ! xcode-select -p &>/dev/null; then
        output "Failed to install command line developer tools" --fail
    fi
else
    output "Command line developer tools are already installed, Skipping." --warning
fi

# ansi for printing colors
install_from_remote_binary git.io/ansi ansi

# revolver for progress spinners
install_from_git https://github.com/molovo/revolver revolver/revolver

# Clone the dotfiles
clone "git@github.com:sandal-tan/dotfiles.git" "${USER_DEVELOPMENT}/dotfiles"

echo ""
