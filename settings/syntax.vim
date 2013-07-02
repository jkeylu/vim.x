"
" author: jKey Lu <jkeylu@gmail.com>
"

if &t_Co > 2 || has('gui_running')
  syntax on
endif

set background=dark

if &t_Co >= 256 || has('gui_running')
  colorscheme xoria256
endif
