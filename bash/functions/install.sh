#!/bin/bash
#
# version: 0.0.1
# date: 02/04/2020
#
# Functions for installing from various sources

source "${BASH_SOURCE%/*}/../../init_config.sh"
source "${BASH_SOURCE%/*}/output.sh"
source "${BASH_SOURCE%/*}/git.sh"

# Curl a binary, apply the right permissions, install in $USER_BIN
function install_from_remote_binary()
{
    binary_url="${1}"
    binary_name="${2}"
    output "Attempting to install '${binary_name}'" --header
    if [ ! -e "${USER_BIN}" ]; then
        output "Cannot install '${binary_name}'. '${USER_BIN}' does not exist." --fail
    fi

    if [ -e "${USER_BIN}/${binary_name}" ]; then
        output "'${binary_name}' is already installed, skipping." --warning
        return
    fi

    cd "${USER_BIN}"
    output "Downloading '${binary_name}'" --start
    curl -OL --silent "${binary_url}"
    output "Downloading '${binary_name}'" --end
    chmod 755 "${binary_name}"
    cd - > /dev/null
}

# Clone a git repo and link a binary to the $USER_BIN
function install_from_git()
{
    repo="${1}"
    binary_path="${2}"
    binary_name="$(basename ${binary_path})"
    output "Attempting to install '${binary_name}'" --header
    if [ ! -e "${USER_DEVELOPMENT}" ]; then
        output "Cannot install '${binary_name}'. '${USER_DEVELOPMENT}' does not exist." --fail
    fi

    if [ -e "${USER_BIN}/${binary_name}" ]; then
        output "'${binary_name}' is already installed, skipping." --warning
        return
    fi

    # This will probably need another option to handle clonning to a different name
    clone "${repo}" "${USER_DEVELOPMENT}/${binary_name}"
    chmod 755 "${USER_DEVELOPMENT}/${binary_path}"
    ln -s "${USER_DEVELOPMENT}/${binary_path}" "${USER_BIN}/${binary_name}"
}
