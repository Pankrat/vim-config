#!/bin/sh
if [ ! -d ~/.vim/bundle/vundle ]; then
    mkdir -p ~/.vim/bundle
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi
echo "runtime vimrc" > ~/.vimrc
vim +BundleInstall +qall
