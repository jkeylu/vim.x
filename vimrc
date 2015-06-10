"
" author: jKey Lu <jkeylu@gmail.com>
"

" Check Platform {{{1
"

source ~/.vim/vimrc.platform



" NeoBundle Settings {{{1
"

" Note: Skip initialization for vim-tiny or vim-small
if 0 | endif

source ~/.vim/vimrc.bundles



" Start {{{1
"

if filereadable($HOME.'/.vim/vimrc.start')
  source ~/.vim/vimrc.start
endif



" Vim Settings {{{1
"

source ~/.vim/vimrc.basic



" Plugins Settings {{{1
"

source ~/.vim/vimrc.plugins



" Map Key {{{1
"

source ~/.vim/vimrc.keymap



" End {{{1
"

if filereadable($HOME.'/.vim/vimrc.end')
	source ~/.vim/vimrc.end
endif
