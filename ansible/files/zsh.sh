#!/bin/bash

if [ "$SHELL" != "/bin/zsh" ]; then
    os=$(uname -s)

    if [ "$os" == "Linux" ]; then
    sudo usermod -s $(which zsh) $(whoami)
    fi
else
    echo "Current shell is zsh"
fi
