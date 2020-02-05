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

output "Attempting to Install 'chezmoi'" --header
if [ ! -e "${USER_BIN}/chezmoi" ]; then
    output "Downloading chezmoi" --start
    curl -sfL https://git.io/chezmoi | sh &> /dev/null
    output "Downloading chezmoi" --end
    mv bin/chezmoi $USER_BIN/chezmoi
else
    output "'chezmoi' is already installed. Skipping." --warning
fi


# Clone the dotfiles
output "Cloning dotfiles" --header
if [ ! -e "${USER_DEVELOPMENT}/dotfiles" ]; then
    clone "git@github.com:sandal-tan/dotfiles.git" "${USER_DEVELOPMENT}/dotfiles"
    ln -s "${USER_DEVELOPMENT}/dotfiles" "${HOME}/.local/share/chezmoi"
else
    output "Dotfiles have already been cloned. Skipping." --warning
fi

# Apply dotfiles
output "Apply dotfiles" --header
${USER_BIN}/chezmoi init
${USER_BIN}/chezmoi apply
