# Prompt colors
PROMPT_RED=$(tput setaf 1)
PROMPT_GREEN=$(tput setaf 2)
PROMPT_YELLOW=$(tput setaf 3)
PROMPT_BLUE=$(tput setaf 4)
PROMPT_MAGENTA=$(tput setaf 5)
PROMPT_CYAN=$(tput setaf 6)
PROMPT_CLOSE_COLOR=$(tput sgr0)

OPEN_RED="\[${PROMPT_RED}\]"
OPEN_GREEN="\[${PROMPT_GREEN}\]"
OPEN_YELLOW="\[${PROMPT_YELLOW}\]"
OPEN_BLUE="\[${PROMPT_BLUE}\]"
OPEN_MAGENTA="\[${PROMPT_MAGENTA}\]"
OPEN_CYAN="\[${PROMPT_CYAN}\]"
CLOSE_COLOR="\[${PROMPT_CLOSE_COLOR}\]"

# Git branch
prompt_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}

# Git branch, colored to indicate state
# Based on https://gist.github.com/47267
prompt_color_git_branch() {
    git rev-parse --git-dir &> /dev/null
    git_status="$(git status 2> /dev/null)"
    branch_pattern="On branch ([^${IFS}]*)"
    nobranch_pattern="Not currently on any branch."
    remote_pattern="Your branch is (.*) of"
    diverge_pattern="Your branch and (.*) have diverged"

    # Clean: green
    color="${PROMPT_GREEN}"

    # Any changes? Red.
    if [[ ! ${git_status} =~ "working directory clean" ]]; then
        color="${PROMPT_RED}"
    fi

    # Ahead/behind/diverged: yellow
    if [[ ${git_status} =~ ${remote_pattern} ]]; then
        color="${PROMPT_YELLOW}"
    fi
    if [[ ${git_status} =~ ${diverge_pattern} ]]; then
        color="${PROMPT_YELLOW}"
    fi

    # Grab the branch name and add it
    branch="none"
    if [[ ${git_status} =~ ${branch_pattern} ]]; then
        branch=${BASH_REMATCH[1]}
    fi
    if [[ ${git_status} =~ ${nobranch_pattern} ]]; then
        branch="submodule"
    fi

    if [[ ${branch} != "none" ]]; then
        echo -e " \001${color}\002${branch}\001${PROMPT_CLOSE_COLOR}\002"
    fi
}

# export PS1="${OPEN_CYAN}[\u@\h \w${CLOSE_COLOR}\$(prompt_color_git_branch)${OPEN_CYAN}]$ ${CLOSE_COLOR}" # pick another color (for stage/prod)
export PS1="[\u@\h \w\$(prompt_color_git_branch)]$ " # default color, with colored git branch (for development)

export CLICOLOR="true"
export LSCOLORS="gxfxcxdxbxegedabagacad"
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}\007"'

export EDITOR="vim"
export PAGER="less"

umask 002
# alias ls="ls --color=auto" # only works with gnu ls; confirm that it's being used before enabling
# alias tocode="cd /some/code/location"

# export VIM_PROJECT="Unknown" # single-project zones

# Ora
export APPLICATION_ENV="reha-local-dev"

# DoodleDeals
# export PLATFORM="development"

# OmniCMS
# export APPLICATION_ENV="development"
# export OMNICMS_INI="/path/to/local_project.ini"
# export OMNICMS_ADMIN_INI="/path/to/local_admin.ini"

# Taubman
# PERL5LIB=/opt/taubman/CPAN/lib:/opt/taubman/CPAN/lib/site_perl
# export PERL5LIB

# alias taubsearch="find . -type f \( -name \"*.asp\" -o -name \"*.inc\" -o -name \"*.html\" -o -name \"*.pm\" -o -name \"*.pl\" -o -name \"*.conf\" \) | xargs grep"
# alias taubsearch1="find www/docs/ -type f \( -name \"*.asp\" -o -name \"*.inc\" -o -name \"*.html\" \) | xargs grep"
# alias taubsearch2="find www/docs/ -type f \( -name \"*.asp\" -o -name \"*.inc\" -o -name \"*.html\" -o -name \"*.xml\" \) | xargs grep"
# alias taubsearch3="find www/docs/ -type f \( -name \"*.asp\" -o -name \"*.inc\" -o -name \"*.html\" -o -name \"*.xml\" -o -name \"*.css\" -o -name \"*.js\" -o -name \"*.htm\" -o -name \"*.txt\" \) | xargs grep"

# Corpweb
PYTHONPATH=/www/bin/pylib
export PYTHONPATH

