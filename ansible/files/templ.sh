#!/bin/bash

# write to check for version

if command templ &> /dev/null; then
    echo "Templ is installed"
else
    os=$(uname -s)

    if [ "$os" == "Darwin" ]; then
        curl -sLO https://github.com/a-h/templ/releases/latest/download/templ_Darwin_arm64.tar.gz
        # extract install binary delete download
    else
        curl -sLO https://github.com/a-h/templ/releases/latest/download/templ_Linux_arm64.tar.gz
    fi
fi

