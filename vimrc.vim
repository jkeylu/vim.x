"
" author: jKey Lu <jkeylu@gmail.com>
"

" Note: Skip initialization for vim-tiny or vim-small
if 0 | endif

if &compatible
  set nocompatible " be iMproved
endif

let mapleader = ','


" {{{ Load env
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

"
" }}} Load env


" {{{ Before
"

if filereadable(expand('~/.vim/before.vim'))
  source ~/.vim/before.vim
endif

"
" }}} Before


" {{{ Bundle and Settings

set runtimepath+=~/.vim/bundle/repos/github.com/Shougo/dein.vim

function! s:SID()
  return matchstr(expand('<sfile>'), '\zs<SNR>\d\+_\zeSID$')
endfunction

" {{{ Bundle

if dein#load_state('~/.vim/bundle')
  " Required:
  call dein#begin(expand('~/.vim/bundle'))

  " The time of timeout seconds when updating/installing plugins
  let g:dein#install_process_timeout = 1500

  " {{{ dein.vim
  " let dein manage dein
  " Required:
  call dein#add('Shougo/dein.vim')
  " }}}

  " {{{ Default Bundle
  call dein#add('morhetz/gruvbox',
        \ {
        \   'hook_source': 'call ' . s:SID() . 'gruvbox_on_source()',
        \})

  call dein#add('yianwillis/vimcdoc')

  call dein#add('Shougo/vimproc.vim', { 'build': 'make' })

  call dein#add('jkeylu/mark2666',
        \ {
        \   'hook_source': 'call ' . s:SID() . 'mark2666_on_source()'
        \ })

  " cd ~/.vim/bundle/YouCompleteMe
  " git submodule update --init --recursive
  "
  " // "C-family"   --clang-completer --system-libclang
  " // "C# support" --omnisharp-completer
  " // "Go"         --gocode-completer
  " // "JavaScript" --tern-complete
  " // "Rust"       --racer-completer
  "
  " ./install.py
  call dein#add('Valloric/YouCompleteMe', { 'build': './install.py' })

  " `<leader>cm` minimal comment
  " `<leader>cl` aligned comment
  " `<leader>cu` uncomments the selected line(s)
  call dein#add('scrooloose/nerdcommenter')

  " `C-l` clear cache
  call dein#add('Shougo/unite.vim',
        \ {
        \   'hook_source': 'call ' . s:SID() . 'unite_vim_on_source()',
        \   'hook_post_source': 'call ' . s:SID() . 'unite_vim_on_post_source()'
        \ })

  " `<leader>nt`
  "
  " in vimfiler:
  " `g?` help
  " `c` copy file
  " `m` move file
  " `d` delete file
  " `r` rename file
  " `K` make directory
  " `N` new file
  " `~` switch to home directory
  " `\` switch to root directory
  " `&` switch to project directory
  " `<BS>` switch to parent directory
  " `.` toggle visible ignore files
  " `v` preview file
  " `gs` toggle safe mode
  call dein#add('Shougo/vimfiler.vim',
        \ {
        \   'hook_source': 'call ' . s:SID() . 'vimfiler_vim_on_source()'
        \ })

  " in fzf
  " {
  "   'ctrl-m': 'e',
  "   'ctrl-t': 'tab split',
  "   'ctrl-x': 'split',
  "   'ctrl-v': 'vsplit'
  " }
  if executable('fzf')
    if !isdirectory('/usr/local/opt/fzf')
      call dein#add('junegunn/fzf',
            \ {
            \   'hook_post_source': 'call ' . s:SID() . 'fzf_on_post_source()'
            \ })
    endif
  endif

  " `<C-n>` next
  " `<C-p>` prev
  " `<C-x>` skip
  " `<Tab>` quit
  call dein#add('terryma/vim-multiple-cursors',
        \ {
        \   'hook_source': 'call ' . s:SID() . 'vim_multiple_cursors_on_source()'
        \ })


  " `<C-d>` scroll down
  " `<C-u>` scroll up
  call dein#add('yonchu/accelerated-smooth-scroll',
        \ {
        \   'hook_source': 'call ' . s:SID() . 'accelerated_smooth_scroll_on_source()'
        \ })

  " `:StripWhitespace`
  call dein#add('ntpeters/vim-better-whitespace',
        \ {
        \   'hook_source': 'call ' . s:SID() . 'vim_better_whitespace_on_source()'
        \ })


  " The default mapping to toggle the plugin is `<leader>ig`
  call dein#add('nathanaelkane/vim-indent-guides',
        \ {
        \   'hook_source': 'call ' . s:SID() . 'vim_indent_guides_on_source()'
        \ })

  " | Action                                     | Shortcut | Command                   |
  " | Add/remove bookmark at current line        | mm       | :BookmarkToggle           |
  " | Add/edit/remove annotation at current line | mi       | :BookmarkAnnotate <TEXT>  |
  " | Jump to next bookmark in buffer            | mn       | :BookmarkNext             |
  " | Jump to previous bookmark in buffer        | mp       | :BookmarkPrev             |
  " | Show all bookmarks (toggle)                | ma       | :BookmarkShowAll          |
  " | Clear bookmarks in current buffer only     | mc       | :BookmarkClear            |
  " | Clear bookmarks in all buffers             | mx       | :BookmarkClearAll         |
  " | Move up bookmark at current line           | mkk      | :BookmarkMoveUp           |
  " | Move down bookmark at current line         | mjj      | :BookmarkMoveDown         |
  " | Save all bookmarks to a file               |          | :BookmarkSave <FILE_PATH> |
  " | Load bookmarks from a file                 |          | :BookmarkLoad <FILE_PATH> |
  call dein#add('MattesGroeger/vim-bookmarks',
        \ {
        \   'hook_source': 'call ' . s:SID() . 'vim_bookmarks_on_source()'
        \ })

  call dein#add('vim-scripts/LargeFile',
        \ {
        \   'hook_source': 'call ' . s:SID() . 'large_file_on_source()'
        \ })

  if executable('ctags')
    " usage: `<leader>tl`
    call dein#add('majutsushi/tagbar',
          \ {
          \   'hook_source': 'call ' . s:SID() . 'tagbar_on_source()'
          \ })
  endif

  if executable('git')
    if has('signs')
      " `]c` jump to next hunk (change)
      " `[c` jump to previous hunk (change)
      " `<leader>hs` stage the hunk
      " `<leader>hr` revert it
      " `<leader>hp` preview a hunk's changes
      call dein#add('airblade/vim-gitgutter')
    endif

    " `:Gsplit`, `:Gvsplit`
    " `:Gdiff`
    " `:Gstatus`. Press `-` to add/reset a file's changes, or `p` to add/reset --patch
    " `:Gcommit`
    " `:Glog`
    call dein#add('tpope/vim-fugitive')

    " `:Merginal`
    " `C/cc` Checkout the branch under the cursor.
    " `A/aa` Create a new branch from the currently checked out branch.
    "        You'll be prompted to enter a name for the new branch
    " `D/dd` Delete the branch under the cursor.
    " `M/mm` Merge the branch under the cursor into the currently checked out
    "        branch. If there are merge conflicts, the merge conflicts buffer will open
    "        in place of the branch list buffer.
    call dein#add('idanarye/vim-merginal')

    " `:Gitv`
    call dein#add('gregsexton/gitv')
  endif

  " No iconv in windows?
  " Download: http://sourceforge.net/projects/gettext
  " Put "iconv.dll" in the same directory as gvim.exe to be able to edit files in many encodings.
  if has('iconv')
    " `:FencView`
    " `:FencAutoDetect`
    " `:FencManualEncoding utf-8`
    call dein#add('mbbill/fencview',
          \ {
          \   'hook_source': 'call ' . s:SID() . 'fencview_on_source()'
          \ })
  endif

  " `;w` word motion
  " `;b`
  " `;e`
  " `;f` looking for right
  " `;F` looking for right
  call dein#add('easymotion/vim-easymotion',
        \ {
        \   'hook_source': 'call ' . s:SID() . 'vim_easymotion_on_source()'
        \ })

  call dein#add('airblade/vim-rooter',
        \ {
        \   'hook_source': 'call ' . s:SID() . 'vim_router_on_source()'
        \ })


  " `<leader>tm` Toggle table mode for the current buffer. You can change this using the |toggle-mode-options-toggle-map| option.
  " `<leader>tt` Triggers |table-mode-commands-tableize| on the visually selected content.
  call dein#add('dhruvasagar/vim-table-mode',
        \ {
        \   'hook_source': 'call ' . s:SID() . 'vim_table_mode_on_source()'
        \ })


  " `=` invoke choosewin mode
  " `s` Swap window
  " `S` Swap window but stay
  call dein#add('t9md/vim-choosewin',
        \ {
        \   'hook_source': 'call ' . s:SID() . 'vim_choosewin_on_source()'
        \ })


  call dein#add('itchyny/lightline.vim')

  " `<S-Tab>`
  " `<C-G>g`
  call dein#add('Raimondi/delimitMate')
  " }}} Default Bundle

  " {{{ JavaScript Bundle
  if g:vimx#env.exists('javascript')

    call dein#add('hail2u/vim-css3-syntax', { 'on_ft': [ 'css', 'less', 'stylus' ] })

    call dein#add('groenewege/vim-less', { 'on_ft': [ 'less' ] })

    call dein#add('wavded/vim-stylus', { 'on_ft': [ 'stylus' ] })

    " Use `gf` inside `require('...')` to jump to source and module files
    " Use `[I` on any keyword to look for it in the current and required files
    " Use `:Nedit module_name` to edit the main file of a module
    " Use `:Nedit module_name/lib/foo` to edit its `lib/foo.js` file
    " Use `:Nedit .` to edit your Node projects main file
    call dein#add('moll/vim-node')

    call dein#add('guileen/vim-node-dict',
          \ {
          \   'on_ft': [ 'javascript' ],
          \   'hook_source': 'call ' . s:SID() . 'vim_node_dict_on_source()'
          \ })

    call dein#add('pangloss/vim-javascript',
          \ {
          \   'on_ft': [ 'javascript' ],
          \   'hook_source': 'call ' . s:SID() . 'vim_javascript_on_source()'
          \ })


    " `TernDef` Jump to the definition of the thing under the cursor.
    " `TernDoc` Look up the documentation of something.
    " `TernType` Find the type of the thing under the cursor.
    " `TernRefs` Show all references to the variable or property under the cursor.
    " `TernRename` Rename the variable under the cursor.
    call dein#add('ternjs/tern_for_vim',
          \ {
          \   'build': 'npm install',
          \   'on_ft': [ 'javascript' ],
          \   'hook_source': 'call ' . s:SID() . 'tern_for_vim_on_source()'
          \ })

  endif
  " }}} JavaScript Bundle

  " {{{ TypeScript Bundle
  if g:vimx#env.exists('typescript')
    " `:make`
    call dein#add('leafgarland/typescript-vim', { 'on_ft': [ 'typescript' ] })

    " `<C-]>` Nav to definition
    " `<C-t>` Move the cursor to the location where the last `<C-]>` was typed
    " `<C-^>` Show references
    " `<C-@>` Rename symbols
    call dein#add('Quramy/tsuquyomi',
          \ {
          \   'hook_source': 'call ' . s:SID() . 'tsuquyomi_on_source()'
          \ })

  endif
  " }}} TypeScript Bundle

  " {{{ Go Bundle
  if g:vimx#env.exists('typescript')
    " `C-]` = `:GoDef`
    " `C-t` = `:GoDefPop`
    call dein#add('fatih/vim-go',
          \ {
          \   'hook_source': 'call ' . s:SID() . 'vim_go_on_source()'
          \ })

  endif
  " }}} Go Bundle

  " {{{ Python Bundle
  if g:vimx#env.exists('python')
    call dein#add('hynek/vim-python-pep8-indent', { 'on_ft': [ 'python' ] })

  endif
  " }}} Python Bundle

  " {{{ C Bundle
  if g:vimx#env.exists('c')
    " `:A`
    call dein#add('vim-scripts/a.vim', { 'on_ft': [ 'c', 'cpp' ] })

  endif
  " }}} C Bundle

  " {{{ IDE Bundle
  if g:vimx#env.exists('ide')
    " `:SLoad`
    " `:SSave`
    " `:SDelete`
    " `Startify`
    call dein#add('mhinz/vim-startify')

  endif
  " }}} IDE Bundle

  " {{{ Game Bundle
  call dein#add('vim-scripts/TeTrIs.vim')
  " }}} Game Bundle

  call dein#end()
  call dein#save_state()
