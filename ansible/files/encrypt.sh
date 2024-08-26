#!/bin/bash

VAULT_PASSWORD_FILE=~/.ansible-vault/vault.secret
TMUX_POWERLINE_CONFIG=~/.config/tmux-powerline/config.sh

if [ -f "$TMUX_POWERLINE_CONFIG" ]; then
    if grep -q "ANSIBLE_VAULT" "$TMUX_POWERLINE_CONFIG"; then
        echo "Skipping encrypted file: $TMUX_POWERLINE_CONFIG"
    else
        ansible-vault encrypt --vault-password-file "$VAULT_PASSWORD_FILE" "$TMUX_POWERLINE_CONFIG"
    fi
fi

for key in "$KEYS_DIRECTORY"/*; do
    if [ -f "$key" ]; then
        if grep -q "ANSIBLE_VAULT" "$key"; then
            echo "Skipping encrypted key: $key"
        else
            ansible-vault encrypt --vault-password-file "$VAULT_PASSWORD_FILE" "$key"
        fi
    fi
done
