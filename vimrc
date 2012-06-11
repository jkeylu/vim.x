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
" load bundle
"

call pathogen#infect()


"
" Vim Settings
"

colorscheme oceandeep
set fileencodings=utf-8,gbk,gb2312,cp936
set fileformats=unix,dos
set nocompatible
let mapleader=","
set backspace=indent,eol,start
set nobackup
set history=50
set showcmd
set incsearch
set ignorecase smartcase

if has("mouse")
	set mouse=a
endif

if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

if has("autocmd")
	filetype plugin indent on
	augroup vimrcEx
	au!
	autocmd FileType text setlocal textwidth=78
	autocmd BufReadPost *
		\ if line("'\"") > 1 && line("'\"") <= line("$") |
		\ exe "normal! g`\"" |
		\ endif
	augroup END
else
	set autoindent
endif

source $VIMRUNTIME/mswin.vim
set number
set smartindent
set cindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

if(MySys() == "windows")
	set lines=25
	set columns=90
endif

if has("gui_running")
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

