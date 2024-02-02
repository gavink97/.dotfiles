#!/bin/zsh

if [ -f "$HOME/.zshrc" ]; then
    source "$HOME/.zshrc"
fi

if [ -d "$HOME/.oh-my-zsh" ]; then
    omz update
else
    sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
fi
