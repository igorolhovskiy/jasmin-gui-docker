#!/bin/bash
set -e

commands=("gunicorn")

if [[ ${commands[*]} =~ "$1" ]]
then
    exec make $1
fi

exec "$@"
