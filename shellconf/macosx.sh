# Special setup that only needs to happen on OSX

if [[ $personal_os == "osx" ]]; then

    # Add Postgres.app command line tools
    export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

    # Add Go to the path
    export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

    # Add Elastic Beanstalk to the path
    export PATH=$PATH:$HOME/.ebcli-virtual-env/executables

    # Alias pngcrush
    alias pngcrush=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/pngcrush

fi

