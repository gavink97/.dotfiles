#!/bin/bash

get_volume() {
    volume_output=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>&1)
    local status=$?

    if [ $status -ne 0 ]; then
        echo "Error: wpctl failed"
        return 1
    fi

    if [[ "$volume_output" == *"MUTED"* ]]; then
        echo "Muted"
    else
        volume_value=$(awk '{print $2}' <<< "$volume_output")

        if ! [[ "$volume_value" =~ ^[0-9.]+$ ]]; then
            echo "Error: Invalid volume value"
            return 1
        fi

        percent=$(bc <<< "scale=0; ($volume_value * 100 + 0.5)/1" 2>/dev/null)

        if [ -z "$percent" ]; then
            echo "Error: bc calculation failed"
            return 1
        fi

        echo "${percent}%"
    fi
}

notify_user() {
    if [[ "$(get_volume)" == "Muted" ]]; then
        notify-send -e -h string:x-canonical-private-synchronous:volume_notif -u low -i "$(get_icon)" " Volume:" " Muted"
    else
        notify-send -e -h int:value:"$(get_volume | sed 's/%//')" -h string:x-canonical-private-synchronous:volume_notif -u low -i "$(get_icon)" " Volume Level:" " $(get_volume)" # &&
       # "$sDIR/Sounds.sh" --volume
    fi
}

if wpctl status | rg -q 'MUTED'; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
fi

if [ "$1" = "volume_up" ]; then
    wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && notify_user
else
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && notify_user
fi
