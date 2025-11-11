import subprocess as sp
import os
import string
import pathlib

HOME = pathlib.Path.home()
DOTFILES = f'{HOME}/.dotfiles'
XDG_CONFIG_HOME = f'{HOME}/.config'


def _command_(origin, target: string) -> None:

    def _make_alias(origin, target: string) -> string:
        cmd = sp.run(['ln', '-s', origin, target], capture_output=True)
        return (cmd.stderr).decode("utf-8").lower()

    if os.path.lexists(target):
        print(f"'{target}' already exists.")
        return

    result = _make_alias(origin, target)

    if "file exists" in result:
        print(f"Skipping: Alias exists at ${target}")

    elif "no such file or directory" in result:
        dirName = os.path.dirname(target)

        if not os.path.isdir(dirName):
            try:
                os.mkdir(dirName)
                _make_alias(origin, target)
                print(f"Alias was successfully link: ${origin} --> ${target}")
            except FileExistsError:
                print(f"Directory '{directory_name}' already exists.")
            except PermissionError:
                print(
                    f"Permission denied: Unable to create '{directory_name}'.")
            except Exception as e:
                print(f"An error occurred: {e}")
        else:
            print("An unexpected error occured")

    else:
        print(f"Alias was successfully link: ${origin} --> ${target}")


def _check_macos() -> bool:
    cmd = sp.run(['uname', '-s'], capture_output=True)
    result = (cmd.stdout).decode("utf-8").lower()

    if "darwin" in result:
        return True

    elif "linux" in result:
        return False

    else:
        raise RuntimeError("Unexpected Operating System") from error


def main() -> None:
    _is_macos = _check_macos()

    if _is_macos:
        system = "macos"

    else:
        system = "nixos"

    files = {
        "alacritty": {
            "origin": f"{DOTFILES}/alacritty/{system}/alacritty.toml",
            "target": f"{XDG_CONFIG_HOME}/alacritty/alacritty.toml",
        },
        "alacritty_themes": {
            "origin": f"{DOTFILES}/alacritty/themes",
            "target": f"{XDG_CONFIG_HOME}/alacritty/themes",
        },
        "cheat_sheet": {
            "origin": f"{DOTFILES}/cht.sh",
            "target": f"{XDG_CONFIG_HOME}/cht.sh",
        },
        "fastfetch": {
            "origin": f"{DOTFILES}/fastfetch",
            "target": f"{XDG_CONFIG_HOME}/fastfetch",
        },
        "git_config": {
            "origin": f"{DOTFILES}/.gitconfig",
            "target": f"{HOME}/.gitconfig",
        },
        "keys": {
            "origin": f"{DOTFILES}/keys",
            "target": f"{XDG_CONFIG_HOME}/keys",
        },
        "ssh_config": {
            "origin": f"{DOTFILES}/ssh/config",
            "target": f"{HOME}/.ssh/config",
        },
        "starship": {
            "origin": f"{DOTFILES}/starship/starship.toml",
            "target": f"{XDG_CONFIG_HOME}/starship.toml",
        },
        "tmux_config": {
            "origin": f"{DOTFILES}/tmux/{system}/tmux.conf",
            "target": f"{XDG_CONFIG_HOME}/tmux/tmux.conf",
        },
        "tmux_nerd_font_config": {
            "origin": f"{DOTFILES}/tmux/tmux-nerd-font-window-name.yml",
            "target": f"{XDG_CONFIG_HOME}/tmux/tmux-nerd-font-window-name.yml",
        },
        "tmux_powerline": {
            "origin": f"{DOTFILES}/tmux-powerline",
            "target": f"{XDG_CONFIG_HOME}/tmux-powerline",
        },
        "zshrc": {
            "origin": f"{DOTFILES}/zsh/{system}/.zshrc",
            "target": f"{HOME}/.zshrc",
        },
    }

    if _is_macos:
        aerospace = {
            "origin": f"{DOTFILES}/aerospace",
            "target": f"{XDG_CONFIG_HOME}/aerospace"
        }

        neovim = {
            "origin": f"{DOTFILES}/nvim",
            "target": f"{XDG_CONFIG_HOME}/nvim",
        }

        files["aerospace"] = aerospace
        files["neovim"] = neovim

    else:
        eww = {"origin": f"{DOTFILES}/eww", "target": f"{XDG_CONFIG_HOME}/eww"}

        gsk = {
            "origin": f"{DOTFILES}/environment.d/gsk.conf",
            "target": f"{XDG_CONFIG_HOME}/environment.d/gsk.conf",
        }

        hypr = {
            "origin": f"{DOTFILES}/hypr",
            "target": f"{XDG_CONFIG_HOME}/hypr"
        }

        stylelint = {
            "origin": f"{DOTFILES}/.stylelintrc",
            "target": f"{HOME}/.stylelintrc",
        }

        swaync = {
            "origin": f"{DOTFILES}/swaync",
            "target": f"{XDG_CONFIG_HOME}/swaync"
        }

        swayosd = {
            "origin": f"{DOTFILES}/swayosd",
            "target": f"{XDG_CONFIG_HOME}/swayosd"
        }

        waybar = {
            "origin": f"{DOTFILES}/waybar",
            "target": f"{XDG_CONFIG_HOME}/waybar"
        }

        rofi = {
            "origin": f"{DOTFILES}/rofi",
            "target": f"{XDG_CONFIG_HOME}/rofi"
        }

        files["eww"] = eww
        files["gsk"] = gsk
        files["hyprland"] = hypr
        files["stylelint"] = stylelint
        files["swaync"] = swaync
        files["swayosd"] = swayosd
        files["waybar"] = waybar
        files["rofi"] = rofi

    for file in files:
        origin = files[file]["origin"]
        target = files[file]["target"]
        _command_(origin, target)


if __name__ == '__main__':
    main()
