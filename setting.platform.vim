"
" author: jKey Lu <jkeylu@gmail.com>
"

let s:platform = {}
let g:vimx#platform = s:platform


function! s:platform.check()
  let self.is_unixs = has('unix')
  let self.is_mswin = has('win16') || has('win32') || has('win64')
  let self.is_cygwin = has('win32unix')
  let self.is_macunix = !self.is_mswin && (has('mac') || has('macunix') || has('gui_macvim') || system('uname') =~? '^darwin')
endfunction

call s:platform.check()