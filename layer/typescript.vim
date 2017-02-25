
" {{{ typescript-vim
" Usage: `:make`
call dein#add('leafgarland/typescript-vim', { 'on_ft': [ 'typescript' ] })
" }}}

" {{{ tsuquyomi
" Usage:
" `<C-]>` Nav to definition
" `<C-t>` Move the cursor to the location where the last `<C-]>` was typed
" `<C-^>` Show references
" `<C-@>` Rename symbols
call dein#add('Quramy/tsuquyomi')

augroup vimx
  autocmd FileType typescript nmap <silent> <buffer> <C-@> <Plug>(TsuquyomiRenameSymbol)
augroup END
" }}}

" vim:ft=vim fdm=marker et ts=4 sw=2 sts=2
