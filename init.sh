#!/bin/bash
#
# version: 0.0.1
# date: 1/30/2020
#
# Bootstrap new environments
set -e

REF="${master:-REF}"
echo "Initializing with ${REF}"

REPO_URL="https://github.com/sandal-tan/dotfiles/archive/${REF}.zip"

function get_init_dotfiles()
{
    tempdir=$(mktemp -d)
    TEMPDIR=$tempdir
    echo $TEMPDIR
    cd $tempdir
    curl -L --silent "${REPO_URL}" -o "${REF}.zip"
    unzip "${REF}.zip"
}

function del_init_dotfiles()
{
    rm -rf $TEMPDIR
}


OS="$(uname | tr '[:upper:]' '[:lower:]')"
if [ "${OS}" == "darwin" ]; then
    echo "Bootstraping Mac Environment"
    get_init_dotfiles
    echo "Handing off control to mac initializer"
    cd "${TEMPDIR}/dotfiles-{REF}"
    ls
    sh mac/init.sh
    cd -
    del_init_dotfiles
else
    echo "OS ${OS} is unsupported"
    exit 1
fi

