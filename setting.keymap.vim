"
" author: jKey Lu <jkeylu@gmail.com>
"

" [Avoid the escape key](http://vim.wikia.com/wiki/Avoid_the_escape_key)
inoremap <Esc> <Esc>`^
imap jj <Esc>
nnoremap <Tab> <Esc>
vnoremap <Tab> <Esc>
onoremap <Tab> <Esc>

" save read-only file
if executable('sudo')
  cmap w!! %!sudo tee > /dev/null %
endif

" toggle fold
nnoremap <space> @=((foldclosed(line('.'))<0) ? 'zc' : 'zo')<cr>

inoremap <expr> <C-j> pumvisible()?'<C-n>':'<C-x><C-o>'
inoremap <expr> <C-k> pumvisible()?'<C-p>':'<C-k>'

nnoremap <C-g>ct :call <SID>generate_ctags()<CR>
nnoremap <C-g>cs :call <SID>generate_cscope()<CR>

if has('cscope')
  nmap <C-\>s :cs find s <C-R>=expand('<cword>')<CR><CR>:copen<CR>
  nmap <C-\>g :cs find g <C-R>=expand('<cword>')<CR><CR>
  nmap <C-\>d :cs find d <C-R>=expand('<cword>')<CR><CR>:copen<CR>
  nmap <C-\>c :cs find c <C-R>=expand('<cword>')<CR><CR>:copen<CR>
  nmap <C-\>t :cs find t <C-R>=expand('<cword>')<CR><CR>:copen<CR>
  nmap <C-\>e :cs find e <C-R>=expand('<cword>')<CR><CR>:copen<CR>
  nmap <C-\>f :cs find f <C-R>=expand('<cfile>')<CR><CR>:copen<CR>
  nmap <C-\>i :cs find i ^<C-R>=expand('<cfile>')<CR>$<CR>:copen<CR>
endif

" Fast reload vimrc
nmap <silent> <leader>ss :source ~/.vim/vimrc<CR>
" Fast edit vimrc
nmap <silent> <leader>ee :e ~/.vim/vimrc<CR>

nnoremap <C-g>ff :call<SID>convert_file_to_unix_utf8()<CR>

" bufexplorer
nmap <leader><leader> <leader>be

" nerdtree
nnoremap <leader>nt :NERDTree<cr>

" tagbar
if executable('ctags')
  nnoremap <leader>tl :TagbarToggle<cr>
endif

" ctrlp-funky
nnoremap <leader>fu :CtrlPFunky<CR>
" narrow the list down with a word under cursor
nnoremap <leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<CR>
