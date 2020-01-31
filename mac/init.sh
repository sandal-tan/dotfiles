#!/bin/bash
#
# version: 0.0.1
# date: 1/30/2020
#
# Initialize a new environment in mac
source ${BASH_SOURCE%/*}/../init_config.sh

echo " ___ __ __   ________   ______       ______   ______      ";
echo "/__//_//_/\ /_______/\ /_____/\     /_____/\ /_____/\     ";
echo "\::\| \| \ \\::: _  \ \\:::__\/     \:::_ \ \\::::_\/_    ";
echo " \:.      \ \\::(_)  \ \\:\ \  __    \:\ \ \ \\:\/___/\   ";
echo "  \:.\-/\  \ \\:: __  \ \\:\ \/_/\    \:\ \ \ \\_::._\:\  ";
echo "   \. \  \  \ \\:.\ \  \ \\:\_\ \ \    \:\_\ \ \ /____\:\ ";
echo "    \__\/ \__\/ \__\/\__\/ \_____\/     \_____\/ \_____\/ ";
echo "                                                          ";

if [ -e "${USER_BIN}" ]; then
    echo "* User bin `${USER_BIN}` exists."
else
    echo "* User bin `${USER_BIN}` does not exist"
fi

if [ -e "${USER_DEVELOPMENT}" ]; then
    echo "* User development environment `${USER_DEVELOPMENT}` exists."
else
    echo "* User development environment `${USER_DEVELOPMENT}` does not exist."
fi
