#
# This script sets up the files in this directory on a new home directory, which
# may or may not have some content in the .bash_profile and .bashrc files.
#

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

git submodule init
git submodule update
cp $DIR/gitconfig ~/.gitconfig
$DIR/swap_vim.sh
mv ~/.bash_profile ~/.old_bash_profile 2>/dev/null
cp $DIR/bash_profile ~/.bash_profile
mv ~/.profile ~/.old_profile 2>/dev/null
cp $DIR/profile ~/.profile
mv ~/.bashrc ~/.old_bashrc 2>/dev/null
cp $DIR/bashrc ~/.bashrc
vim ~/.bash_profile ~/.old_bash_profile ~/.profile ~/.old_profile ~/.bashrc ~/.old_bashrc
rm ~/.old_bash_profile ~/.old_profile ~/.old_bashrc 2>/dev/null
mkdir ~/.subversion 2>/dev/null
cp $DIR/subversion_config ~/.subversion/config

