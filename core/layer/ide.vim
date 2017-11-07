
" {{{ vim-startify
" Usage:
" `:SLoad`
" `:SSave`
" `:SDelete`
" `Startify`
if g:vimx_loading_bundle
  call dein#add('mhinz/vim-startify',
        \ {
        \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
        \ })
else
  autocmd User dein#source#vim-startify call s:vim_startify_on_source()
  function s:vim_startify_on_source()
    let g:startify_session_dir = '~/.cache/vimsession'
    let g:startify_session_persistence = 1
  endfunction
endif
" }}}

" vim:ft=vim fdm=marker et ts=4 sw=2 sts=2
