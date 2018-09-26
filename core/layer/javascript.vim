
" {{{ vim-javascript
if g:vimx_loading_bundle
  call dein#add('pangloss/vim-javascript',
        \ {
        \   'on_ft': 'javascript',
        \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
        \ })
else
  autocmd User dein#source#vim-javascript call s:vim_javascript_on_source()
  function s:vim_javascript_on_source()
    let g:javascript_plugin_jsdoc = 1
  endfunction
endif
" }}}

if !g:vimx#env.exists('tern_for_vim')
  " {{{ deoplete-ternjs
  if g:vimx_loading_bundle
    call dein#add('carlitux/deoplete-ternjs',
          \ {
          \   'build': 'npm install -g tern',
          \   'on_ft': 'javascript',
          \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
          \ })
  else
    autocmd User dein#source#deoplete-ternjs call s:deplete_ternjs_on_source()
    function s:deplete_ternjs_on_source()
      if executable('tern-no-port-file')
        let g:deoplete#sources#ternjs#tern_bin = 'tern-no-port-file'
      endif
    endfunction
  endif
  " }}}
else
  " {{{ tern_for_vim
  " Usage:
  " `TernDef` Jump to the definition of the thing under the cursor.
  " `TernDoc` Look up the documentation of something.
  " `TernType` Find the type of the thing under the cursor.
  " `TernRefs` Show all references to the variable or property under the cursor.
  " `TernRename` Rename the variable under the cursor.
  if g:vimx_loading_bundle
    call dein#add('ternjs/tern_for_vim',
          \ {
          \   'build': 'npm install',
          \   'on_ft': 'javascript',
          \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
          \ })
  else
    autocmd User dein#source#tern_for_vim call s:tern_for_vim_on_source()
    function s:tern_for_vim_on_source()
      augroup vimx
        autocmd FileType javascript call s:tern_for_vim_settings()
      augroup END
    endfunction

    function! s:tern_for_vim_settings()
      nmap <silent> <buffer> <C-]> :TernDef<CR>
      nmap <silent> <buffer> <C-^> :TernRefs<CR>
      nmap <silent> <buffer> <C-@> :TernRename<CR>
    endfunction
  endif
  " }}}
endif

" {{{ vim-node
" Usage:
" Use `gf` inside `require('...')` to jump to source and module files
" Use `[I` on any keyword to look for it in the current and required files
" Use `:Nedit module_name` to edit the main file of a module
" Use `:Nedit module_name/lib/foo` to edit its `lib/foo.js` file
" Use `:Nedit .` to edit your Node projects main file
if g:vimx_loading_bundle
  call dein#add('moll/vim-node', { 'on_ft': 'javascript' })
endif
" }}}

" {{{ vim-node-dict
if g:vimx_loading_bundle
  call dein#add('guileen/vim-node-dict',
        \ {
        \   'on_ft': 'javascript',
        \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
        \ })
else
  autocmd User dein#source#vim-node-dict call s:vim_node_dict_on_source()
  function s:vim_node_dict_on_source()
    augroup vimx
      autocmd FileType javascript setlocal dictionary+=$HOME/.vim/bundle/repos/github.com/guileen/vim-node-dict/dict/node.dict
    augroup END
  endfunction
endif
" }}}

" vim:ft=vim fdm=marker et ts=4 sw=2 sts=2
