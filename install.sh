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
bash "${INSTALL_NAME}" --bin
