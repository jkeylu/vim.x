"
" author: jKey Lu <jkeylu@gmail.com>
"

" Check Platform {{{1
"

source ~/.vim/setting.platform.vim



" Vundle Settings {{{1
"

set nocompatible	" be iMproved
filetype off		" required!


set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()


" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles
"
" original epos on github
Bundle 'jkeylu/mark2666'
Bundle 'jkeylu/vimdoc_cn'

Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'honza/vim-snippets'
Bundle 'garbas/vim-snipmate'

Bundle 'ervandew/supertab'
Bundle 'mattn/zencoding-vim'
Bundle 'Shougo/neocomplcache'

Bundle 'guileen/vim-node'
Bundle 'hynek/vim-python-pep8-indent'
Bundle 'kchmck/vim-coffee-script'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'pangloss/vim-javascript'
Bundle 'tpope/vim-markdown'
Bundle 'wavded/vim-stylus'

Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'

Bundle 'kien/ctrlp.vim'
Bundle 'tacahiroy/ctrlp-funky'

Bundle 'terryma/vim-multiple-cursors'

if executable('curl') && executable('git')
  Bundle 'mattn/gist-vim'
  Bundle 'mattn/webapi-vim'
endif

" vim-scripts repos
Bundle 'a.vim'
Bundle 'bufexplorer.zip'
Bundle 'DoxygenToolkit.vim'
Bundle 'FencView.vim'
Bundle 'LargeFile'
Bundle 'xoria256.vim'

if executable('ctags')
  Bundle 'taglist.vim'
endif



" Start {{{1
"

if filereadable($HOME.'/.vim/vimrc_start.vim')
  source ~/.vim/vimrc_start.vim
endif



" Vim Settings {{{1
"

source ~/.vim/setting.default.vim



" Plugins Settings {{{1
"

source ~/.vim/setting.plugin.vim



" Map Key {{{1
"

source ~/.vim/setting.keymap.vim



" End {{{1
"

if filereadable($HOME.'/.vim/vimrc_end.vim')
	source ~/.vim/vimrc_end.vim
endif
