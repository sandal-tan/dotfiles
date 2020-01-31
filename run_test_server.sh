#!/bin/bash
#
# version: 0.0.1
# date: 1/31/2020
#
# Host the directory with a webserver for testing with curl

PORT=8000


function build_archive ()
{
    ansi --yellow "* Building Archive"
    stashName=`git stash create`;
    xargs -0 -I {} git archive --prefix=dotfiles-master/ -o dotfiles.zip $stashName
    git gc -- prune=now
}

revolver start "Launching test webserver"
# This line will only work on Python3+
python -m http.server "${PORT}" > /dev/null &
revolver update "Forking"
SERVER_PID=$!
revolver update "$(ansi --green Running webserver at :${PORT})"
fswatch -0 -ro ./ | build_archive
kill -9 "${SERVER_PID}"
revolver stop
