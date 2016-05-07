#!/usr/bin/env bash
#
# name    : vimx
# author  : jKey Lu <jkeylu@gmail.com>
# license : GPL
#

[[ -f ~/.vimrc ]] && mv ~/.vimrc ~/.vimrc.bak
[[ -L ~/.vimrc ]] || ln -s ~/.vim/vimrc ~/.vimrc

[[ -L ~/.config/nvim ]] || ln -s ~/.vim ~/.config/nvim

[[ -d ~/.vim/bundle ]] || mkdir ~/.vim/bundle
[[ -d ~/.vim/bundle/neobundle.vim ]] || git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

vim +NeoBundleInstall +qall
