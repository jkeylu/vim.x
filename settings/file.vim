"
" author: jKey Lu <jkeylu@gmail.com>
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

  " When vimrc was edited, reload it immediately
  autocmd! BufWritePost ~/.vim/vimrc source ~/.vim/vimrc
endif
