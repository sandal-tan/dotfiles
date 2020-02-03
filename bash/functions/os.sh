#!/bin/bash
#
# OS-related shell functions
#
# version: 0.0.1
# date: 02/03/2020

source "${BASH_SOURCE%/*}*.sh"

function make_dir()
{
    ARG_PATH="${1}"
    output "Attempting to make directory: ${ARG_PATH}"
    if [ -e "${ARG_PATH}" ]; then
        output "* Directory '${ARG_PATH}' exists." warning
    else
        mkdir "${ARG_PATH}"
        output "* Made directory: '${ARG_PATH}'"
    fi
}
