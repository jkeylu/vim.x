" Check System {{{1
"
let s:is_unix = has('unix')
let s:is_mswin = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_macunix = !s:is_mswin && (has('mac') || has('macunix') || has('gui_macvim') || system('uname') =~? '^darwin')




" Vundle Settings {{{1
"

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
Bundle 'jkeylu/mark2666'
Bundle 'jkeylu/vimdoc_cn'

Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'honza/vim-snippets'
Bundle 'garbas/vim-snipmate'

Bundle 'ervandew/supertab'
Bundle 'guileen/vim-node'
Bundle 'hynek/vim-python-pep8-indent'
Bundle 'kchmck/vim-coffee-script'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'Shougo/neocomplcache'
Bundle 'tpope/vim-markdown'
Bundle 'wavded/vim-stylus'

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


" Vim Settings {{{1
"

if has("gui_running") || &t_Co == 256
	colorscheme xoria256
endif

if has("gui_running") || &t_Co > 2
	syntax on
	set hlsearch
endif

let mapleader = ","

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

set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

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
	autocmd BufNewFile,BufRead *.js,*.json set expandtab tabstop=2 shiftwidth=2 softtabstop=2
	autocmd BufNewFile,BufRead *.coffee set expandtab tabstop=2 shiftwidth=2 softtabstop=2
	autocmd BufNewFile,BufRead *.md,*.markdown set expandtab tabstop=4 shiftwidth=4 softtabstop=4
	autocmd BufNewFile,BufRead *.tpl set filetype=html
else
	set autoindent
endif

if has("gui_running")
	set lines=30
	set columns=100

	set cursorline
	hi cursorline guibg=#112233

	" hide Toolbar and Menu bar
	set guioptions-=T
	set guioptions-=m
	" <F4> Toggle show and hide
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

" Ruler
if exists('+colorcolumn')
	set colorcolumn=80
else
	au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
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
	set cscopequickfix=s-,c-,d-,i-,t-,e-
	set csto=0
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
if has("autocmd")
	autocmd! BufWritePost s:vimrc_filename source $HOME/.vim/vimrc
endif


" convert file
function! s:convert_file_to_unix_utf8()
	set fileformat=unix
	set fileencoding=utf-8
endfunction

map <C-g>ff :call<SID>convert_file_to_unix_utf8()<CR>




" Plugins Settings {{{1
"

" dictionary
if has("autocmd")
	autocmd FileType javascript set dictionary+=$HOME/.vim/bundle/vim-node/dict/node.dict
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
let NERDTreeDirArrows = 0
map <leader>nt :NERDTree<cr>

" Taglist
if executable('ctags')
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
endif

" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_disable_auto_complete = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1

" vim-indent-guides
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

