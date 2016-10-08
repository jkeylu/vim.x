"
" author: jKey Lu <jkeylu@gmail.com>
"

" Note: Skip initialization for vim-tiny or vim-small
if 0 | endif

if &compatible
  set nocompatible " be iMproved
endif

let mapleader = ','


" Load default env
"
source ~/.vim/vimx.vim


" Before
"
if filereadable(expand('~/.vim/before.vim'))
  source ~/.vim/before.vim
endif


" NeoBundle Settings
"
if v:version >= 704
  source ~/.vim/bundle_dein.vim
else
  source ~/.vim/bundle_neobundle.vim
endif


" Basic Settings
"
source ~/.vim/basic.vim


" Extra Settings
"
source ~/.vim/extra.vim


" After
"
if filereadable(expand('~/.vim/after.vim'))
  source ~/.vim/after.vim
endif

" vim:ft=vim fdm=marker et ts=4 sw=2 sts=2
