echo setopt no_global_rcs >> ~/.zshenv

export XDG_CONFIG_HOME=$HOME/.config
export LANG=en_US.UTF-8
# export ARCHPREFERENCE=arm64

export GOPATH=$HOME/go
# export ANDROID_HOME=$HOME/Library/Android/sdk
# export ANDROID_EMULATOR_HOME=$HOME/.android/avd

export PATH=$PATH:$GOPATH/bin
# export PATH=/Library/Frameworks/Python.framework/Versions/3.11/bin:$PATH
# export PATH=$HOME/development/flutter/bin:$PATH
# export PATH=$HOME/.gem/bin:$PATH
# export PATH=$PATH:$HOME/.rvm/bin
# export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
# export PATH=$PATH:$ANDROID_HOME/platform-tools
# export PATH=$PATH:$ANDROID_HOME/emulator

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
#
# setopt auto_cd
#
unset SSH_ASKPASS

alias "vi"="nvim"
alias "python"="python3"
alias "cat"="bat -p"
alias "cd"="z"
alias "ls"="eza"
alias "mkdir -r"="mkdir -p"
alias "simulator"="open -a Simulator"
alias "sudo"="sudo "
alias "sudovi"="sudo -E -s nvim"

#if [ "$(uname)" != "Darwin" ]; then
#   alias "tailwindcss"="/opt/tailwindcss"
#   export PATH=$PATH:/opt/go/bin
#fi

# Switch to an arm64e shell by default
#if [ "$(uname -m)" != "aarch64" ] && [ "$(uname -m)" != "arm64" ]; then
#    exec /usr/bin/arch -arm64 /bin/zsh
#fi

if [ -z "$TMUX" ]
then
    tmux attach -t TMUX || tmux new -s TMUX
fi

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

fastfetch
