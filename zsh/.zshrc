# export ZSH="$HOME/.oh-my-zsh"
export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin
export ARCHPREFERENCE=arm64
export PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:$PATH"

# ZSH_THEME="wezm+"

# HYPHEN_INSENSITIVE="true"

# source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

alias "vi"="nvim"
alias "python"="python3"
alias "cat"="bat -p"
alias "cd"="z"
alias "ls"="eza"
alias "mkdir -r"="mkdir -p"

if [ "$(uname)" != "Darwin" ]; then
   alias "tailwindcss"="/opt/tailwindcss"
   export PATH=$PATH:/opt/go/bin
fi

# Switch to an arm64e shell by default
if [ "$(uname -m)" != "aarch64" ] && [ "$(uname -m)" != "arm64" ]; then
    exec /usr/bin/arch -arm64 /bin/zsh
fi

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

lazy_load_nvm() {
  unset -f npm node nvm
  export NVM_DIR=~/.nvm
  [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}
npm() {
  lazy_load_nvm
  npm $@
}

node() {
  lazy_load_nvm
  node $@
}

nvm() {
  lazy_load_nvm
  nvm $@
}

neofetch
