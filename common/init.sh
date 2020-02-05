#!/bin/sh
#
# version: 0.0.1
# date: 02/05/2020
#
# Common intializiier steps
set -e

source "${BASH_SOURCE%/*}/../init_config.sh"
source "${BASH_SOURCE%/*}/../bash/functions/os.sh"
source "${BASH_SOURCE%/*}/../bash/functions/install.sh"
source "${BASH_SOURCE%/*}/../bash/functions/git.sh"

if [ ! -e "$HOME/.ssh/id_rsa" ]; then
    output "No default SSH key found. Creating now" --start
    ssh-keygen -f ~/.ssh/id_rsa -N "" -q
    output "No default SSH key found. Creating now" --end
    read -sp "Enter GitHub Password: " password < /dev/tty
    data='{"title": "'"$(hostname)"'", "key": "'"$(cat ~/.ssh/id_rsa.pub)"'"}'
    curl --silent \
        -u "${GITHUB_USERNAME}:${password}" \
        --data "${data}" \
        https://api.github.com/user/keys
    unset password
else
    output "Default SSH Key found."
fi

make_dir "${USER_BIN}"
make_dir "${USER_DEVELOPMENT}"

# ansi for printing colors
install_from_remote_binary git.io/ansi ansi

# revolver for progress spinners
install_from_git https://github.com/molovo/revolver revolver/revolver

# Clone the dotfiles
output "Cloning dotfiles" --header
clone "git@github.com:sandal-tan/dotfiles.git" "${USER_DEVELOPMENT}/dotfiles"
