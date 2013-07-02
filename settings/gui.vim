"
" author: jKey Lu <jkeylu@gmail.com>
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
