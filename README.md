<h1 align="center">Gavin's Dotfiles</h1>
<br>

## Getting Started

**I only have this setup for Ubuntu, Debian, Fedora, & MacOS**

Place vault key in `~/.ansible-vault/vault.secret`

*Need to manually install tmux / neovim plugins, nerd font, templ binaries*

### Installation
```
gh repo clone gavink97/dotfiles
cd dotfiles
chmod +x ansible/files/*
ansible-playbook ansible/ansible.yml --ask-become-pass
ansible/files/decrypt.sh
```

## Roadmap
- [ ] Work on ansible playbooks
