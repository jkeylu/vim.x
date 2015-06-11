"
" author: jKey Lu <jkeylu@gmail.com>
"

" Note: Skip initialization for vim-tiny or vim-small
if 0 | endif

" Check Platform {{{1
"

source ~/.vim/vimrc.platform


" Load default env {{{1
"

source ~/.vim/vimrc.env



" Before {{{1
"

if filereadable(expand('~/.vim/vimrc.before'))
  source ~/.vim/vimrc.before
endif



" NeoBundle Settings {{{1
"

source ~/.vim/vimrc.bundles



" Vim Settings {{{1
"

source ~/.vim/vimrc.basic



" Plugins Settings {{{1
"

source ~/.vim/vimrc.plugins



" Map Key {{{1
"

source ~/.vim/vimrc.keymap



" After {{{1
"

if filereadable(expand('~/.vim/vimrc.after'))
  source ~/.vim/vimrc.after
endif

" vim:ft=vim fdm=marker et ts=2 sw=2 sts=2
