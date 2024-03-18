#!/bin/bash

# write to check for version

if command tailwindcss &> /dev/null; then
    echo "Tailwind is installed"
else
    os=$(uname -s)

    if [ "$os" == "Darwin" ]; then
        curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-macos-arm64
        chmod +x tailwindcss-macos-arm64
        mv tailwindcss-macos-arm64 tailwindcss
    else
        curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-arm64
        chmod +x tailwindcss-linux-arm64
        mv tailwindcss-linux-arm64 tailwindcss
    fi
fi
