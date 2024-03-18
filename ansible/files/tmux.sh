#!/bin/bash

if [ -d "$HOME/.config/tmux/plugins/tpm" ]; then
    echo "TPM is installed"
else
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

    tmux source ~/.config/tmux/tmux.conf
fi
