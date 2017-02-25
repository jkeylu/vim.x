"
" author: jKey Lu <jkeylu@gmail.com>
"

set runtimepath+=~/.vim/bundle/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('~/.vim/bundle'))

" The time of timeout seconds when updating/installing plugins
let g:dein#install_process_timeout = 1500

" {{{ dein.vim
" let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')
" }}}

source ~/.vim/layer/default.vim

for name in g:vimx#env.list()
  execute 'source ~/.vim/layer/' . fnameescape(name) . '.vim'
endfor

call dein#end()
call dein#call_hook('source')

filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
if dein#check_install()
  call dein#install()
endif

" vim:ft=vim fdm=marker et ts=4 sw=2 sts=2
