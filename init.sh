#!/bin/bash
#
# version: 0.0.1
# date: 1/30/2020
#
# Bootstrap new environments

set -e

MODE="${BOOTSTRAP_MODE:-live}"

REF="${REF:-master}"

clear
echo ""
echo "    ____  ____  __________________    ___________";
echo "   / __ \/ __ \/_  __/ ____/  _/ /   / ____/ ___/";
echo "  / / / / / / / / / / /_   / // /   / __/  \__ \ ";
echo " / /_/ / /_/ / / / / __/ _/ // /___/ /___ ___/ / ";
echo "/_____/\____/ /_/ /_/   /___/_____/_____//____/  ";
echo ""
echo "  Get 'em, Got 'em, Good"
echo "  * version: 0.0.1"
echo "  * https://github.com/sandal-tan/dotfiles.git"
echo ""
echo "* Initializing with: ${REF}"

if [ "${MODE}" == "live" ]; then
    REPO_URL="https://github.com/sandal-tan/dotfiles/archive/${REF}.zip"
elif [ "${MODE}" == "test" ]; then
    REPO_URL="http://192.168.86.26:8000/dotfiles.zip"
fi

echo "* Initializing from: ${REPO_URL}"

function get_init_dotfiles()
{
    tempdir=$(mktemp -d)
    TEMPDIR=$tempdir
    cd $tempdir
    curl -L --silent "${REPO_URL}" -o "dotfiles.zip"
    if [ "${OS}" == "linux" ]; then
        python3 -m zipfile -e dotfiles.zip .
    elif [ "${OS}" == "darwin" ]; then
        unzip -qq "dotfiles.zip"
    fi
}

function del_init_dotfiles()
{
    rm -rf $TEMPDIR
}

OS="$(uname | tr '[:upper:]' '[:lower:]')"
if [ "${OS}" == "darwin" ]; then
    echo "* Bootstraping Mac Environment"
    get_init_dotfiles
    echo "* Handing Off Control to Mac Initializer"
    echo""
    cd "${TEMPDIR}/dotfiles-${REF}"
    bash mac/init.sh
    cd - > /dev/null
    del_init_dotfiles
elif [ -f "/etc/os-release" ]; then
    source /etc/os-release
    distribution="${ID}"
    version="${VERSION_ID}"
    case $distribution in
        ubuntu)
            echo "* Bootstraping Ubuntu Environment"
            case $version in
                19.10)
                    get_init_dotfiles
                    echo "* Handing Off Control to Ubuntu 19.10 Initializer"
                    echo ""
                    cd "${TEMPDIR}/dotfiles-${REF}"
                    bash ubuntu/19.10/init.sh
                    cd - > /dev/null
                    del_init_dotfiles
                    ;;
                *)
                    echo "Unknown Ubuntu version: ${version}"
                    exit 1
                    ;;
            esac
            ;;
        *)
            echo "Unknown linux distribution: ${distribution}"
            exit 1
            ;;
    esac
else
    echo "OS ${OS} is unsupported"
    exit 1
fi
