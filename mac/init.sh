#!/bin/bash
#
# version: 0.0.1
# date: 1/30/2020
#
# Initialize a new environment in mac

source ${BASH_SOURCE%/*}/../init_config.sh

echo "                         ____  _____";
echo "   ____ ___  ____ ______/ __ \/ ___/";
echo "  / __ \`__ \/ __ \`/ ___/ / / /\__ \ ";
echo " / / / / / / /_/ / /__/ /_/ /___/ / ";
echo "/_/ /_/ /_/\__,_/\___/\____//____/  ";
echo "                                    ";
if [ -e "${USER_BIN}" ]; then
    echo "* User bin '${USER_BIN}' exists."
else
    echo "* User bin '${USER_BIN}' does not exist"
fi

if [ -e "${USER_DEVELOPMENT}" ]; then
    echo "* User development environment '${USER_DEVELOPMENT}' exists."
else
    echo "* User development environment '${USER_DEVELOPMENT}' does not exist."
fi