end

" }}}

" {{{ Settings

" {{{ Default Bundle Settings

" {{{ gruvbox
function s:gruvbox_on_source()
  if &t_Co <= 16
    let g:gruvbox_termcolors = 16
  endif

  let g:gruvbox_contrast_dark = 'hard'
  let g:gruvbox_contrast_light = 'hard'

  silent! colorscheme gruvbox
endfunction
" }}}

" {{{ mark2666
function s:mark2666_on_source()
  if has('gui_running')
    let g:mwDefaultHighlightingPalette = 'extended'
    let g:mwDefaultHighlightingNum = 18
  endif
endfunction
" }}}

" {{{ unite.vim
function s:unite_vim_on_source()
  let g:unite_source_grep_max_candidates = 200

  if executable('ag')
    let g:unite_source_rec_async_command =
          \ ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']

    " Use ag in unite grep source.
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts =
          \ '-i --vimgrep --literal --hidden ' .
          \ '--ignore ''.hg'' ' .
          \ '--ignore ''.svn'' ' .
          \ '--ignore ''.git'' ' .
          \ '--ignore ''.bzr'''
    let g:unite_source_grep_recursive_opt = ''
  endif

  " just like bufexplorer
  nmap <silent> <leader><leader> :<C-u>Unite buffer bookmark<CR>

  " just like ctrlp.vim
  if !executable('fzf')
    nnoremap <silent> <C-f> :<C-u>UniteWithProjectDir -start-insert file_rec/async<CR>
  endif

  " just like ctrlf.vim
  nmap <silent> <S-f> :Unite -no-quit grep<CR>

  augroup vimx
    autocmd Filetype unite call s:unite_settings()
  augroup END
