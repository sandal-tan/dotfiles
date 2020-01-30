#!/bin/bash
#
# version: 0.0.1
# date: 1/30/2020
#
# Bootstrap new environments

function get_dotfiles()
{

}


OS="$(uname | tr '[:upper:]' '[:lower:]')"
if [ "${OS}" == "darwin" ]; then
    echo "Bootstraping Mac Environment"

else
    echo "OS ${OS} is unsupported"
    exit 1
fi
