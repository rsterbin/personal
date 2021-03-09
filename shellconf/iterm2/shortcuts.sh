
# window setups (work macbook)

winset() {

    arg1=$1
    arg2=$2

    if [[ $arg1 == "" ]]; then
        echo "Known projects:"
        echo "  [1] C2S"
        echo "  [2] HNCT"
        echo "  [3] top"
        read -p "Which project? " inp
        arg1=$inp
    fi

    if [[ $arg1 == "1" ]]; then
        name="c2s"
    elif [[ $arg1 == "2" ]]; then
        name="hnct"
    elif [[ $arg1 == "3" ]]; then
        name="top"
    else
        name=$arg1
    fi

    if [[ $arg2 == "" ]]; then
        if [[ $name == "c2s" ]]; then
            echo "Known windows:"
            echo "  [1] git"
            echo "  [2] react (yarn)"
            echo "  [3] react (vim)"
            echo "  [4] psql (vim)"
            echo "  [5] psql (psql)"
            read -p "Which window? " inpc
            arg2=$inpc
        elif [[ $name == "hnct" ]]; then
            echo "Known windows:"
            echo "  [1] front (npm)"
            echo "  [2] front (vim)"
            echo "  [3] back (npm)"
            echo "  [4] back (vim)"
            read -p "Which window? " inph
            arg2=$inph
        fi
    fi

    if [[ $name == "c2s" ]]; then
        if [[ $arg2 == "1" ]]; then
            pane="git"
        elif [[ $arg2 == "2" ]]; then
            pane="react1"
        elif [[ $arg2 == "3" ]]; then
            pane="react2"
        elif [[ $arg2 == "4" ]]; then
            pane="psql1"
        elif [[ $arg2 == "5" ]]; then
            pane="psql2"
        else
            pane=$arg2
        fi
    elif [[ $name == "hnct" ]]; then
        if [[ $arg2 == "1" ]]; then
            pane="front1"
        elif [[ $arg2 == "2" ]]; then
            pane="front2"
        elif [[ $arg2 == "3" ]]; then
            pane="back1"
        elif [[ $arg2 == "4" ]]; then
            pane="back2"
        else
            pane=$arg2
        fi
    else
        pane=$arg2
    fi

    # echo "Window project is $name"
    # echo "Window pane is $pane"

    # c2s: 3 tabs: git, react (yarn + vim panes), psql (vim + psql panes)
    if [[ $name == "c2s" ]]; then
        mycolor magenta
        if [[ $pane == "git" ]]; then
            cd ~/git/click2ship/plumdash
            mytitle c2s-git
            git st
        elif [[ $pane == "react1" ]]; then
            cd ~/git/click2ship/plumdash
            mytitle c2s-react
            yarn run watch
        elif [[ $pane == "react2" ]]; then
            cd ~/git/click2ship/plumdash/app/frontend/js
            mytitle c2s-react
            git st
        elif [[ $pane == "psql1" ]]; then
            cd ~/git/click2ship/plumdash
            mytitle c2s-psql
            git st
        elif [[ $pane == "psql2" ]]; then
            cd ~/git/click2ship/plumdash
            mytitle c2s-psql
            psql postgresql://automator.db.velky.io:26947/automator -U plumdash
        else
            cd ~/git/click2ship/plumdash
            mytitle c2s-$pane
        fi

    # hnct: 2 tabs: front (npm + vim panes), back (npm + vim panes)
    elif [[ $name == "hnct" ]]; then
        mycolor green
        if [[ $pane == "front1" ]]; then
            cd ~/git/hand-in-hand/front-hnct
            mytitle hnct-front
            npm start
        elif [[ $pane == "front2" ]]; then
            cd ~/git/hand-in-hand/front-hnct/src
            mytitle hnct-front
            git st
        elif [[ $pane == "back1" ]]; then
            cd ~/git/hand-in-hand/back-hnct
            mytitle hnct-back
            `PORT=3001 npm start`
        elif [[ $pane == "back2" ]]; then
            cd ~/git/hand-in-hand/back-hnct
            mytitle hnct-back
            git st
        else
            cd ~/git/hand-in-hand
            mytitle c2s-$pane
        fi

    # top: 1 tab: top ordered by cpu
    elif [[ $name == "top" ]]; then
        mycolor red
        mytitle top
        top -o cpu

    fi

}