endfunction

function! s:unite_settings()
  imap <buffer> jj <Plug>(unite_insert_leave)
  imap <buffer> kk <Plug>(unite_insert_leave)

  imap <buffer> <Esc> <Plug>(unite_exit)
  nmap <buffer> <Esc> <Plug>(unite_exit)

  imap <buffer> <Tab> <Plug>(unite_select_next_line)
  imap <buffer> ' <Plug>(unite_quick_match_default_action)
  nmap <buffer> ' <Plug>(unite_quick_match_default_action)

  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)

  nmap <buffer> / <Plug>(unite_append_end)
endfunction

function s:unite_vim_on_post_source()
  call unite#custom#profile('default', 'context',
        \ {
        \   'start_insert': 0,
        \   'winheight': 10,
        \   'prompt': '> ',
        \   'direction': 'botright'
        \ })

  call unite#custom#source('file_rec/async', 'ignore_pattern',
        \ join([
        \   '\.git/',
        \   'node_modules/',
        \   'bower_components/'
        \ ], '\|'))

  call unite#custom#source('file_rec/async', 'matchers',
        \ [
        \   'matcher_context',
        \   'matcher_hide_current_file'
        \ ])

  call unite#custom#source('file_rec/async', 'sorters',
        \ [
        \   'sorter_length'
        \ ])
