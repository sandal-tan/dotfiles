#!/bin/bash
#
# version: 0.0.1
# date: 1/30/2020
#
# Initialize a new environment in mac
source ${BASH_SOURCE%/*}/../init_config.sh

if [-e "${USER_BIN}" ]; then
    echo "${USER_BIN} exists..."
else
    echo "${USER_BIN} does not exist"
fi

if [ -e "${USER_DEVELOPMENT}" ]; then
    echo "${USER_BIN} exists..."
else
    echo "${USER_BIN} does not exist"
fi
