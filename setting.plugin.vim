"
" author: jKey Lu <jkeylu@gmail.com>
"

" FencView.vim {{{1
"

let g:fencview_autodetect = 1
let g:fencview_auto_patterns = '*.cnx,*.txt,*.html,*.php,*.cpp,*.h,*.c,*.css,*.java{|\=}'
let g:fencview_checklines = 10



" LargeFile.vim {{{1
"

let g:LargeFile = 100



" mark.vim {{{1
"

if has('gui_running')
  let g:mwDefaultHighlightingPalette = 'extended'
  let g:mwDefaultHighlightingNum = 18
endif



" neocomplcache.vim {{{1
"

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 4
let g:neocomplcache_manual_completion_start_length = 4
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1



" nerdtree.vim {{{1
"

let NERDTreeChDirMode = 2
let NERDTreeWinSize = 25
let NERDTreeQuitOnOpen = 1
let NERDTreeShowLineNumbers = 1
let NERDTreeDirArrows = 0



" tagbar {{{1
"

if executable('ctags')
  let g:tagbar_width = 40
  let g:tagbar_autoclose = 1
  let g:tagbar_autofocus = 1
  let g:tagbar_show_linenumbers = 2
endif



" vim-indent-guides.vim {{{1
"

let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2



" vim-javascript.vim {{{1
"

let g:html_indent_inctags = 'html,body,head,tbody'
let g:html_indent_script1 = 'inc'
let g:html_indent_style1 = 'inc'



" vim-node.vim {{{1
"

if has('autocmd')
  autocmd FileType javascript set dictionary+=$HOME/.vim/bundle/vim-node/dict/node.dict
endif



" CtrlP {{{1
"

let g:ctrlp_extensions = ['funky']



" vim-startify {{{1
"

let g:startify_session_dir = '~/.vim-sessions'
let g:startify_list_order = ['files', 'bookmarks', 'sessions']
let g:startify_session_persistence = 1
