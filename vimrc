set nocompatible	" be iMproved
filetype off		" required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles
" 
" original epos on github
Bundle 'garbas/vim-snipmate'
Bundle 'guileen/vim-node'
Bundle 'honza/snipmate-snippets'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'jkeylu/jsbeautify.vim'
Bundle 'jkeylu/mark2666'
Bundle 'jkeylu/vimdoc_cn'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'myusuf3/numbers.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'Shougo/neocomplcache'
Bundle 'tomtom/tlib_vim'
Bundle 'tpope/vim-markdown'
Bundle 'vim-scripts/a.vim'
Bundle 'vim-scripts/bufexplorer.zip'
Bundle 'vim-scripts/FencView.vim'
Bundle 'vim-scripts/LargeFile'
Bundle 'vim-scripts/taglist.vim'
Bundle 'vim-scripts/xoria256.vim'
Bundle 'wavded/vim-stylus'


"
" function check system
"

function! MySys()
	if has("win32")
		return "windows"
	else
		return "linux"
	endif
endfunction


"
" Vim Settings
"

source $VIMRUNTIME/mswin.vim

if has("gui_running") || &t_Co == 256
	colorscheme xoria256
endif

if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

let mapleader=","

set fileencodings=utf-8,gbk,gb2312,cp936
set fileformats=unix,dos

set number

set backspace=indent,eol,start
set nobackup
set history=50
set showcmd

set incsearch
set ignorecase smartcase

set smartindent
set cindent

set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

if has("mouse")
	set mouse=a
endif

if has("autocmd")
	filetype plugin indent on

	" remember the position of the last time view
	augroup vimrcEx
		autocmd!
		autocmd FileType text setlocal textwidth=78
		autocmd BufReadPost *
			\ if line("'\"") > 1 && line("'\"") <= line("$") |
			\ exe "normal! g`\"" |
			\ endif
	augroup END
else
	set autoindent
endif

if has("gui_running")
	set lines=30
	set columns=100

	set cursorline
	hi cursorline guibg=#112233

	set guioptions-=T
	set guioptions-=m
	map <silent> <F4> :if &guioptions=~# 'T'<Bar>
		\set guioptions-=T<Bar>
		\set guioptions-=m<Bar>
		\else <Bar>
		\set guioptions+=T<Bar>
		\set guioptions+=m<Bar>
		\endif<CR>
endif

set laststatus=2
set statusline=\ %f%m%r%h%w\ \[%{&fileformat}\\%{&fileencoding}\]\ %=\ Line:%l/%L:%c

set foldmethod=marker
nnoremap <space> @=((foldclosed(line('.'))<0) ? 'zc' : 'zo')<cr>

if exists("&autochdir")
	set autochdir
endif

inoremap <expr> <C-j> pumvisible()?"<C-n>":"<C-x><C-o>"
inoremap <expr> <C-k> pumvisible()?"<C-p>":"<C-k>"


"
" Plugins Settings
"

" bufexplorer
map <leader><leader> <leader>be

" fencview
let g:fencview_autodetect=1
let g:fencview_auto_patterns='*.cnx,*.txt,*.html,*.php,*.cpp,*.h,*.c,*.css,*.java{|\=}'
let g:fencview_checklines=10

" LargeFile
let g:LargeFile=100

" Mark
if has("gui_running")
	let g:mwDefaultHighlightingPalette="extended"
	let g:mwDefaultHighlightingNum=18
endif

" NERD_Tree
let NERDTreeChDirMode=2
let NERDTreeWinSize=25
let NERDTreeQuitOnOpen=1
let NERDTreeShowLineNumbers=1
map <leader>nt :NERDTree<cr>

" Taglist
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_WinWidth=25
map <leader>tl :TlistToggle<cr>

" neocomplcache
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_enable_camel_case_completion=1
let g:neocomplcache_enable_underbar_completion=1
let g:neocomplcache_min_syntax_length=3

" dictionary
if has("autocmd")
	autocmd FileType javascript set dictionary+=$HOME/.vim/bundle/vim-node/dict/node.dict
endif

