#!/bin/bash

current_version="v2.9.3"
release_version="v3.1.2"

# Function to compare version strings
version_compare() {
    if [ "$1" == "$2" ]; then
        echo "equal"
    else
        printf "%s\n%s\n" "$1" "$2" | sort -V | tail -n1
    fi
}

# Check if the release version is strictly greater than the current version
if [ "$(version_compare "$current_version" "$release_version")" == "$release_version" ]; then
    echo "Release version is strictly greater than the current version."
else
    echo "Release version is not strictly greater than the current version."
fi
