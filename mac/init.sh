#!/bin/bash
#
# version: 0.0.1
# date: 1/30/2020
#
# Initialize a new environment in mac

source "${BASH_SOURCE%/*}/../bash/functions/output.sh"

echo "                         ____  _____";
echo "   ____ ___  ____ ______/ __ \/ ___/";
echo "  / __ \`__ \/ __ \`/ ___/ / / /\__ \ ";
echo " / / / / / / /_/ / /__/ /_/ /___/ / ";
echo "/_/ /_/ /_/\__,_/\___/\____//____/  ";
echo "                                    ";


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

output "Installing Homebrew" --header
if ! which brew &> /dev/null; then
    output "Installing Brew" --start
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    output "Brew is installed" --end
else
    output "Brew is already installed. Skipping." --warning
fi

output "Configuring Dock.app" --header
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 1000
defaults write com.appl.dock no-bouncing -bool true
killall Dock

output "Configuring Finder" --header
defaults write NSGlobalDomain _HIHideMenuBar -bool true
defaults write com.apple.finder CreateDesktop -bool false
killall Finder

bash "${BASH_SOURCE%/*}/../common/init.sh"
