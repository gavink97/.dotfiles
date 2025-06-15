#!/bin/bash

if wpctl status | rg -q 'MUTED'; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
fi

if [ "$1" = "volume_up" ]; then
    wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
else
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
fi
