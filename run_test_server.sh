#!/bin/bash
#
# version: 0.0.1
# date: 1/31/2020
#
# Host the directory with a webserver for testing with curl

PORT=8000


function build_archive()
{
    cd ../
    ln -s dotfiles dotfiles-master
    xargs -0 -I {} sh -c "echo $(ansi --yellow  '* Building Arhive'); zip -qr dotfiles/dotfiles.zip dotfiles-master -x@dotfiles/.zipignore"
    rm dotfiles-master
    cd dotfiles
}

revolver start "Launching test webserver"
# This line will only work on Python3+
python -m http.server "${PORT}" > /dev/null &
revolver update "Forking"
SERVER_PID=$!
revolver update "$(ansi --green Running webserver at :${PORT})"
fswatch -0r -e ".*" -i "\\.sh$" -e "dotfiles/*" . | build_archive
kill -9 "${SERVER_PID}"
revolver stop
rm ../dotfiles-master
