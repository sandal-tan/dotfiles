#!/bin/bash
#
# version: 0.0.1
# date: 1/30/2020
#
# Bootstrap new environments


function get_init_dotfiles()
{
    tempdir=$(mktemp -d)
    TEMPDIR=$tempdir
    echo $TEMPDIR
    cd $tempdir
    curl -L --silent https://github.com/sandal-tan/dotfiles/archive/master.zip -o master.zip
    unzip master.zip
}

function del_init_dotfiles()
{
    rm -rf $TEMPDIR
}


OS="$(uname | tr '[:upper:]' '[:lower:]')"
if [ "${OS}" == "darwin" ]; then
    echo "Bootstraping Mac Environment"
    get_init_dotfiles
    cd $TEMPDIR/dotfiles-master
    echo "Handing off control to mac initializer"
    sh mac/init.sh
    cd -
    del_init_dotfiles
else
    echo "OS ${OS} is unsupported"
    exit 1
fi

