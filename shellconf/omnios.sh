# Special setup that only needs to happen on OmniOS

if [[ $personal_os == "omnios" ]]; then

    # Sometimes the SAs set the path in .bash_profile; check this against it
    PATH="/opt/omni/bin"
    PATH="${PATH}:/usr/gnu/bin"
    PATH="${PATH}:/usr/ccs/bin"
    PATH="${PATH}:/usr/sfw/bin"
    PATH="${PATH}:/opt/sunstudio12.1/bin"
    PATH="${PATH}:/opt/SUNWspro/bin"
    PATH="${PATH}:/usr/gnu/bin"
    PATH="${PATH}:/usr/bin"
    PATH="${PATH}:/bin"
    PATH="${PATH}:/sbin"
    PATH="${PATH}:/usr/sbin"
    PATH="${PATH}:/opt/omni/bin"
    PATH="${PATH}:/opt/OMNIperl/bin"
    PATH="${PATH}:/opt/php53/bin"
    PATH="${PATH}:/opt/pgsql/bin"
    PATH="${PATH}:/opt/pgsql844/bin"
    PATH="${PATH}:/opt/pgsql842/bin"

    # Ditto for the man path
    MANPATH="/usr/bin/man"
    MANPATH="${MANPATH}:/usr/share/man"
    MANPATH="${MANPATH}:/opt/omni/share/man"
    MANPATH="${MANPATH}:/opt/omni/man"
    export PATH MANPATH

    # Fixes the term on iTerm
    [[ $TERM == 'xterm' ]] && export TERM=xtermc
    [[ $TERM == 'xterm-color' ]] && export TERM=xtermc
    [[ $TERM == 'xterm-256color' ]] && export TERM=xtermc

fi

