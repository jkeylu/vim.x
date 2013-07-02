"
" author: jKey Lu <jkeylu@gmail.com>
"

" ctags
function! s:generate_ctags()
  if executable('ctags')
    silent! execute '!ctags -R --c++-kinds=+px --fields=+iaS --extra=+q .'
  endif

  if filereadable('tags')
    execute 'set tags=tags;'
  endif
endfunction
set tags=tags;


" cscope
function! s:generate_cscope()
  if(has('cscope') && executable('cscope'))
    if(!g:vimx#platform.is_mswin)
      silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
    else
      silent! execute '!dir /b /s *.c,*.cpp,*.h,*.java,*.cs >> cscope.files'
    endif

    silent! execute '!cscope -b'

    if filereadable('cscope.out')
      silent! execute 'cs add cscope.out'
    endif
  endif
endfunction

if has('cscope')
  set cscopequickfix=s-,c-,d-,i-,t-,e-
  set csto=0
  set cst
  set csverb

  if filereadable('cscope.out')
    silent! execute 'cs add cscope.out'
  endif
endif


" convert file
function! s:convert_file_to_unix_utf8()
  set fileformat=unix
  set fileencoding=utf-8
endfunction
