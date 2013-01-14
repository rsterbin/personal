#
# This checks each of the files here against its counterparts and looks for
# changes.  Before you run it, ensure that there are no local changes.
#

DIFF_BASH_PROFILE=`diff ~/.bash_profile bash_profile`
DIFF_BASHRC=`diff ~/.bashrc bashrc`
DIFF_SSH_CONFIG=`diff ~/.ssh/config ssh_config`
DIFF_SUBVERSION_CONFIG=`diff ~/.subversion/config subversion_config`
DIFF_GIT_CONFIG=`diff ~/.gitconfig gitconfig`
DIFF_VIMRC=`diff ~/.vimrc vimrc`

DIFF_VIM_DIR=""
for file in `find vim -type f | grep -v "/\.svn/"`
do
    diff=`diff ~/.$file $file`
    if [ -n "$diff" ]; then
        # DIFF_VIM_DIR= "${DIFF_VIM_DIR}\n${diff}"
        echo "$diff"
    fi
done
echo "$DIFF_VIM_DIR"

if [ -n "$DIFF_BASH_PROFILE" ]; then
    echo "============="
    echo "Bash Profile:"
    echo "============="
    echo "$DIFF_BASH_PROFILE"
fi

if [ -n "$DIFF_BASHRC" ]; then
    echo "======="
    echo "BashRC:"
    echo "======="
    echo "$DIFF_BASHRC"
fi

if [ -n "$DIFF_SSH_CONFIG" ]; then
    echo "==========="
    echo "SSH Config:"
    echo "==========="
    echo "$DIFF_SSH_CONFIG"
fi

if [ -n "$DIFF_SUBVERSION_CONFIG" ]; then
    echo "=================="
    echo "Subversion Config:"
    echo "=================="
    echo "$DIFF_SUBVERSION_CONFIG"
fi

if [ -n "$DIFF_GIT_CONFIG" ]; then
    echo "==========="
    echo "Git Config:"
    echo "==========="
    echo "$DIFF_GIT_CONFIG"
fi

if [ -n "$DIFF_VIMRC" ]; then
    echo "======="
    echo "VIMRC:"
    echo "======="
    echo "$DIFF_VIMRC"
fi