endfunction
" }}}

" {{{ vimfiler.vim
function s:vimfiler_vim_on_source()
  let g:vimfiler_as_default_explorer = 1
  nmap <silent> <leader>nt :VimFiler -explorer -parent -status -auto-cd -auto-expand -find -force-quit<CR>
endfunction
" }}}

" {{{ fzf
function s:fzf_on_post_source()
  " use fzf instead of unite
  nnoremap <silent> <C-f> :FZF<CR>
endfunction

if isdirectory('/usr/local/opt/fzf')
  set rtp+=/usr/local/opt/fzf
  call s:fzf_on_post_source()
endif
" }}}

" {{{ vim-multiple-cursors
function s:vim_multiple_cursors_on_source()
  let g:multi_cursor_quit_key = '<Tab>'
endfunction
" }}}

" {{{ accelerated-smooth-scrool
function s:accelerated_smooth_scroll_on_source()
  let g:ac_smooth_scroll_no_default_key_mappings = 1

  nmap <silent> <C-d> <Plug>(ac-smooth-scroll-c-d)
  nmap <silent> <C-u> <Plug>(ac-smooth-scroll-c-u)
  nmap <silent> <S-d> <Plug>(ac-smooth-scroll-c-f)
  nmap <silent> <S-u> <Plug>(ac-smooth-scroll-c-b)
endfunction
" }}}

" {{{ vim-better-whitespace
function s:vim_better_whitespace_on_source()
  let g:better_whitespace_filetypes_blacklist = ['diff', 'gitcommit', 'unite', 'qf', 'help', 'vimfiler']
endfunction
" }}}

" {{{ vim-indent-guides
function s:vim_indent_guides_on_source()
  let g:indent_guides_guide_size = 1
  let g:indent_guides_start_level = 2
