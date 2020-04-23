#!/bin/bash
#
# version: 0.0.1
# date: 02/03/2020
#
# Git functions

function clone()
{
    repo="${1}"
    repo_basename="$(basename ${repo})"
    clone_path="${2}"
    output "Cloning '${repo_basename}' to '${clone_path}'" --start
    if [ ! -e "${clone_path}" ]; then
        git clone "${repo}" "${clone_path}" &> /dev/null
    else
        output "Cloning '${repo_basename}' to '${clone_path}'" --end
        output "Path ${clone_path} already exists" --warning
        return
    fi
    output "Cloning '${repo_basename}' to '${clone_path}'" --end
}
