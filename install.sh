#!/usr/bin/env bash
#
# Name    : vimx
# Author  : jKey Lu <jkeylu@gmail.com>
# License : GPL
# GitHub  : https://github.com/jkeylu/vim.x
#

if [[ ! -d ~/.vim ]]; then
    git clone -b simple https://github.com/jkeylu/vim.x ~/.vim
fi

if [[ ! -d ~/.vim/.git ]]; then
    mv ~/.vim ~/.vim.bak
    git clone -b simple https://github.com/jkeylu/vim.x ~/.vim
fi

if [[ ! grep -q 'jkeylu/vim.x' ~/.vim/.git/config ]]; then
    mv ~/.vim ~/.vim.bak
    git clone -b simple https://github.com/jkeylu/vim.x ~/.vim
fi

if [[ ! grep -q 'simple' ~/.vim/.git/HEAD ]]; then
    work_dir="$(pwd)"
    cd ~/.vim
    git pull
    git checkout simple
    cd "$work_dir"
fi

if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [[ ! -f ~/.vimrc ]]; then
    ln -s ~/.vim/vimrc ~/.vimrc
fi

if [[ ! -L ~/.vimrc ]]; then
    mv ~/.vimrc ~/.vimrc.bak
    ln -s ~/.vim/vimrc ~/.vimrc
fi

if [[ $(readlink ~/.vimrc) != *"/.vim/vimrc" ]]; then
    mv ~/.vimrc ~/.vimrc.bak
    ln -s ~/.vim/vimrc ~/.vimrc
fi

vim +'PlugUpdate' +qall
