
" {{{ typescript-vim
" Usage: `:make`
if g:vimx_loading_bundle
  call dein#add('leafgarland/typescript-vim', { 'on_ft': [ 'typescript' ] })
endif
" }}}

" {{{ tsuquyomi
" Usage:
" `<C-]>` Nav to definition
" `<C-t>` Move the cursor to the location where the last `<C-]>` was typed
" `<C-^>` Show references
" `<C-@>` Rename symbols
if g:vimx_loading_bundle
  call dein#add('Quramy/tsuquyomi',
        \ {
        \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
        \ })
else
  autocmd User dein#source#tsuquyomi call s:tsuquyomi_on_source()
  function s:tsuquyomi_on_source()
    augroup vimx
      autocmd FileType typescript nmap <silent> <buffer> <C-@> <Plug>(TsuquyomiRenameSymbol)
    augroup END
  endfunction
endif
" }}}

" vim:ft=vim fdm=marker et ts=4 sw=2 sts=2
