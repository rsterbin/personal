# Prompt colors
OPEN_BLUE="\[\033[0;34m\]"   # prod1
OPEN_TEAL="\[\033[0;36m\]"   # prod2
OPEN_GREEN="\[\033[0;32m\]"  # prod3
OPEN_YELLOW="\[\033[0;33m\]" # stage
OPEN_RED="\[\033[0;31m\]"    # dbserver
CLOSE_COLOR="\[\033[0m\]"

# Git branch in prompt, colored to indicate state
# Based on https://gist.github.com/47267
parse_git_branch() {
    git rev-parse --git-dir &> /dev/null
    git_status="$(git status 2> /dev/null)"
    branch_pattern="^# On branch ([^${IFS}]*)"
    remote_pattern="# Your branch is (.*) of"
    diverge_pattern="# Your branch and (.*) have diverged"

    # Colors without the brackets within the function
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 3)
    RED=$(tput setaf 1)
    CLOSE=$(tput sgr0)

    # Clean: green
    color="${GREEN}"

    # Any changes? Red.
    if [[ ! ${git_status} =~ "working directory clean" ]]; then
        color="${RED}"
    fi

    # Ahead/behind/diverged: yellow
    if [[ ${git_status} =~ ${remote_pattern} ]]; then
        color="${YELLOW}"
    fi
    if [[ ${git_status} =~ ${diverge_pattern} ]]; then
        color="${YELLOW}"
    fi

    # Grab the branch name and add it
    if [[ ${git_status} =~ ${branch_pattern} ]]; then
        branch=${BASH_REMATCH[1]}
        echo " ${color}${branch}${CLOSE}"
    fi
}

# export PS1="${OPEN_YELLOW}[\u@\h \w]$ ${CLOSE_COLOR}" # all color, no git branch (for stage/prod)
export PS1="[\u@\h \w\$(parse_git_branch)]$ " # default color, with colored git branch (for development)

export CLICOLOR="true"
export LSCOLORS="gxfxcxdxbxegedabagacad"
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}\007"'

export EDITOR="vim"
export PAGER="less"

umask 002
# alias ls="ls --color=auto" # Not on Solaris
# alias tocode="cd /some/code/location"

# export VIM_PROJECT="Unknown" # single-project zones

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

