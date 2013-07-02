"
" author: jKey Lu <jkeylu@gmail.com>
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
