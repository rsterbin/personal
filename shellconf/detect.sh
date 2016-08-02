# Detection goes here

# Check to see if we can use colors
case "$TERM" in
    xterm-color) personal_can_do_color=yes;;
    xterm-256color) personal_can_do_color=yes;;
esac
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    personal_can_do_color=yes
else
    personal_can_do_color=
fi
export personal_can_do_color

