#!/bin/bash

get_brightness() {
    if ! brightness_float=$(light -G 2>/dev/null); then
        echo "0"
        return 1
    fi

    if ! brightness_int=$(printf "%.0f" "$brightness_float" 2>/dev/null); then
        echo "0"
        return 1
    fi

    echo "$brightness_int"
}

notify_user() {
    local brightness_level=$(get_brightness)
    local icon="display-brightness-symbolic"  # Default icon, change if needed

    notify-send \
        -e \
        -h string:x-canonical-private-synchronous:brightness_notif \
        -h "int:value:$brightness_level" \
        -u low \
        -i "$icon" \
        "Screen" \
        "Brightness: ${brightness_level}%"
}

if [ "$1" = "brighten" ]; then
    light -A 5 && notify_user
else
    light -U 5 && notify_user
fi
