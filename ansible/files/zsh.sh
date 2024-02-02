#!/bin/bash

if [ "$SHELL" != "/bin/zsh" ]; then
    sudo usermod -s $(which zsh) $(whoami)
else
    echo "Current shell is zsh"
fi
