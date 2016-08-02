# Special setup that only needs to happen on OSX

if [[ $personal_os == "osx" ]]; then

    # Add Postgres.app command line tools
    export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

    # Add Go to the path
    export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

fi

