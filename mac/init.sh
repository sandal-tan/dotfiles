#!/bin/bash
#
# version: 0.0.1
# date: 1/30/2020
#
# Initialize a new environment in mac

source "${BASH_SOURCE%/*}/../init_config.sh"
source "${BASH_SOURCE%/*}../bash/functions/*.sh"

echo "                         ____  _____";
echo "   ____ ___  ____ ______/ __ \/ ___/";
echo "  / __ \`__ \/ __ \`/ ___/ / / /\__ \ ";
echo " / / / / / / /_/ / /__/ /_/ /___/ / ";
echo "/_/ /_/ /_/\__,_/\___/\____//____/  ";
echo "                                    ";

make_dir "${USER_BIN}"
make_dir "${USER_DEVELOPMENT}"

echo ""
