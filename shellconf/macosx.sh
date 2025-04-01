# Special setup that only needs to happen on OSX

if [[ $personal_os == "osx" ]]; then

    # Add Applications to the path
    export PATH=/Applications:$PATH

    # Add Homebrew to the path
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Add Postgres.app command line tools
    export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH

    # Add Go to the path
    export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

    # Add ansible-dk
    alias ansible-mode='eval "$(ansible-dk shell-init bash)"; export PS1="(ADK) $PS1"'

    # Boring no-cows :(
    export ANSIBLE_NOCOWS=1

    # OSX needs to calm down about zsh
    export BASH_SILENCE_DEPRECATION_WARNING=1

    # NVM
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    # PyEnv
    export PATH=$(pyenv root)/shims:$PATH

    # iTerm2 custom stuff
    if [[ $personal_use_iterm2 == yes ]]; then
        . $DIR/shellconf/iterm2/named-colors.sh
        . $DIR/shellconf/iterm2/iterm2-tab-color.sh
        . $DIR/shellconf/iterm2/shortcuts.sh
    fi

fi

