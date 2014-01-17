"
" author: jKey Lu <jkeylu@gmail.com>
"

" Base {{{1
"

behave mswin
set clipboard+=unnamed

if has('mouse')
  set mouse=a
endif

set number
set scrolloff=4
set history=100
set nobackup
set showcmd

" Highlight cursor line
set cursorline
hi cursorline guibg=#112233

" Status line
set laststatus=2
set statusline=\ %f%m%r%h%w\ \[%{&fileformat}\\%{&fileencoding}\]\ %=\ Line:%l/%L:%c

" Ruler
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

let mapleader = ','



" syntax {{{1
"

if &t_Co > 2 || has('gui_running')
  syntax on
endif

set background=dark

if &t_Co >= 256 || has('gui_running')
  let g:seoul256_background = 234
  silent! colorscheme seoul256
endif



" Format {{{1
"

set autoindent
set smartindent
set copyindent
set cindent

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set backspace=indent,eol,start

set foldmethod=marker

if exists('&autochdir')
  set autochdir
endif



" File {{{1
"

set fileencodings=utf-8,gbk,gb2312,cp936
set fileformats=unix,dos

if has('autocmd')
  filetype plugin indent on

  " remember the position of the last time view
  augroup vimrcEx
    autocmd!
    autocmd FileType text setlocal textwidth=78
    autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \	exe "normal! g`\"" |
      \ endif
  augroup END
  autocmd BufNewFile,BufRead *.js,*.json set expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd BufNewFile,BufRead *.coffee set expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd BufNewFile,BufRead *.md,*.markdown set expandtab tabstop=4 shiftwidth=4 softtabstop=4
  autocmd BufNewFile,BufRead *.html,*.tpl set expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd BufNewFile,BufRead *.py set expandtab tabstop=4 shiftwidth=4 softtabstop=4

  " When vimrc was edited, reload it immediately
  autocmd! BufWritePost ~/.vim/vimrc source ~/.vim/vimrc
endif



" Gui {{{1
"

if has('gui_running')
  set lines=30
  set columns=100

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



" Search {{{1
"

if &t_Co > 2 || has('gui_running')
  set hlsearch
endif

set incsearch
set ignorecase smartcase



" Functions {{{1
"

" ctags
function! s:generate_ctags()
  if executable('ctags')
    silent! execute '!ctags -R --c++-kinds=+px --fields=+iaS --extra=+q .'
  endif

  if filereadable('tags')
    execute 'set tags=tags;'
  endif
endfunction
set tags=tags;


" cscope
function! s:generate_cscope()
  if(has('cscope') && executable('cscope'))
    if(!g:vimx#platform.is_mswin)
      silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
    else
      silent! execute '!dir /b /s *.c,*.cpp,*.h,*.java,*.cs >> cscope.files'
    endif

    silent! execute '!cscope -b'

    if filereadable('cscope.out')
      silent! execute 'cs add cscope.out'
    endif
  endif
endfunction

if has('cscope')
  set cscopequickfix=s-,c-,d-,i-,t-,e-
  set csto=0
  set cst
  set csverb

  if filereadable('cscope.out')
    silent! execute 'cs add cscope.out'
  endif
endif


" convert file
function! s:convert_file_to_unix_utf8()
  set fileformat=unix
  set fileencoding=utf-8
endfunction