endfunction
" }}}

" {{{ vim-bookmarks
function s:vim_bookmarks_on_source()
  let g:bookmark_auto_save_file = $HOME.'/.cache/vim-bookmarks'
endfunction
" }}}

" {{{ LargeFile
function s:large_file_on_source()
  let g:LargeFile = 100
endfunction
" }}}

" {{{ tagbar
function s:tagbar_on_source()
  let g:tagbar_width = 40
  let g:tagbar_autoclose = 1
  let g:tagbar_autofocus = 1
  let g:tagbar_show_linenumbers = 2
  nnoremap <leader>tl :TagbarToggle<CR>
endfunction
" }}}

" {{{ fencview
function s:fencview_on_source()
  "let g:fencview_autodetect = 1
  "let g:fencview_auto_patterns = '*.cnx,*.txt,*.html,*.php,*.cpp,*.h,*.c,*.css,*.js,*.ts,*.py,*.sh,*.java{|\=}'
  "let g:fencview_checklines = 10
endfunction
" }}}

" {{{ vim-easymotion
function s:vim_easymotion_on_source()
  let g:EasyMotion_smartcase = 1
  map ; <Plug>(easymotion-prefix)
  map / <Plug>(easymotion-sn)
  omap / <Plug>(easymotion-tn)
  map n <Plug>(easymotion-next)
  map N <Plug>(easymotion-prev)
endfunction
" }}}

" {{{ vim-router
function s:vim_router_on_source()
  let g:rooter_use_lcd = 1
  let g:rooter_change_directory_for_non_project_files = 1
  let g:rooter_silent_chdir = 1
endfunction
" }}}

" {{{ vim-table-mode
function s:vim_table_mode_on_source()
  let g:table_mode_auto_align = 0

  " Markdown-compatible
  let g:table_mode_corner = '|'

  " ReST-compatible
  " let g:table_mode_corner = '+'
  " let g:table_mode_header_fillchar = '='
endfunction
" }}}

" {{{ vim_choosewin
function s:vim_choosewin_on_source()
  let g:choosewin_overlay_enable = 1

  nmap = <Plug>(choosewin)
endfunction
" }}}

" {{{ delimitMate
function s:delimit_mate_on_source()
  let delimitMate_expand_cr = 1
  let delimitMate_expand_space = 1
endfunction
" }}}

" }}} Default Bundle Settings

" {{{ JavaScript Bundle Settings

" {{{ vim-node-dict
function s:vim_node_dict_on_source()
  augroup vimx
    autocmd FileType javascript set dictionary+=$HOME/.vim/bundle/repos/github.com/guileen/vim-node-dict/dict/node.dict
  augroup END
endfunction
" }}}

" {{{ vim-javascript
function s:vim_javascript_on_source()
  let g:html_indent_inctags = 'html,body,head,tbody'
  let g:html_indent_script1 = 'inc'
  let g:html_indent_style1 = 'inc'
endfunction
" }}}

" {{{ tern_for_vim
function s:tern_for_vim_on_source()
  augroup vimx
    autocmd FileType javascript call s:tern_settings()
  augroup END
endfunction

function! s:tern_settings()
  nmap <silent> <buffer> <C-]> :TernDef<CR>
  nmap <silent> <buffer> <C-^> :TernRefs<CR>
  nmap <silent> <buffer> <C-@> :TernRename<CR>
endfunction
" }}}

" }}} JavaScript Bundle Settings

" {{{ TypeScript Bundle Settings

" {{{ tsuquyomi
function s:tsuquyomi_on_source()
  augroup vimx
    autocmd FileType typescript nmap <silent> <buffer> <C-@> <Plug>(TsuquyomiRenameSymbol)
  augroup END
endfunction
" }}}

" }}} TypeScript Bundle Settings

" {{{ Go Bundle Settings

" {{{ vim-go
function s:vim_go_on_source()
  augroup vimx
    autocmd FileType go call s:go_settings()
  augroup END
endfunction

function! s:go_settings()
  nmap <silent> <buffer> <C-^> :GoReferrers<CR>
  nmap <silent> <buffer> <C-@> :GoRename<CR>
endfunction
" }}}

" }}} Go Bundle Settings

" {{{ IDE Bundle Settings

" {{{ vim-startify
function s:vim_startify_on_source()
  let g:startify_session_dir = '~/.cache/vimsession'
  let g:startify_session_persistence = 1
