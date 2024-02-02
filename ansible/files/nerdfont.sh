#!/bin/bash

compare() {
    if [ "$1" == "$2" ]; then
        echo "equal"
    else
        printf "%s\n%s\n" "$1" "$2" | sort -V | tail -n1
    fi
}

release_info=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest)
download_url=$(echo "$release_info" | jq -r '.assets[] | select(.name == "FiraMono.zip") | .browser_download_url')
release_version=$(echo "$download_url" | awk -F '/' '{print $(NF-1)}')

nerd_font_path=$(fd "FiraMonoNerdFont-Medium" "$HOME")
version_path="${font_path#*FiraMono/}"
current_version="${version_path%%/*}"

os=$(uname -s)

if [ "$os" == "Darwin" ]; then
    release_version_directory="$HOME/Library/Fonts/FiraMono/$release_version"
    current_version_directory="$HOME/Library/Fonts/FiraMono/$current_version"
else
    release_version_directory="$HOME/.local/share/fonts/FiraMono/$release_version"
    current_version_directory="$HOME/.local/share/fonts/FiraMono/$current_version"
fi

if [ -z "$current_version"]; then
    curl -o "$HOME/Downloads/FiraMono.zip" -L "$download_url"

    mkdir "$HOME/Downloads/FiraMono"

    unzip "$HOME/Downloads/FiraMono.zip" -d "$HOME/Downloads/FiraMono/"

    mkdir -p "$release_version_directory"

    cp "$HOME/Downloads/FiraMono/*.otf" "$release_version_directory"

    fc-cache -f -v
fi

if [ "$(compare "$current_version" "$release_version")" == "$release_version" ]; then
    curl -o "$HOME/Downloads/FiraMono.zip" -L "$download_url"

    mkdir "$HOME/Downloads/FiraMono"

    unzip "$HOME/Downloads/FiraMono.zip" -d "$HOME/Downloads/FiraMono/"

    rm -rf "$current_version_directory"

    mkdir -p "$release_version_directory"

    cp "$HOME/Downloads/FiraMono/*.otf" "$release_version_directory"

    fc-cache -f -v
fi
