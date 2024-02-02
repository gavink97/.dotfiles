#!/bin/bash

# LICENSE: THIS CODE IS NOT UNDER THE SAME LICENSE AS THE REST OF THE PROJECT.
# ALL COPYRIGHTS, PATENTS, TRADEMARKS, AND ATTRIBUTIONS FROM THE SOURCE FORM OF THE WORK
# DO NOT PERTAIN TO ANY PART OF THIS DERIVATIVE WORK.

# FOR MORE INFORMATION ON THE LICENSE PLEASE READ "TechDufus-dotfiles LICENSE"

# AUTHOR: TECHDUFUS
# REPO: TECHDUFUS/DOTFILES  https://github.com/TechDufus/dotfiles
# LICENSE: APACHE LICENSE 2.0

# MODIFIED BY: GAVIN KONDRATH
# WEBSITE: https://gav.ink/

# color codes
RESTORE='\033[0m'
NC='\033[0m'
BLACK='\033[00;30m'
RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
SEA="\\033[38;5;49m"
LIGHTGRAY='\033[00;37m'
LBLACK='\033[01;30m'
LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'
OVERWRITE='\e[1A\e[K'

#emoji codes
CHECK_MARK="${GREEN}\xE2\x9C\x94${NC}"
X_MARK="${RED}\xE2\x9C\x96${NC}"
PIN="${RED}\xF0\x9F\x93\x8C${NC}"
CLOCK="${GREEN}\xE2\x8C\x9B${NC}"
ARROW="${SEA}\xE2\x96\xB6${NC}"
BOOK="${RED}\xF0\x9F\x93\x8B${NC}"
HOT="${ORANGE}\xF0\x9F\x94\xA5${NC}"
WARNING="${RED}\xF0\x9F\x9A\xA8${NC}"
RIGHT_ANGLE="${GREEN}\xE2\x88\x9F${NC}"

DOTFILES_LOG="$HOME/.dotfiles.log"
VAULT_SECRET="$HOME/.ansible-vault/vault.secret"
DOTFILES_DIR="$HOME/.config"
IS_FIRST_RUN="$HOME/.dotfiles_run"

function _task {
    if [[ $TASK != "" ]]; then
        printf "${OVERWRITE}${LGREEN} [✓]  ${LGREEN}${TASK}\n"
    fi
    TASK=$1
    printf "${LBLACK} [ ]  ${TASK} \n${LRED}"
}

function _cmd {
    if ! [[ -f $DOTFILES_LOG ]]; then
        touch $DOTFILES_LOG
    fi
    > $DOTFILES_LOG
    if eval "$1" 1> /dev/null 2> $DOTFILES_LOG; then
        return 0
    fi

    printf "${OVERWRITE}${LRED} [X]  ${TASK}${LRED}\n"
    while read line; do
        printf "      ${line}\n"
    done < $DOTFILES_LOG
    printf "\n"

    rm $DOTFILES_LOG

    exit 1
}

function _clear_task {
    TASK=""
}

function _task_done {
    printf "${OVERWRITE}${LGREEN} [✓]  ${LGREEN}${TASK}\n"
    _clear_task
}

set -e


os=$(uname -s)

if ["$os" == "Linux"]; then
    if [ -f /etc/os-release ]; then
        source /etc/os-release

        if [ "$ID_LIKE" == "debian" ]; then
            echo "Ubuntu / Debian detected."
            os_type=$ID_LIKE

        elif [ "$ID_LIKE" == "fedora" ]; then
            echo "Fedora detected."
            os_type=$ID_LIKE

        elif [ "$ID" == "fedora" ]; then
            echo "Fedora detected."
            os_type=$ID

        else
            echo "Unsupported distribution: $ID"
            os_type=$ID
        fi
    fi
fi


if [ "$os" == "Darwin" ]; then
    if ! brew -v &> /dev/null; then
        _task "Installing Homebrew"
        _cmd '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    else
        _task "Updating Packages"
        _cmd "sudo brew update"
        _cmd "sudo brew upgrade"
    fi

    if ! brew -s python3 >/dev/null 2>&1; then
        _task "Installing Python3"
        _cmd "sudo brew install python3"
        _task "Updating Pip"
        _cmd "sudo python3 -m pip install --upgrade pip"
    fi

    if ! pip3 list | grep ansible >/dev/null 2>&1; then
        _task "Installing Ansible"
        _cmd "python3 -m pip install --user ansible"
    else
        _task "Updating Ansible"
        _cmd "pip3 install --upgrade ansible"
    fi

    if ! pip3 list | grep argcomplete >/dev/null 2>&1; then
        _task "Installing Python3 Argcomplete"
        _cmd "sudo pip3 install argcomplete"
        _cmd "sudo activate-global-python-argcomplete3"
    else
        _task "Updating Argcomplete"
        _cmd "pip3 install --upgrade argcomplete"
    fi

    if ! pip3 list | grep watchdog >/dev/null 2>&1; then
        _task "Installing Python3 Watchdog"
        _cmd "pip3 install watchdog"
    else
        _task "Updating Watchdog"
        _cmd "pip3 install --upgrade watchdog"
    fi
