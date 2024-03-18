#!/bin/bash

VAULT_PASSWORD_FILE=~/.ansible-vault/vault.secret
KEYS_DIRECTORY=~/.config/keys
TMUX_POWERLINE_CONFIG=~/.config/tmux-powerline/config.sh

ansible-vault decrypt --vault-password-file "$VAULT_PASSWORD_FILE" "$TMUX_POWERLINE_CONFIG"

for key in "$KEYS_DIRECTORY"/*; do
    ansible-vault decrypt --vault-password-file "$VAULT_PASSWORD_FILE" "$key"
done
