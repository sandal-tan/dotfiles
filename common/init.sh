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
source "${BASH_SOURCE%/*}/../bash/functions/output.sh"

git config --global user.name "Ian Baldwin"
git config --global user.email "ian@iantbaldw.in"

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

output "Attempting to Install 'chezmoi'" --header
if [ ! -e "${USER_BIN}/chezmoi" ]; then
    output "Downloading chezmoi" --start
    curl -sfL https://git.io/chezmoi | sh &> /dev/null
    output "Downloading chezmoi" --end
    mv bin/chezmoi $USER_BIN/chezmoi
else
    output "'chezmoi' is already installed. Skipping." --warning
fi

# Apply dotfiles
output "Apply dotfiles" --header
if [ ! -e ~/.local/share/chezmoi ]; then
    output "Initializing chezmoi" --start
    ${USER_BIN}/chezmoi init "${REPO_URL}"
    cd $HOME/.local/share/chezmoi/
    git checkout init # TODO Change this back to REF
    cd -
    output "Initializing chezmoi" --end
    output "Apply chezmoi" --start
    ${USER_BIN}/chezmoi apply ~/.bashrc
    ${USER_BIN}/chezmoi apply ~/.bash_profile
    ${USER_BIN}/chezmoi apply ~/.environment
    ${USER_BIN}/chezmoi apply ~/.environment
    ${USER_BIN}/chezmoi apply ~/.brewfile
    ${USER_BIN}/chezmoi apply ~/.tmux.conf
    mkdir -p ~/.pyenv
    ${USER_BIN}/chezmoi apply ~/.pyenv/default-packages
    output "Apply chezmoi" --end
    ln -s "${HOME}/.local/share/chezmoi" "${USER_DEVELOPMENT}/dotfiles"
else
    output "Dotfiles have already been applied. Skipping." --warning
fi

source ~/.environment

output "Attempting to install 'brew bundle'" --header
if ! brew tap | grep homebrew/bundle &> /dev/null; then
	brew bundle install	
else
    output "'brew bundle' has already been installed" --warning
fi

# ansi for printing colors
install_from_remote_binary git.io/ansi ansi

# revolver for progress spinners
install_from_git https://github.com/molovo/revolver revolver/revolver

if [ ! -e "${HOME}/development/isomorphic-copy" ]; then
    git clone https://github.com/ms-jpq/isomorphic-copy "${HOME}/development/isomorphic-copy"
fi

# setup python environment
output "Setting up python environment" --header
if [ ! -e "${HOME}/.pyenv/versions/${PYTHON_VERSION}" ]; then
    output "Installing Python ${PYTHON_VERSION}" --start
    pyenv install "${PYTHON_VERSION}" > /dev/null
    output "Installing Python ${PYTHON_VERSION}" --end
else
    output "Python environment is already setup. Skipping." --warning
fi

if [ "$(pyenv global)" != "${PYTHON_VERSION}" ]; then
    output "Setting Python version to ${PYTHON_VERSION}" --start
    pyenv global "${PYTHON_VERSION}"
    output "Setting Python version to ${PYTHON_VERSION}" --end
else
    output "Python version is already set. Skipping." --warning
fi

output "Attempting to install 'tpm'" --header
if [ ! -e $HOME/.tmux/plugins/tpm ]; then
    clone "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm"
else
    output "'tpm' is already installed. Skipping." --warning
fi