fi

if [ "$os_type" == "debian" ]; then
    _task "Updating Packages"
    _cmd "sudo apt-get update"
    _cmd "sudo apt-get upgrade -y"

    if ! dpkg -s ansible >/dev/null 2>&1; then
        _task "Installing Ansible"
        _cmd "sudo apt-get install -y software-properties-common"
        _cmd "sudo apt-add-repository -y ppa:ansible/ansible"
        _cmd "sudo apt-get update"
        _cmd "sudo apt-get install -y ansible"
    fi

    if ! dpkg -s python3 >/dev/null 2>&1; then
        _task "Installing Python3"
        _cmd "sudo apt-get install -y python3"
    fi

    if ! dpkg -s python3-pip >/dev/null 2>&1; then
        _task "Installing Python3 Pip"
        _cmd "sudo apt-get install -y python3-pip"
    fi

    if ! pip3 list | grep argcomplete >/dev/null 2>&1; then
        _task "Installing Python3 Argcomplete"
        _cmd "sudo pip3 install argcomplete"
        _cmd "sudo activate-global-python-argcomplete3"
    else
        _task "Updating Argcomplete"
        _cmd "pip3 install --upgrade argcomplete"
    fi

    if ! pip3 list | grep watchdog >/dev/null 2>&1; then
        _task "Installing Python3 Watchdog"
        _cmd "pip3 install watchdog"
    else
        _task "Updating Watchdog"
        _cmd "pip3 install --upgrade watchdog"
    fi
fi

if [ "$os_type" == "fedora" ]; then
    _task "Updating Packages"
    _cmd "sudo dnf update"
    _cmd "sudo dnf upgrade -y"

    if ! dnf -s python3 >/dev/null 2>&1; then
        _task "Installing Python3"
        _cmd "sudo dnf install -y python"
    fi

    if ! dnf -s python3-pip >/dev/null 2>&1; then
        _task "Installing Python3 Pip"
        _cmd "sudo dnf install -y python3-pip"
    fi

    if ! pip3 list | grep ansible >/dev/null 2>&1; then
        _task "Installing Ansible"
        _cmd "python3 -m pip install --user ansible"
    else
        _task "Updating Ansible"
        _cmd "pip3 install --upgrade ansible"
    fi

    if ! pip3 list | grep argcomplete >/dev/null 2>&1; then
        _task "Installing Python3 Argcomplete"
        _cmd "sudo pip3 install argcomplete"
        _cmd "sudo activate-global-python-argcomplete3"
    else
        _task "Updating Argcomplete"
        _cmd "pip3 install --upgrade argcomplete"
    fi

    if ! pip3 list | grep watchdog >/dev/null 2>&1; then
        _task "Installing Python3 Watchdog"
        _cmd "pip3 install watchdog"
    else
        _task "Updating Watchdog"
        _cmd "pip3 install --upgrade watchdog"
    fi
fi


if ! [[ -d "$DOTFILES_DIR" ]]; then
    _task "Cloning repository"
        _cmd "git clone --quiet https://github.com/gavink97/dotfiles.git $DOTFILES_DIR"
else
    _task "Updating repository"
        _cmd "git -C $DOTFILES_DIR pull --quiet"
fi


pushd "$DOTFILES_DIR" 2>&1 > /dev/null
_task "Installing Community Collection"
    _cmd "ansible-galaxy collection install community.general"


_task "Running playbook"; _task_done
if [[ -f $VAULT_SECRET ]]; then
    ansible-playbook --vault-password-file $VAULT_SECRET "$DOTFILES_DIR/ansible/ansible.yml" "$@"
else
    ansible-playbook "$DOTFILES_DIR/ansible/ansible.yml" "$@"
fi


popd 2>&1 > /dev/null

if ! [[ -f "$IS_FIRST_RUN" ]]; then
    echo -e "${CHECK_MARK} ${GREEN}First run complete!${NC}"
    echo -e "${ARROW} ${CYAN}Please reboot your computer to complete the setup.${NC}"
    touch "$IS_FIRST_RUN"
fi
