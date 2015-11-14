"
" author: jKey Lu <jkeylu@gmail.com>
"

" [Avoid the escape key](http://vim.wikia.com/wiki/Avoid_the_escape_key)
imap jj <Esc>`^
nnoremap <Tab> <Esc>
vnoremap <Tab> <Esc>
onoremap <Tab> <Esc>

nnoremap <leader>q :q<CR>

" save read-only file
if executable('sudo')
  cmap w!! %!sudo tee > /dev/null %
endif

" toggle fold
nnoremap <silent> <space> @=((foldclosed(line('.'))<0) ? 'zc' : 'zo')<cr>

inoremap <expr> <C-j> pumvisible() ? '<C-n>' : '<C-x><C-o>'
inoremap <expr> <C-k> pumvisible() ? '<C-p>' : '<C-k>'

vnoremap $ $h

augroup vimx
  autocmd FileType help nmap <silent> <buffer> q :q<CR>
  autocmd FileType qf nmap <silent> <buffer> q :q<CR>
augroup END

" vim:ft=vim fdm=marker et ts=4 sw=2 sts=2
