"
" author: jKey Lu <jkeylu@gmail.com>
"

VimxLoadSet background dark
syntax on

set clipboard+=unnamed

if has('mouse')
  set mouse=a
endif

set number
set scrolloff=4
set history=100
set nobackup
set showcmd
set backspace=indent,eol,start
set foldmethod=marker

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

" Read first line or last line to exec modeline
set modelines=1

" Show line break
set wrap
set nolist
set linebreak
let &showbreak = '↳ '

" auto open quickfix
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost l* nested lwindow

" search
set hlsearch
set incsearch
set ignorecase smartcase

"  Indent
set autoindent
set smartindent
set copyindent
set cindent

" tab style
set expandtab
set tabstop=4
set shiftwidth=2
set softtabstop=2

augroup vimx
  autocmd FileType markdown set shiftwidth=4 softtabstop=4
  autocmd FileType python set shiftwidth=4 softtabstop=4
  autocmd FileType typescript set shiftwidth=4 softtabstop=4
  autocmd FileType go set noexpandtab shiftwidth=4 softtabstop=4
augroup END

" auto set file type
augroup vimx
  autocmd BufNewFile,BufRead *.md set filetype=markdown
  autocmd BufNewFile,BufRead *.coffee set filetype=coffee
  autocmd BufNewFile,BufRead *.ts set filetype=typescript
  autocmd BufNewFile,BufRead *.styl set filetype=stylus
  autocmd BufNewFile,BufRead *.rs set filetype=rust
augroup END

" file encodings and formats
set encoding=utf-8
set fileencodings=utf-8,gbk,gb2312,cp936
set fileformats=unix,dos

" remember the position of the last time view
augroup vimx
  autocmd FileType text setlocal textwidth=78
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \	exe "normal! g`\"" |
        \ endif
augroup END


" gui
if has('gui_running')
  set lines=30
  set columns=100

  " hide Toolbar and Menu bar
  set guioptions-=T
  set guioptions-=m
  " <F4> Toggle show and hide
  map <silent> <leader>tt
        \ :if &guioptions=~# 'T' <Bar>
        \   set guioptions-=T <Bar>
        \   set guioptions-=m <Bar>
        \ else <Bar>
        \   set guioptions+=T <Bar>
        \   set guioptions+=m <Bar>
        \ endif<CR>
endif

" vim:ft=vim fdm=marker et ts=4 sw=2 sts=2
