
# window setups (work macbook)

# helper: for setups where we want to have a command running, we need to run the prompt command manually
force_title() {
    mytitle $1
    echo -ne "\x1b];$(window_title_project)\x07"
}

# main function
winset() {

    arg1=$1
    arg2=$2

    if [[ $arg1 == "" ]]; then
        echo "Known projects:"
        echo "  [1] C2S"
        echo "  [2] HNCT"
        echo "  [3] top"
        echo "  [4] OTTM"
        echo "  [5] SYSL"
        echo "  [6] NYLeg"
        read -p "Which project? " inp
        arg1=$inp
    fi

    if [[ $arg1 == "1" ]]; then
        name="c2s"
    elif [[ $arg1 == "2" ]]; then
        name="hnct"
    elif [[ $arg1 == "3" ]]; then
        name="top"
    elif [[ $arg1 == "4" ]]; then
        name="ottm"
    elif [[ $arg1 == "5" ]]; then
        name="sysl"
    elif [[ $arg1 == "6" ]]; then
        name="nyleg"
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
        elif [[ $name == "ottm" ]]; then
            echo "Known windows:"
            echo "  [1] entry (python)"
            echo "  [2] psql (kerberos)"
            read -p "Which window? " inph
            arg2=$inph
        elif [[ $name == "sysl" ]]; then
            echo "Known windows:"
            echo "  [1] front (yarn)"
            echo "  [2] front (vim)"
            echo "  [3] back (npm)"
            echo "  [4] back (vim)"
            read -p "Which window? " inph
            arg2=$inph
        elif [[ $name == "nyleg" ]]; then
            echo "Known windows:"
            echo "  [1] front (npm)"
            echo "  [2] front (vim)"
            echo "  [3] back (npm)"
            echo "  [4] back (vim)"
            echo "  [5] curl"
            echo "  [6] api"
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
    elif [[ $name == "ottm" ]]; then
        if [[ $arg2 == "1" ]]; then
            pane="entry"
        elif [[ $arg2 == "2" ]]; then
            pane="psql"
        else
            pane=$arg2
        fi
    elif [[ $name == "sysl" ]]; then
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
    elif [[ $name == "nyleg" ]]; then
        if [[ $arg2 == "1" ]]; then
            pane="front1"
        elif [[ $arg2 == "2" ]]; then
            pane="front2"
        elif [[ $arg2 == "3" ]]; then
            pane="back1"
        elif [[ $arg2 == "4" ]]; then
            pane="back2"
        elif [[ $arg2 == "5" ]]; then
            pane="curl"
        elif [[ $arg2 == "6" ]]; then
            pane="api"
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
            force_title c2s-react
            history -s "yarn run watch"
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
            force_title c2s-psql
            history -s "psql postgresql://automator.db.velky.io:26947/automator -U plumdash"
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
            force_title hnct-front
            history -s "npm start"
            npm start
        elif [[ $pane == "front2" ]]; then
            cd ~/git/hand-in-hand/front-hnct/src
            mytitle hnct-front
            git st
        elif [[ $pane == "back1" ]]; then
            cd ~/git/hand-in-hand/back-hnct
            force_title hnct-back
            history -s "PORT=3001 npm start"
            `PORT=3001 npm start`
        elif [[ $pane == "back2" ]]; then
            cd ~/git/hand-in-hand/back-hnct
            mytitle hnct-back
            git st
        else
            cd ~/git/hand-in-hand
            mytitle hnct-$pane
        fi

    # top: 1 tab: top ordered by cpu
    elif [[ $name == "top" ]]; then
        mycolor red
        force_title top
        history -s "top -o cpu"
        top -o cpu

    # ottm: 1 tab: entry and psql panes
    elif [[ $name == "ottm" ]]; then
        mycolor orange
        if [[ $pane == "entry" ]]; then
            cd ~/git/officetime-taskman-bridge/
            mytitle ottm-entry
            history -s "workon ottm"
            workon ottm
        elif [[ $pane == "psql" ]]; then
            cd ~/git/officetime-taskman-bridge/
            force_title ottm-psql
            kubectl get po -ndemo
            echo " - ACCESS TO SERVER: kubectl exec -it demo-6d8c66cf58-9lc68 bash -ndemo"
            echo " - ACCESS TO DB: pgsql_taskman"
        else
            cd ~/git/officetime-taskman-bridge/
            mytitle ottm-$pane
        fi

    # sysl: 2 tabs: front (npm + vim panes), back (npm + vim panes)
    elif [[ $name == "sysl" ]]; then
        mycolor bisque
        if [[ $pane == "front1" ]]; then
            cd ~/git/sysl/front-sysl
            force_title sysl-front
            history -s "PORT=3004 yarn run start"
            PORT=3004 yarn run start
        elif [[ $pane == "front2" ]]; then
            cd ~/git/sysl/front-sysl/src
            force_title sysl-front
            git st
        elif [[ $pane == "back1" ]]; then
            cd ~/git/sysl/back-sysl
            force_title sysl-back
            history -s "PORT=3005 npm start"
            `PORT=3005 npm start`
        elif [[ $pane == "back2" ]]; then
            cd ~/git/sysl/back-sysl
            force_title sysl-back
            git st
        else
            cd ~/git/sysl
            mytitle sysl-$pane
        fi

    # nyleg: 2 tabs: front (npm/yarn + vim panes), curl
    elif [[ $name == "nyleg" ]]; then
        mycolor cornflowerblue
        if [[ $pane == "front1" ]]; then
            cd ~/git/nyleg/front-nyleg
            force_title nyleg-front
            history -s "PORT=3002 yarn run start"
            PORT=3002 yarn run start
        elif [[ $pane == "front2" ]]; then
            cd ~/git/nyleg/front-nyleg/src
            mytitle nyleg-front
            git st
        elif [[ $pane == "back1" ]]; then
            cd ~/git/nyleg/back-nyleg
            force_title nyleg-back
            history -s "PORT=3003 npm start"
            PORT=3003 npm start
        elif [[ $pane == "back2" ]]; then
            cd ~/git/nyleg/back-nyleg
            mytitle nyleg-back
            git st
        elif [[ $pane == "curl" ]]; then
            cd ~/git/nyleg/front-nyleg
            force_title nyleg-front
            echo "EXT API EXAMPLE: curl https://legislation.nysenate.gov/api/3/bills/2021/A123?key=rv3Tl5fofxEGzMF4x04ZZ75m0jXcChjT"
            echo "INT API EXAMPLE: curl -X POST http://localhost2:3003/api/v1/admin/auth/login -H \"Origin: http://localhost:3002\" -H \"Content-Type: application/json\" -d '{\"email\":\"rsterbin@gmail.com\",\"password\":\"mynewpass\"}' | jq"
            echo "INT API EXAMPLE: curl -X POST http://localhost2:3003/api/v1/admin/user/list -H \"Origin: http://localhost:3002\" -H \"Content-Type: application/json\" -d '{\"session\":{\"sid\":\"<COPY>\",\"uid\":\"<COPY>\",\"token\":\"<COPY>\"}}' | jq"
        elif [[ $pane == "api" ]]; then
            cd ~/git/pkg/express-api-support
            mytitle nyleg-api
            git st
        else
            cd ~/git/nyleg
            mytitle nyleg-$pane
        fi

    fi

}

