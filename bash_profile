# Sometimes the SAs set the path in .bash_profile; check this against it before
# saving
PATH="/opt/sunstudio12.1/bin"
PATH="${PATH}:/opt/SUNWspro/bin"
PATH="${PATH}:/usr/ccs/bin"
PATH="${PATH}:/usr/sfw/bin"
PATH="${PATH}:/usr/gnu/bin"
PATH="${PATH}:/usr/bin"
PATH="${PATH}:/usr/sbin"
PATH="${PATH}:/opt/omni/bin"
PATH="${PATH}:/opt/OMNIperl/bin"
PATH="${PATH}:/sbin"
PATH="${PATH}:/opt/csw/bin"
PATH="${PATH}:/opt/omni/bin"
PATH="${PATH}:/opt/php53/bin"
PATH="${PATH}:/opt/pgsql844/bin"
PATH="${PATH}:/opt/pgsql842/bin"
# Ditto for the man path
MANPATH="/usr/bin/man"
MANPATH="${PATH}:/usr/share/man"
MANPATH="${PATH}:/opt/omni/share/man"
MANPATH="${PATH}:/opt/omni/man"
export PATH MANPATH

# Fixes the term on iTerm
[[ $TERM == 'xterm' ]] && export TERM=xtermc
[[ $TERM == 'xterm-color' ]] && export TERM=xtermc
[[ -f ${HOME}/.bashrc ]] && . ${HOME}/.bashrc

