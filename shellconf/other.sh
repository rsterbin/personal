# Misc setup

export EDITOR="vim"
export PAGER="less"

# Color support for ls and grep, if available
if [ "$personal_can_do_color" = yes ]; then
    export CLICOLOR="true"
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        export LSCOLORS="gxfxcxdxbxegedabagacad"
    fi
    # alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Umask if we're working with other users
if [[ "$personal_single_user" != yes ]]; then
  umask 002
fi

