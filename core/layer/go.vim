
" {{{ vim-go
" Usage:
" `C-]` = `:GoDef`
" `C-t` = `:GoDefPop`
if g:vimx_loading_bundle
  call dein#add('fatih/vim-go',
        \ {
        \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
        \ })
else
  autocmd User dein#source#vim-go call s:vim_go_on_source()
  function s:vim_go_on_source()
    augroup vimx
      autocmd FileType go call s:go_settings()
    augroup END
  endfunction

  function! s:go_settings()
    nmap <silent> <buffer> <C-^> :GoReferrers<CR>
    nmap <silent> <buffer> <C-@> :GoRename<CR>
  endfunction
endif
" }}}

" vim:ft=vim fdm=marker et ts=4 sw=2 sts=2
