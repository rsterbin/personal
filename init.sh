#
# This script sets up the files in this directory on a new home directory, which
# may or may not have some content in the .bash_profile and .bashrc files.
#

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Submodules (vim plugins)
git submodule init
git submodule update

# Move the old configs out
has_old=no
if [ -e ~/.bash_profile ]; then
    mv ~/.bash_profile $DIR/old/bash_profile 2>/dev/null
    has_old=yes
fi
if [ -e ~/.profile ]; then
    mv ~/.profile $DIR/old/profile 2>/dev/null
    has_old=yes
fi
if [ -e ~/.bashrc ]; then
    mv ~/.bashrc $DIR/old/bashrc 2>/dev/null
    has_old=yes
fi
if [ -e ~/.inputrc ]; then
    mv ~/.inputrc $DIR/old/inputrc 2>/dev/null
    has_old=yes
fi
if [ -e ~/.gitconfig ]; then
    mv ~/.gitconfig $DIR/old/gitconfig 2>/dev/null
    has_old=yes
fi
if [ -e ~/.subversion/config ]; then
    mv ~/.subversion/config $DIR/old/subversion_config 2>/dev/null
    has_old=yes
fi

# Swap vim
$DIR/swap_vim.sh

# Copy the new configs in
cp $DIR/bash_profile ~/.bash_profile
sed "s|__REPO_DIR__|${DIR}|g" $DIR/bashrc > ~/.bashrc
cp $DIR/inputrc ~/.inputrc
cp $DIR/gitconfig ~/.gitconfig
mkdir ~/.subversion 2>/dev/null
cp $DIR/subversion_config ~/.subversion/config

# Write out the manual settings
rm $DIR/shellconf/manual.sh 2>/dev/null

echo "# Manual settings (generated by init.sh)" >> $DIR/shellconf/manual.sh
echo "" >> $DIR/shellconf/manual.sh

read -p "Your OS (osx/ubuntu/omnios)? " inp
echo "personal_os=\"$inp\"" >> $DIR/shellconf/manual.sh
personal_os=$inp

read -p "Your environment type (dev/demo/stage/prod)? " inp
echo "personal_environment_type=\"$inp\"" >> $DIR/shellconf/manual.sh

read -p "Custom hostname? " inp
if [[ $inp != "" ]]; then
    echo "personal_vdev_hostname=\"$inp\"" >> $DIR/shellconf/manual.sh
fi

read -p "Do you want the current git branch in your prompt (Y/n)? " inp
if [[ $inp == "n" || $inp == "N" ]]; then
    echo ""
    echo "personal_branch_in_prompt=no" >> $DIR/shellconf/manual.sh
else
    echo "personal_branch_in_prompt=yes" >> $DIR/shellconf/manual.sh
    read -p "Do you want the current git status in your prompt (Y/n)? " inp
    if [[ $inp == "n" || $inp == "N" ]]; then
        echo ""
        echo "personal_status_in_prompt=no" >> $DIR/shellconf/manual.sh
    else
        echo "personal_status_in_prompt=yes" >> $DIR/shellconf/manual.sh
    fi
fi

if [[ $personal_os == "osx" ]]; then
    read -p "Are you using iTerm2 over version 3.3 (Y/n)? " inp
    if [[ $inp == "n" || $inp == "N" ]]; then
        echo ""
        echo "personal_use_iterm2=no" >> $DIR/shellconf/manual.sh
    else
        echo "personal_use_iterm2=yes" >> $DIR/shellconf/manual.sh
        read -p "Which window pane configuration would you like to use? (work/personal) " inp
        echo "personal_window_config=\"$inp\"" >> $DIR/shellconf/manual.sh
    fi
fi

read -p "Are you the only user (Y/n)? " inp
if [[ $inp == "n" || $inp == "N" ]]; then
    echo ""
    echo "personal_single_user=no" >> $DIR/shellconf/manual.sh
else
    echo "personal_single_user=yes" >> $DIR/shellconf/manual.sh
fi

read -p "Single project name? " inp
if [[ $inp != "" ]]; then
    echo "personal_single_project=yes" >> $DIR/shellconf/manual.sh
    echo "personal_project=\"$inp\"" >> $DIR/shellconf/manual.sh
    read -p "Code location? " inp
    echo "personal_code_location=\"$inp\"" >> $DIR/shellconf/manual.sh
else
    echo "personal_single_project=no" >> $DIR/shellconf/manual.sh
fi

# Alert that old files are available in case of emergency
if [[ $has_old == 'yes' ]]; then
    echo "Take a look at $DIR/old/ to see if there's anything you need to preserve"
fi

echo "The following files have been updated:"
echo "  * ~/.bash_profile"
echo "  * ~/.bashrc"
echo "  * ~/.vimrc"
echo "  * ~/.inputrc"
echo "  * ~/.gitconfig"
echo "  * ~/.subversion/config"
echo ""
echo "Please review them before you begin working!"
echo ""

