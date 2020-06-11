# Special setup that only needs to happen on OSX

if [[ $personal_os == "osx" ]]; then

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

fi

