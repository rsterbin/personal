# window setups

# helper: for setups where we want to have a command running, we need to run the prompt command manually
force_title() {
    mytitle $1
    echo -ne "\x1b];$(window_title_project)\x07"
}

# include panel configurations
source $HOME/git/iterm2-my-shortcuts/$personal_window_config.sh

# main function
winset() {

    script -q /tmp/winsetout $HOME/git/iterm2-my-shortcuts/paneselect.pl $personal_window_config $1 $2
    output=$(tail -n 1 /tmp/winsetout)
    info=($output) 
    panecode=${info[0]}
    tabcolor=${info[1]}
    windowtitle=${info[2]}
    rm /tmp/winsetout

    echo ""
    mycolor $tabcolor
    force_title $windowtitle

    init_project_pane $panecode
}

