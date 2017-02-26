
" {{{ vim-go
" Usage:
" `C-]` = `:GoDef`
" `C-t` = `:GoDefPop`
call dein#add('fatih/vim-go')

augroup vimx
  autocmd FileType go call s:goSettings()
augroup END

function! s:goSettings()
  nmap <silent> <buffer> <C-^> :GoReferrers<CR>
  nmap <silent> <buffer> <C-@> :GoRename<CR>
endfunction
" }}}

" vim:ft=vim fdm=marker et ts=4 sw=2 sts=2
