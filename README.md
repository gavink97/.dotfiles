<h1 align="center">Gavin's Dotfiles</h1>
<br>

## Getting Started

**I only have this setup for Ubuntu, Debian, Fedora, & MacOS**

Place vault key in `~/.ansible-vault/vault.secret`


### Prerequisites
Install the following:
```
gh
ansible
```

### Installation
```
gh repo clone gavink97/.dotfiles ~
cd dotfiles
chmod +x ansible/files/*
ansible-playbook ansible/ansible.yml --ask-become-pass
ansible/files/decrypt.sh
```

*Manually install tmux / neovim plugins, red hat mono nerd font, docker, templ binaries*

## Roadmap
- [ ] Work on ansible playbooks
- [ ] Work on docker install script
- [ ] Automate patching and installing redhat mono
