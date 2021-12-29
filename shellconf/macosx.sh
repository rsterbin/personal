# Special setup that only needs to happen on OSX

if [[ $personal_os == "osx" ]]; then

    # Add Applications to the path
    export PATH=/Applications:$PATH

    # Add PHP7 to the path
    export PATH=/usr/local/php5-7.3.8-20190811-205217/bin:$PATH

    # Add Postgres.app command line tools
    export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH

    # Add Go to the path
    export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

    # Add Elastic Beanstalk to the path
    export PATH=$PATH:$HOME/.ebcli-virtual-env/executables

    # Alias pngcrush
    alias pngcrush=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/pngcrush

    # Add Scala to the path
    export PATH=$PATH:$HOME/Source/scala-2.13.1/bin

    # Add ansible-dk
    alias ansible-mode='eval "$(ansible-dk shell-init bash)"; export PS1="(ADK) $PS1"'

    # Boring no-cows :(
    export ANSIBLE_NOCOWS=1

    # Catalina needs to calm down about zsh
    export BASH_SILENCE_DEPRECATION_WARNING=1

    # NVM
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    # PyEnv
    eval "$(pyenv init -)"
    export WORKON_HOME=~/.virtualenvs
    mkdir -p $WORKON_HOME
    . ~/.pyenv/versions/3.8.1/bin/virtualenvwrapper.sh

    # iTerm2 custom stuff
    if [[ $personal_use_iterm2 == yes ]]; then
        . $DIR/shellconf/iterm2/named-colors.sh
        . $DIR/shellconf/iterm2/iterm2-tab-color.sh
        . $HOME/git/iterm2-my-shortcuts/shortcuts.sh
        # test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
    fi

    # C2S search
    plumsearch() {
        search=$1
        current=`pwd | xargs basename`
        if [[ $current == "automator" || $current == "amz-edi" ]]; then
            for dir in edi core web shop daemon base; do grep -rn "$search" "$dir/src"; done
        fi
        if [[ $current == "plumdash" ]]; then
            grep -rn "$search" app
        fi
    }

fi

