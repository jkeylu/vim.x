" {{{ vim-css3-syntax scss-syntax.vim
if g:vimx_loading_bundle
  call dein#add('hail2u/vim-css3-syntax', { 'on_ft': ['css', 'scss'] })
  call dein#add('cakebaker/scss-syntax.vim', { 'on_ft': 'scss' })
endif
" }}}

" vim:ft=vim fdm=marker et ts=4 sw=2 sts=2
