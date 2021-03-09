# Generate a prompt colored for the environment type and including the git
# branch, optionally using a preset hostname

# Only use tput if we know we can
if [ "$personal_can_do_color" = yes ]; then
    PROMPT_RED=$(tput setaf 1)
    PROMPT_GREEN=$(tput setaf 2)
    PROMPT_YELLOW=$(tput setaf 3)
    PROMPT_BLUE=$(tput setaf 4)
    PROMPT_MAGENTA=$(tput setaf 5)
    PROMPT_CYAN=$(tput setaf 6)
    PROMPT_CLOSE_COLOR=$(tput sgr0)
fi

# Git or SVN branch, colored to indicate state
# Based on https://gist.github.com/47267
prompt_color_repo_branch() {
  git rev-parse --git-dir &> /dev/null
  git_status="$(git status -uno 2> /dev/null)"
  svn_lines=$(svn st 2> /dev/null | tr ";" "\n")
  svn_info="$(svn info 2> /dev/null)"
  branch_pattern="On branch ([^${IFS}]*)"
  nobranch_pattern="Not currently on any branch."
  remote_pattern="Your branch is (.*) of"
  diverge_pattern="Your branch and (.*) have diverged"
  svn_branch_pattern=$'URL: [^\n]*/branches/([^/\n]*)'
  svn_trunk_pattern=$'URL: [^\n]*/trunk([^\n]*)'
  svn_other_pattern=$'Repository Root: [^\n]*/([^/\n]*)'
  svn_allowed_prefixes="^((X)|(Performing status on external item)) "

  # Clean: green
  color="${PROMPT_GREEN}"

  # Any changes? Red.
  if [[ ! ${git_status} == "" ]]; then
      if [[ ! ${git_status} =~ "working directory clean" && ! ${git_status} =~ "working tree clean" && ! ${git_status} =~ "nothing to commit" ]]; then
          color="${PROMPT_RED}"
      fi
  fi
  for line in $svn_lines; do
      if [[ ! ${line} =~ ${svn_allowed_prefixes} ]]; then
          color="${PROMPT_RED}"
      fi
  done

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
  if [[ ${branch} == "none" ]]; then
      if [[ ${git_status} =~ ${nobranch_pattern} ]]; then
          branch="submodule"
      fi
  fi
  if [[ ${branch} == "none" ]]; then
      if [[ ${svn_info} =~ ${svn_branch_pattern} ]]; then
          branch=${BASH_REMATCH[1]}
      fi
  fi
  if [[ ${branch} == "none" ]]; then
      if [[ ${svn_info} =~ ${svn_trunk_pattern} ]]; then
          branch="trunk"
      fi
  fi
  if [[ ${branch} == "none" ]]; then
      if [[ ${svn_info} =~ ${svn_other_pattern} ]]; then
          branch=${BASH_REMATCH[1]}
      fi
  fi
  if [[ ${branch} != "none" ]]; then
      echo -e " \001${color}\002${branch}\001${PROMPT_CLOSE_COLOR}\002"
  fi
}

# Git branch without color
prompt_git_branch() {
  git rev-parse --abbrev-ref HEAD 2> /dev/null | sed -e 's/\(.*\)/ \1/'
}

# Open/close
OPEN_RED="\[${PROMPT_RED}\]"
OPEN_GREEN="\[${PROMPT_GREEN}\]"
OPEN_YELLOW="\[${PROMPT_YELLOW}\]"
OPEN_BLUE="\[${PROMPT_BLUE}\]"
OPEN_MAGENTA="\[${PROMPT_MAGENTA}\]"
OPEN_CYAN="\[${PROMPT_CYAN}\]"
CLOSE_COLOR="\[${PROMPT_CLOSE_COLOR}\]"

# Use the proper hostname (personal_vdev_hostname is set in manual.sh)
if [[ $personal_vdev_hostname != "" ]]; then
  PS_HOST=$personal_vdev_hostname
  PC_HOST=$personal_vdev_hostname
else
  PS_HOST="\h"
  PC_HOST=$HOSTNAME
fi

# Handle global prompt color
if [[ $personal_environment_type == "dev" ]]; then
    OPEN_COLOR=
elif [[ $personal_environment_type == "prod" ]]; then
    OPEN_COLOR=$OPEN_BLUE
elif [[ $personal_environment_type == "prod2" ]]; then
    OPEN_COLOR=$OPEN_CYAN
elif [[ $personal_environment_type == "db" ]]; then
    OPEN_COLOR=$OPEN_RED
elif [[ $personal_environment_type == "stage" ]]; then
    OPEN_COLOR=$OPEN_YELLOW
elif [[ $personal_environment_type == "demo" ]]; then
    OPEN_COLOR=$OPEN_GREEN
elif [[ $personal_environment_type == "master" ]]; then
    OPEN_COLOR=$OPEN_MAGENTA
fi

# Prompt
if [[ $OPEN_COLOR != "" && $personal_can_do_color == 'yes' ]]; then
    if [ "$personal_status_in_prompt" = yes ]; then
        PS1="${OPEN_COLOR}$? [\u@${PS_HOST} \w${CLOSE_COLOR}\$(prompt_color_repo_branch)${OPEN_COLOR}]$ ${CLOSE_COLOR}"
    elif [ "$personal_branch_in_prompt" = yes ]; then
        PS1="${OPEN_COLOR}$? [\u@${PS_HOST} \w${CLOSE_COLOR}\$(prompt_git_branch)${OPEN_COLOR}]$ ${CLOSE_COLOR}"
    else
        PS1="${OPEN_COLOR}$? [\u@${PS_HOST} \w]$ ${CLOSE_COLOR}"
    fi
else
    if [[ "$personal_status_in_prompt" = yes && $personal_can_do_color == 'yes' ]]; then
        PS1="$? [\u@${PS_HOST} \w\$(prompt_color_repo_branch)]$ "
    elif [ "$personal_branch_in_prompt" = yes ]; then
        PS1="$? [\u@${PS_HOST} \w\$(prompt_git_branch)]$ "
    else
        PS1="$? [\u@${PS_HOST} \w]$ "
    fi
fi
export PS1

# Window title
mytitle() {
    export CURRENT_PROJECT=$1
}
mycolor() {
    if [[ $personal_use_iterm2 == yes ]]; then
        hexcolor=$(get_hex_color_from_name $1)
        if [[ $hexcolor == "" ]]; then
            echo "To set a titlebar color, enter a hex code or named css color"
        else
            it2-tab-color $hexcolor
        fi
    fi
}
window_title_project() {
    if [[ $CURRENT_PROJECT != "" ]]; then
        this_project="${CURRENT_PROJECT}"
    elif [[ $personal_project != "" ]]; then
        this_project="${personal_project}"
    else
        this_project=""
    fi

    if [[ $this_project != "" ]]; then
        this_title=$this_project
        this_color="00cc00"
    else
        this_title="${USER}@${PC_HOST}"
        this_color=""
    fi

    echo -ne "${this_title}"
}

if [[ $personal_use_iterm2 == yes ]]; then
    export PROMPT_COMMAND='echo -ne "\x1b];$(window_title_project)\x07"'
else
    export PROMPT_COMMAND='echo -ne "\033]0;$(window_title_project)\007"'
fi

