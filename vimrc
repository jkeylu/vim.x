"
" check system
"
let s:is_unix = has('unix')
let s:is_mswin = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_macunix = !s:is_mswin && (has('mac') || has('macunix') || has('gui_macvim') || system('uname') =~? '^darwin')


set nocompatible	" be iMproved
filetype off		" required!


set rtp +=~/.vim/bundle/vundle/
call vundle#rc()


" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles
" 
" original epos on github
Bundle 'ervandew/supertab'
Bundle 'garbas/vim-snipmate'
Bundle 'guileen/vim-node'
Bundle 'honza/snipmate-snippets'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'jkeylu/jsbeautify.vim'
Bundle 'jkeylu/mark2666'
Bundle 'jkeylu/vimdoc_cn'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'myusuf3/numbers.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'Shougo/neocomplcache'
Bundle 'tomtom/tlib_vim'
Bundle 'tpope/vim-markdown'
Bundle 'wavded/vim-stylus'
" vim-scripts repos
Bundle 'a.vim'
Bundle 'bufexplorer.zip'
Bundle 'DoxygenToolkit.vim'
Bundle 'FencView.vim'
Bundle 'LargeFile'
Bundle 'taglist.vim'
Bundle 'xoria256.vim'

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

let mapleader = ","

set fileencodings =utf-8,gbk,gb2312,cp936
set fileformats =unix,dos

set number

set backspace =indent,eol,start
set nobackup
set history =50
set showcmd

set incsearch
set ignorecase smartcase

set smartindent
set cindent

set tabstop =4
set softtabstop =4
set shiftwidth =4
set noexpandtab

if has("mouse")
	set mouse =a
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
	set lines =30
	set columns =100

	set cursorline
	hi cursorline guibg=#112233

	" hide Toolbar and Menu bar
	set guioptions -=T
	set guioptions -=m
	" <F4> Toggle show and hide
	map <silent> <F4> :if &guioptions=~# 'T'<Bar>
		\set guioptions -=T<Bar>
		\set guioptions -=m<Bar>
		\else <Bar>
		\set guioptions +=T<Bar>
		\set guioptions +=m<Bar>
		\endif<CR>
endif

set laststatus =2
set statusline =\ %f%m%r%h%w\ \[%{&fileformat}\\%{&fileencoding}\]\ %=\ Line:%l/%L:%c

set foldmethod =marker
nnoremap <space> @=((foldclosed(line('.'))<0) ? 'zc' : 'zo')<cr>

if exists("&autochdir")
	set autochdir
endif

" ctags
function! s:generate_ctags()
	if executable("ctags")
		silent! execute "!ctags -R --c++-kinds=+px --fields=+iaS --extra=+q ."
	endif

	if filereadable("tags")
		execute "set tags=tags;"
	endif
endfunction
set tags=tags;

" cscope
function! s:generate_cscope()
	if(has("cscope") && executable("cscope"))
		if(!s:is_mswin)
			silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
		else
			silent! execute "!dir /b /s *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
		endif

		silent! execute "!cscope -b"

		if filereadable("cscope.out")
			silent! execute "cs add cscope.out"
		endif
	endif
endfunction

if has("cscope")
	set cscopequickfix =s-,c-,d-,i-,t-,e-
	set csto =0
	set cst
	set csverb

	if filereadable("cscope.out")
		silent! execute "cs add cscope.out"
	endif
endif

" shortcut key
inoremap <expr> <C-j> pumvisible()?"<C-n>":"<C-x><C-o>"
inoremap <expr> <C-k> pumvisible()?"<C-p>":"<C-k>"
map <leader>qq :q<CR>
map <C-g>ct :call <SID>generate_ctags()<CR>
map <C-g>cs :call <SID>generate_cscope()<CR>

if has("cscope")
	nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
	nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
	nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
	nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
	nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
	nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
	nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
endif

" Fast reload vimrc
nmap <silent> <leader>ss :source $HOME/.vim/vimrc<CR>
" Fast edit vimrc
nmap <silent> <leader>ee :e $HOME/.vim/vimrc<CR>
" When vimrc was edited, reload it immediately
autocmd! BufWritePost s:vimrc_filename source $HOME/.vim/vimrc





"
" Preview Current File In Chrome
"

" uncomment next line and set chrome file path
" let s:chrome_file_path = ""

" trim string
function! s:trim(str)
	return tlib#string#TrimLeft( tlib#string#TrimRight(a:str) )
endfunction

" get my name by whoami
function! s:get_my_name()
	let name = system("whoami")
	if s:is_mswin
		let temp = split(name, "\\")
		let name = temp[len(temp) - 1]
	endif
	return s:trim(name)
endfunction

" get chrome path
" if exists s:chrome_file_path, it will be return
function! s:get_chrome_path()
	if exists('s:chrome_file_path')
		return s:chrome_file_path
	endif

	if s:is_cygwin || s:is_mswin
		let chrome = "C:\\Users\\" . s:get_my_name() . "\\AppData\\Local\\Google\\Chrome\\Application\\chrome.exe"

		if s:is_cygwin
			let chrome = system("cygpath -u \"" . chrome . "\"")
		endif

		return s:trim(chrome)
	endif
endfunction

" execute the command to open current file in browser
function! s:preview_file_in_chrome()
	let file = expand("%:p")
	if s:is_cygwin
		let file = system("cygpath -w " . file)
	endif
	let file = s:trim(file)

	let chrome = s:get_chrome_path()
	let command = chrome . " \"" . file . "\""

	echo command
	silent! execute "!" . command
	redraw!
	echo "open file in chrome: " . file
endfunction

map <Leader>pv :call <SID>preview_file_in_chrome()<CR>


" convert file
function! s:convert_file_to_unix_utf8()
	set fileformat =unix
	set fileencoding =utf-8
endfunction

map <C-g>ff :call<SID>convert_file_to_unix_utf8()<CR>




"
" Plugins Settings
"

" dictionary
if has("autocmd")
	autocmd FileType javascript set dictionary +=$HOME/.vim/bundle/vim-node/dict/node.dict
endif

" bufexplorer
map <leader><leader> <leader>be

" fencview
let g:fencview_autodetect = 1
let g:fencview_auto_patterns = '*.cnx,*.txt,*.html,*.php,*.cpp,*.h,*.c,*.css,*.java{|\=}'
let g:fencview_checklines = 10

" LargeFile
let g:LargeFile = 100

" Mark
if has("gui_running")
	let g:mwDefaultHighlightingPalette = "extended"
	let g:mwDefaultHighlightingNum = 18
endif

" NERD_Tree
let NERDTreeChDirMode = 2
let NERDTreeWinSize = 25
let NERDTreeQuitOnOpen =1
let NERDTreeShowLineNumbers = 1
map <leader>nt :NERDTree<cr>

" Taglist
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_Close_On_Select = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Inc_Winwidth = 1
let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 40
map <leader>tl :TlistToggle<cr>

" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3

" vim-indent-guides
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" numbers
nnoremap <F3> :NumbersToggle<CR>
