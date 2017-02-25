
" {{{ vim-css3-syntax
call dein#add('hail2u/vim-css3-syntax', { 'on_ft': [ 'css', 'less', 'stylus' ] })
" }}}

" {{{ vim-less
call dein#add('groenewege/vim-less', { 'on_ft': [ 'less' ] })
" }}}

" {{{ vim-stylus
call dein#add('wavded/vim-stylus', { 'on_ft': [ 'stylus' ] })
" }}}

" {{{ vim-node
" Usage:
" Use `gf` inside `require('...')` to jump to source and module files
" Use `[I` on any keyword to look for it in the current and required files
" Use `:Nedit module_name` to edit the main file of a module
" Use `:Nedit module_name/lib/foo` to edit its `lib/foo.js` file
" Use `:Nedit .` to edit your Node projects main file
call dein#add('moll/vim-node')
" }}}

" {{{ vim-node-dict
call dein#add('guileen/vim-node-dict', { 'on_ft': [ 'javascript' ] })

augroup vimx
  autocmd FileType javascript set dictionary+=$HOME/.vim/bundle/repos/github.com/guileen/vim-node-dict/dict/node.dict
augroup END
" }}}

" {{{ vim-javascript
call dein#add('pangloss/vim-javascript', { 'on_ft': [ 'javascript' ] })

let g:html_indent_inctags = 'html,body,head,tbody'
let g:html_indent_script1 = 'inc'
let g:html_indent_style1 = 'inc'
" }}}

" {{{ tern_for_vim
" Usage:
" `TernDef` Jump to the definition of the thing under the cursor.
" `TernDoc` Look up the documentation of something.
" `TernType` Find the type of the thing under the cursor.
" `TernRefs` Show all references to the variable or property under the cursor.
" `TernRename` Rename the variable under the cursor.
call dein#add('ternjs/tern_for_vim', { 'build': 'npm install' })

augroup vimx
  autocmd FileType javascript call s:ternSettings()
augroup END

function! s:ternSettings()
  nmap <silent> <buffer> <C-]> :TernDef<CR>
  nmap <silent> <buffer> <C-^> :TernRefs<CR>
  nmap <silent> <buffer> <C-@> :TernRename<CR>
endfunction
" }}}

" vim:ft=vim fdm=marker et ts=4 sw=2 sts=2
