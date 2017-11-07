"
" author: jKey Lu <jkeylu@gmail.com>
"

" Note: Skip initialization for vim-tiny or vim-small
if 0 | endif

if &compatible
  set nocompatible " be iMproved
endif

let mapleader = ','


" Before
"
if filereadable(expand('~/.vim/before.vim'))
  source ~/.vim/before.vim
endif


" Bundle Settings
"
source ~/.vim/core/bundle.vim


" Basic Settings
"
source ~/.vim/core/basic.vim


" Extra Settings
"
source ~/.vim/core/extra.vim


" After
"
if filereadable(expand('~/.vim/after.vim'))
  source ~/.vim/after.vim
endif

" vim:ft=vim fdm=marker et ts=4 sw=2 sts=2
