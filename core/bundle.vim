"
" author: jKey Lu <jkeylu@gmail.com>
"

set runtimepath+=~/.vim/bundle/repos/github.com/Shougo/dein.vim

let g:vimx_loading_bundle = 1
" {{{ loading bundle
if dein#load_state('~/.vim/bundle')
  " Required:
  call dein#begin(expand('~/.vim/bundle'))

  " The time of timeout seconds when updating/installing plugins
  let g:dein#install_process_timeout = 1500

  " {{{ dein.vim
  " let dein manage dein
  " Required:
  call dein#add('Shougo/dein.vim')
  " }}}

  source ~/.vim/core/layer/default.vim

  for name in g:vimx#env.list()
    execute 'source ~/.vim/core/layer/' . fnameescape(name) . '.vim'
  endfor

  call dein#end()
  call dein#save_state()
end
" }}}

let g:vimx_loading_bundle = 0
" {{{ loading plugin config
source ~/.vim/core/layer/default.vim

for name in g:vimx#env.list()
  execute 'source ~/.vim/core/layer/' . fnameescape(name) . '.vim'
endfor
" }}}

call dein#call_hook('source')

if v:vim_did_enter
  call dein#call_hook('post_source')
else
  autocmd VimEnter * call dein#call_hook('post_source')
endif

filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
if dein#check_install()
  call dein#install()
endif

" vim:ft=vim fdm=marker et ts=4 sw=2 sts=2