endfunction
" }}}

" }}} IDE Bundle Settings

" }}} Settings

call dein#call_hook('source')

if v:vim_did_enter
  call dein#call_hook('post_source')
else
  autocmd VimEnter * call dein#call_hook('post_source')
endif

filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
if dein#check_install()
  call dein#install()
endif

"
" }}}


" {{{ Basic Settings
"

VimxLoadSet background dark
syntax on

set clipboard+=unnamed

if has('mouse')
  set mouse=a
endif

set number
set scrolloff=4
set history=100
set nobackup
set showcmd
set backspace=indent,eol,start
set foldmethod=marker
set wildmenu

" Highlight cursor line
set cursorline
hi cursorline guibg=#112233

" Status line
set laststatus=2
set statusline=\ %f%m%r%h%w\ \[%{&fileformat}\\%{&fileencoding}\]\ %=\ Line:%l/%L:%c

" Ruler
if exists('+colorcolumn')
  set colorcolumn=80
else
  autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Read first line or last line to exec modeline
set modelines=1

" Show line break
set wrap
set nolist
set linebreak
let &showbreak = '↳ '

" auto open quickfix
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost l* nested lwindow

" search
set hlsearch
set incsearch
set ignorecase smartcase

"  Indent
set autoindent
set smartindent
set copyindent
set cindent

" tab style
set expandtab
set tabstop=4
set shiftwidth=2
set softtabstop=2

augroup vimx
  autocmd FileType markdown set shiftwidth=4 softtabstop=4
  autocmd FileType python set shiftwidth=4 softtabstop=4
  autocmd FileType typescript set shiftwidth=4 softtabstop=4
  autocmd FileType go set noexpandtab shiftwidth=4 softtabstop=4
augroup END

" auto set file type
augroup vimx
  autocmd BufNewFile,BufRead *.md set filetype=markdown
  autocmd BufNewFile,BufRead *.coffee set filetype=coffee
  autocmd BufNewFile,BufRead *.ts set filetype=typescript
  autocmd BufNewFile,BufRead *.styl set filetype=stylus
  autocmd BufNewFile,BufRead *.rs set filetype=rust
augroup END

" file encodings and formats
set encoding=utf-8
set fileencodings=utf-8,gbk,gb2312,cp936
set fileformats=unix,dos

" remember the position of the last time view
augroup vimx
  autocmd FileType text setlocal textwidth=78
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \	exe "normal! g`\"" |
        \ endif
augroup END


" gui
if has('gui_running')
  set lines=30
  set columns=100

  " hide Toolbar and Menu bar
  set guioptions-=T
  set guioptions-=m
  " <F4> Toggle show and hide
  map <silent> <leader>tt
        \ :if &guioptions=~# 'T' <Bar>
        \   set guioptions-=T <Bar>
        \   set guioptions-=m <Bar>
        \ else <Bar>
        \   set guioptions+=T <Bar>
        \   set guioptions+=m <Bar>
        \ endif<CR>
endif

"
" }}}


" {{{ Extra Settings
"

" when pasting copy pasted text back to
" buffer instaed replacing with override
xnoremap p pgvy

" [Avoid the escape key](http://vim.wikia.com/wiki/Avoid_the_escape_key)
imap jj <Esc>`^
nnoremap <Tab> <Esc>
vnoremap <Tab> <Esc>
onoremap <Tab> <Esc>

nnoremap <silent> <leader>q :q<CR>

" toggle wrap or nowrap
nmap <silent> <leader>w @=((&wrap == 1) ? ':set nowrap' : ':set wrap')<CR><CR>

" save read-only file
if executable('sudo')
  cmap w!! %!sudo tee > /dev/null %
endif

" toggle fold
nnoremap <silent> <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

inoremap <expr> <C-j> pumvisible() ? '<C-n>' : '<C-x><C-o>'
inoremap <expr> <C-k> pumvisible() ? '<C-p>' : '<C-k>'

vnoremap $ $h

augroup vimx
  autocmd FileType help nmap <silent> <buffer> q :q<CR>
  autocmd FileType qf nmap <silent> <buffer> q :q<CR>
augroup END

"
" }}}


" {{{ After
"

if filereadable(expand('~/.vim/after.vim'))
  source ~/.vim/after.vim
endif

"
" }}}


" vim:ft=vim fdm=marker et ts=4 sw=2 sts=2
