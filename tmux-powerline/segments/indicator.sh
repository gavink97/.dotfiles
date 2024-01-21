empty_text=""

prefix_mode_text="WAIT"
copy_mode_text="COPY"
sync_mode_text="SYNC"

#everforest hard light theme
default_bg="#f2efe1"
default_fg="#fefbf0"

prefix_mode_fg="#fefbf0"
prefix_mode_bg="#f85552" # red

# prefix + [
copy_mode_fg=default_fg
copy_mode_bg="#f57d26" # orange

# prefix + Ctrl + x
sync_mode_fg=default_fg
sync_mode_bg="#3a94c5" # blue

# add padding and style to prefix indicators
# make it only show one prefix at a time
# export colors to gavin.sh
run_segment() {
    prefix_indicator="#[bg=${default_bg}]#{?client_prefix,#[fg=${prefix_mode_fg}]#[bg=${prefix_mode_bg}]${prefix_mode_text},#[fg=${default_fg}]${empty_text}}"
    copy_indicator="#[bg=${default_bg}]#{?pane_in_mode,#[fg=${copy_mode_fg}]#[bg=${copy_mode_bg}]${copy_mode_text},#[fg=${default_fg}]${empty_text}}"
    sync_indicator="#[bg=${default_bg}]#{?synchronize-panes,#[fg=${sync_mode_fg}]#[bg=${sync_mode_bg}]${sync_mode_text},#[fg=${default_fg}]${empty_text}}";

    echo $prefix_indicator$copy_indicator$sync_indicator
    return 0
}
