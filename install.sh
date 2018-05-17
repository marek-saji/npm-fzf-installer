#!/bin/bash
set -e

INSTALL_URL="https://raw.githubusercontent.com/junegunn/fzf/master/install"
INSTALL_NAME="$( basename "${INSTALL_URL}" )"

FETCH="$(
    if which curl
    then
        echo --progress-bar --output "${INSTALL_NAME}"
    fi
)"

if [ -z "${FETCH}" ]
then
    echo "Failed to find a program to fetch  Tried: curl, wget"
    exit 1
fi

echo "Downloading installer ..."
${FETCH} "${INSTALL_URL}"

echo "Running installer ..."
# Remove existing dummy bin/fzf
rm bin/fzf
# Restrict $PATH to essencials to prevent fzf from locating any
# user-installed fzf insttances, because then it’s linked to bin/fzf
# and that may end up hanging up install script.
PATH=/bin:/usr/bin bash "${INSTALL_NAME}" --bin
