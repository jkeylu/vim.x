"
" author: jKey Lu <jkeylu@gmail.com>
"

" Check Platform {{{1
"

source ~/.vim/setting.platform.vim



" NeoBundle Settings {{{1
"

" Note: Skip initialization for vim-tiny or vim-small
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible " be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
"
" original repos on github
NeoBundle 'junegunn/seoul256.vim'
NeoBundle 'jkeylu/mark2666'
NeoBundle 'jkeylu/vimcdoc'

NeoBundle 'Shougo/vimproc.vim', {
\   'build': {
\     'windows': '"C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Tools\VsDevCmd.bat" && nmake -f make_msvc.mak nodebug=1 "SDK_INCLUDE_DIR=C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Include"',
\     'cygwin': 'make -f make_cygwin.mak',
\     'mac': 'make -f make_mac.mak',
\     'linux': 'make',
\     'unix': 'gmake'
\   }
\ }

"NeoBundle 'MarcWeber/vim-addon-mw-utils'
"NeoBundle 'tomtom/tlib_vim'
"NeoBundle 'honza/vim-snippets'
"NeoBundle 'garbas/vim-snipmate'

NeoBundle 'ervandew/supertab'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'Shougo/neocomplcache'

if executable('ctags')
  NeoBundle 'majutsushi/tagbar'
endif

if executable('git')
  NeoBundle 'tpope/vim-fugitive'
endif

NeoBundle 'guileen/vim-node'
NeoBundle 'hynek/vim-python-pep8-indent'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'wavded/vim-stylus'

NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'

NeoBundle 'kien/ctrlp.vim'
NeoBundle 'tacahiroy/ctrlp-funky'

NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'jlanzarotta/bufexplorer'
NeoBundle 'yonchu/accelerated-smooth-scroll'

" vim-scripts repos
NeoBundle 'a.vim'
NeoBundle 'DoxygenToolkit.vim'
NeoBundle 'LargeFile'

" No iconv in windows?
" Download: https://github.com/jkeylu/vim.x/blob/master/windows/libiconv.dll?raw=true
if has('iconv')
  NeoBundle 'FencView.vim'
endif

" Always load auto-pairs at last.
NeoBundle 'jiangmiao/auto-pairs'

call neobundle#end()

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


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
