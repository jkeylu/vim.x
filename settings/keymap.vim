"
" author: jKey Lu <jkeylu@gmail.com>
"

" toggle fold
nnoremap <space> @=((foldclosed(line('.'))<0) ? 'zc' : 'zo')<cr>

inoremap <expr> <C-j> pumvisible()?'<C-n>':'<C-x><C-o>'
inoremap <expr> <C-k> pumvisible()?'<C-p>':'<C-k>'

map <leader>qq :q<CR>
map <C-g>ct :call <SID>generate_ctags()<CR>
map <C-g>cs :call <SID>generate_cscope()<CR>

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

map <C-g>ff :call<SID>convert_file_to_unix_utf8()<CR>

" bufexplorer
map <leader><leader> <leader>be

" nerdtree
map <leader>nt :NERDTree<cr>

" taglist
if executable('ctags')
  map <leader>tl :TlistToggle<cr>
endif
