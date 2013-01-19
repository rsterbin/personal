#
# This saves the current vim directory and vimrc into current_vim /
# current_vimrc and puts the ones in this directory in place -- or vice versa!
#

if [ -e current_vimrc ]
then
    rm -r ~/.vim
    mv current_vim ~/.vim
    mv current_vimrc ~/.vimrc
else
    mv ~/.vim current_vim
    mv ~/.vimrc current_vimrc
    cp -r vim ~/.vim
    cp vimrc ~/.vimrc
fi

