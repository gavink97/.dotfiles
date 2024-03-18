languages=`echo "golang lua zig c cpp python3 typescript nodejs" | tr ' ' '\n'`
core_utils=`echo "xargs fd mv sed awk curl" | tr ' ' '\n'`

selected=`printf "$languages\n$core_utils" | fzf`
read -p "query: " query

# light theme
# style=`echo "?style=perldoc"`

# dark theme
style=`echo "?style=rrt"`


if printf $languages | rg -qs $selected; then
    tmux neww bash -c "curl cht.sh/$selected/`echo $query$style | tr ' ' '+'` & while [ : ]; do sleep 1; done"
else
    tmux neww bash -c "curl cht.sh/$selected~$query$style & while [ : ]; do sleep 1; done"
fi
