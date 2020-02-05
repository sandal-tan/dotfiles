#!/bin/bash
#
# version: 0.0.1
# date: 02/05/2020
#
# Initialization script for a new Ubuntu 19.10 environment

source "${BASH_SOURCE%/*}/../../bash/functions/output.sh"

echo "   __  ____                __           _______   _______ ";
echo "  / / / / /_  __  ______  / /___  __   <  / __ \ <  / __ \\";
echo " / / / / __ \/ / / / __ \/ __/ / / /   / / /_/ / / / / / /";
echo "/ /_/ / /_/ / /_/ / / / / /_/ /_/ /   / /\__, / / / /_/ / ";
echo "\____/_.___/\__,_/_/ /_/\__/\__,_/   /_//____(_)_/\____/  ";
echo "                                                          ";

output "Attempting to Install 'build-essential'" --header
if ! apt list --installed | grep build-essential &> /dev/null; then
    output "Installing 'build-essential'"
    sudo apt install -y build-essential
else
    output "'build-essential' already installed. Skipping." --warning
fi

output "Attempting to Install Homebrew" --header
if  [ ! -e "${HOME}/../linuxbrew/.linuxbrew" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
else
    output "'brew' already installed. Skipping." --warning
fi

echo ""
bash "${BASH_SOURCE%/*}/../../common/init.sh"
