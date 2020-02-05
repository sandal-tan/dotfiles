#!/bin/bash
#
# Catch-all of formatted output
#
# Getopt for output rippped from here: https://code-maven.com/bash-getopt-processing-command-line-arguments
#
# version: 0.0.1
# date: 02/03/2020

function warning()
{
    message="$@"
    if which ansi > /dev/null; then
        message="$(ansi --yellow ${message})"
    else
        message="WARNING ${message}"
    fi
    echo "${message}"
}

function error()
{
    message="$@"
    if which ansi > /dev/null; then
        message="$(ansi --red ${message})"
    else
        message="ERROR ${message}"
    fi
    echo "${message}"
}

function start()
{
    message="$@"
    if which revolver > /dev/null; then
        revolver start "${message}"
        message=""
    else
        message="${message}: ..."
    fi
    printf "${message}"

}

function end()
{
    message="$@"
    if which revolver > /dev/null; then
        # Should probably check for an existing revolver process here
        revolver stop
        message=""
    else
        message="${message}: done"
    fi
    printf "${message}"
}

function output()
{
    message="${1}"
    shift
    exit_when_done=0
    add_newline=0
    while true; do
        case "$1" in
            --warning)
                message="$(warning ${message})"
                ;;
            --fail)
                message="$(error ${message})"
                exit_when_done=1
                ;;
            --start)
                message="$(start ${message})"
                add_newline=1
                ;;
            --end)
                message="\r$(end ${message})"
                ;;
            --header)
                message="\n${message}"
                ;;
            *)
                break
                ;;
        esac
        shift
    done
    if [ $add_newline -eq 0 ]; then
        message="${message}\n"
    fi
    printf -- "${message}"
    if [ $exit_when_done -eq 0 ]; then
        return
    else
        exit 1
    fi
}

