#!/bin/bash

if [ -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "TPM is installed"
else
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    tmux source ~/.config/tmux/tmux.conf
fi
