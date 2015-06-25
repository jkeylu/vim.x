"
" author: jKey Lu <jkeylu@gmail.com>
"

" Note: Skip initialization for vim-tiny or vim-small
if 0 | endif

if &compatible
  set nocompatible " be iMproved
endif

let mapleader = ','


" Check Platform
"
source ~/.vim/vimrc.platform


" Load default env
"
source ~/.vim/vimrc.env


" Before
"
if filereadable(expand('~/.vim/vimrc.before'))
  source ~/.vim/vimrc.before
endif


" NeoBundle Settings
"
source ~/.vim/vimrc.bundles


" Vim Settings
"
source ~/.vim/vimrc.basic


" Map Key
"
source ~/.vim/vimrc.keymap


" After
"
if filereadable(expand('~/.vim/vimrc.after'))
  source ~/.vim/vimrc.after
endif

" vim:ft=vim fdm=marker et ts=4 sw=2 sts=2
