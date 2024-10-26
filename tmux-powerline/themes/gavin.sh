if patched_font_in_use; then
	TMUX_POWERLINE_SEPARATOR_LEFT_BOLD=""
	TMUX_POWERLINE_SEPARATOR_LEFT_THIN=""
	TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD=""
	TMUX_POWERLINE_SEPARATOR_RIGHT_THIN=""
else
	TMUX_POWERLINE_SEPARATOR_LEFT_BOLD="◀"
	TMUX_POWERLINE_SEPARATOR_LEFT_THIN="❮"
	TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD="▶"
	TMUX_POWERLINE_SEPARATOR_RIGHT_THIN="❯"
fi

TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-'#3c464b'}
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR:-'#d3c6aa'}
TMUX_POWERLINE_SEG_AIR_COLOR=$("${TMUX_POWERLINE_DIR_HOME}/segments/air_color.sh")

TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}

if [ -z $TMUX_POWERLINE_WINDOW_STATUS_CURRENT ]; then
	TMUX_POWERLINE_WINDOW_STATUS_CURRENT=(
		"#[$(format inverse)]" \
		"$TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR" \
		" #I#F " \
		"$TMUX_POWERLINE_SEPARATOR_RIGHT_THIN" \
		" #W " \
		"#[$(format regular)]" \
		"$TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR"
	)
fi

if [ -z $TMUX_POWERLINE_WINDOW_STATUS_STYLE ]; then
	TMUX_POWERLINE_WINDOW_STATUS_STYLE=(
		"$(format regular)"
	)
fi

if [ -z $TMUX_POWERLINE_WINDOW_STATUS_FORMAT ]; then
	TMUX_POWERLINE_WINDOW_STATUS_FORMAT=(
		"#[$(format regular)]" \
		"  #I#{?window_flags,#F, } " \
		"$TMUX_POWERLINE_SEPARATOR_RIGHT_THIN" \
		" #W "
	)
fi

if [ -z $TMUX_POWERLINE_LEFT_STATUS_SEGMENTS ]; then
	TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
		"hostname #acbf87 #353c42" \
        "time ${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR} ${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR} ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN}"
        "tmux_session_info ${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR} ${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR}"  \
        "air ${TMUX_POWERLINE_SEG_AIR_COLOR} #fefbf0" \
        # "earthquake #f57d26 #859182" \
        "indicator"\
		# "ifstat 30 255" \
		# "ifstat_sys 30 255" \
		# "lan_ip 24 255 ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN}" \
		# "wan_ip 24 255" \
		#"vcs_branch #99b164 #fefbf0" \
		#"vcs_compare 60 255" \
		#"vcs_staged 64 255" \
		#"vcs_modified 9 255" \
		#"vcs_others 245 0" \
	)
fi

if [ -z $TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS ]; then
	TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
		"pwd ${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR} ${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR}" \
		#"macos_notification_count 29 255" \
		#"mailcount 9 255" \
		# "now_playing 234 37" \
		# "cpu 240 136" \
		# "load 237 167" \
		#"tmux_mem_cpu_load 234 136" \
		# "battery 137 127" \
		"weather #3A94C5 #fefbf0" \
		# "rainbarf 0 ${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR}" \
		#"xkb_layout 125 117" \
		"date_day #acbf87 #353c42" \
		"date #acbf87 #353c42 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
		#"utc_time 235 136 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
	)
fi
