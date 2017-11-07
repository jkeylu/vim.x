"
" author: jKey Lu <jkeylu@gmail.com>
"

" {{{ Check platform
let g:vimx#platform = {}
function! g:vimx#platform.isUnix()
  return has('unix')
endfunction

function! g:vimx#platform.isMswin()
  return has('win16') || has('win32') || has('win64')
endfunction

function! g:vimx#platform.isCygwin()
  return has('win32unix')
endfunction

function! g:vimx#platform.isOSX()
  return !vimx#platform#isMswin() && (has('mac') || has('macunix') || has('gui_macvim') || system('uname') =~? '^darwin')
endfunction
" }}}

" {{{
let s:configFilePath = expand('~/.cache/vimx')
let s:config =
      \ {
      \   'env': { 'names': [] },
      \   'set': {}
      \ }
function! s:loadConfig()
  if filereadable(s:configFilePath)
    try
      exe 'source ' . s:configFilePath
      let s:config = deepcopy(g:vimx#config)
    finally
      unlet! g:vimx#config
    endtry
  endif
endfunction

function! s:saveConfig()
  exe 'redir! > ' . s:configFilePath
  silent echo s:config
  redir END

  let l:configContent = readfile(s:configFilePath)
  let l:configContent[1] = 'let g:vimx#config = ' . l:configContent[1]
  call writefile(l:configContent, s:configFilePath)
endfunction

call s:loadConfig()
command! -nargs=0 VimxSaveConfig call s:saveConfig()
" }}}

" {{{
let g:vimx#env = {}

function! g:vimx#env.exists(name) dict
  return index(s:config.env.names, a:name) >= 0
endfunction

function! g:vimx#env.add(...) dict
  if a:0 == 0
    echo 'Nothing to be added'
    return
  endif

  for l:name in a:000
    if !self.exists(name)
      call add(s:config.env.names, l:name)
    endif
  endfor

  echo string(a:0) . ' item(s) been added'
endfunction

function! g:vimx#env.remove(...) dict
  if a:0 == 0
    echo 'Nothing to be removed'
    return
  endif

  for l:name in a:000
    let l:idx = index(s:config.env.names, l:name)
    if l:idx >= 0
      call remove(s:config.env.names, l:idx)
    endif
  endfor

  echo string(a:0) . ' item(s) been removed'
endfunction

function! g:vimx#env.list() dict
  return s:config.env.names
endfunction

command! -nargs=* -complete=filetype VimxEnvAdd call g:vimx#env.add(<f-args>) | call s:saveConfig()
command! -nargs=* -complete=filetype VimxEnvRemove call g:vimx#env.remove(<f-args>) | call s:saveConfig()
command! -nargs=1 -complete=filetype VimxEnvExists echo g:vimx#env.exists(<f-args>) ? 'Exists' : 'Not Exists'
command! -nargs=0 VimxEnvList echo g:vimx#env.list()
" }}}

" {{{
let g:vimx#set = {}

function! g:vimx#set.load(name, ...)
  let l:expr = 'set '

  if a:0 == 0
    " set {option}
    " set no{option}
    let l:option = a:name

    if strpart(a:name, 0, 2) == 'no'
      let l:option = strpart(a:name, 2, strlen(a:name) - 2)
    endif

    if has_key(s:config.set, l:option)
      let l:expr .= (s:config.set[l:option] ? '' : 'no') . l:option
    else
      let l:expr .= a:name
    endif

  else
    " set {option}={value}
    let expr .= a:name . '='

    if has_key(s:config.set, a:name)
      let expr .= s:config.set[a:name]
    else
      let expr .= a:1
    endif
  endif

  exe expr
endfunction

function! g:vimx#set.save(name, ...)
  let l:option = a:name
  let l:value = a:0 == 0 ? 1 : a:1

  if a:0 == 0
    if strpart(a:name, 0, 2) == 'no'
      l:option = strpart(a:name, 2, strlen(a:name) - 2)
      l:value = 0
    endif
  endif

  let s:config.set[l:option] = l:value
endfunction

command! -nargs=+ VimxLoadSet call g:vimx#set.load(<f-args>)
command! -nargs=+ VimxSet call g:vimx#set.save(<f-args>) | call s:saveConfig()
" }}}

" {{{
let g:vimx#command = {}

function! g:vimx#command.load(name, ...)
  if a:name == 'set' || a:name == 'let'
    return
  endif
endfunction

function! g:vimx#command.save(name, ...)
  if a:name == 'set' || a:name == 'let'
    return
  endif
endfunction
" }}}

" vim:ft=vim fdm=marker et ts=4 sw=2 sts=2
