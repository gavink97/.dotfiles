#!/bin/sh

if [ "$SENDER" = "front_app_switched" ]; then
    ICON_PADDING_RIGHT=5

    case $INFO in
        "Firefox")
            ICON_PADDING_RIGHT=5
            ICON=
            ;;
        "Firefox Developer Edition")
            ICON_PADDING_RIGHT=5
            ICON=
            ;;
        "Zen")
            ICON_PADDING_RIGHT=4
            ICON=
            ;;
        "Calendar")
            ICON_PADDING_RIGHT=3
            ICON=
            ;;
        "Obsidian")
            ICON=
            ;;
        "Notes")
            ICON_PADDING_RIGHT=5
            ICON=
            ;;
        "Finder")
            ICON=󰀶
            ;;
        "Google Chrome")
            ICON_PADDING_RIGHT=7
            ICON=
            ;;
        "Zotero")
            ICON_PADDING_RIGHT=4
            ICON=
            ;;
        "Alacritty")
            ICON=
            ;;
        "Mail")
            ICON=󰇰
            ;;
        "KeePassXC")
            ICON=
            ;;
        "Preview")
            ICON_PADDING_RIGHT=3
            ICON=
            ;;
        "TextEdit")
            ICON_PADDING_RIGHT=4
            ICON=
            ;;
        "AlDente")
            ICON_PADDING_RIGHT=4
            ICON=
            ;;
        "SoundSource")
            ICON_PADDING_RIGHT=4
            ICON=
            ;;
        "System Settings")
            ICON_PADDING_RIGHT=4
            ICON=
            ;;
        *)
            ICON_PADDING_RIGHT=2
            ICON=
            ;;
    esac

    sketchybar --set $NAME icon=$ICON icon.padding_right=$ICON_PADDING_RIGHT
    sketchybar --set $NAME.name label="$INFO"
fi
