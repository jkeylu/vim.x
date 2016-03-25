"
" author: jKey Lu <jkeylu@gmail.com>
"

if has('vim_starting')
  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" To increase the Neobundle timeout to 1500 seconds
let g:neobundle#install_process_timeout = 1500

" {{{ neobundle.vim
" let NeoBundle manage NeoBundle
" Usage:
" `:NeoBundleUpdate`
" `:Unite neobundle/update`
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
" }}}

" {{{ gruvbox
NeoBundle 'morhetz/gruvbox'

if &t_Co <= 16
  let g:gruvbox_termcolors = 16
endif

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'

if neobundle#tap('gruvbox')

  function! neobundle#hooks.on_source(bundle)
    silent! colorscheme gruvbox
  endfunction

  call neobundle#untap()
endif
" }}}

" {{{ vimcdoc
NeoBundle 'jkeylu/vimcdoc'
" }}}

" {{{ vimproc.vim
NeoBundle 'Shougo/vimproc.vim',
      \ {
      \   'build': {
      \     'windows': '"C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Tools\VsDevCmd.bat" && nmake -f make_msvc.mak nodebug=1 "SDK_INCLUDE_DIR=C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Include"',
      \     'cygwin': 'make -f make_cygwin.mak',
      \     'mac': 'make -f make_mac.mak',
      \     'linux': 'make',
      \     'unix': 'gmake'
      \   }
      \ }
" }}}

" {{{ mark2666
NeoBundle 'jkeylu/mark2666'

if has('gui_running')
  let g:mwDefaultHighlightingPalette = 'extended'
  let g:mwDefaultHighlightingNum = 18
endif
" }}}

if v:version >= 703 && has('python')
      \ && !(g:vimx#platform.isMswin() || g:vimx#platform.isCygwin())
      \ || g:vimx#env.exists('ycm')
  " {{{ YouCompleteMe
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
  NeoBundle 'Valloric/YouCompleteMe',
        \ {
        \   'build': {
        \     'mac': './install.py',
        \     'unix': './install.py',
        \     'windows': 'install.py',
        \     'cygwin': './install.py'
        \   }
        \ }

  "augroup vimx
  "  autocmd FileType javascript nmap <silent> <buffer> <C-^> :YcmCompleter GoToReferences<CR>
  "  autocmd FileType javascript,typescript,go,c,cpp nmap <silent> <buffer> <C-]> :YcmCompleter GoTo<CR>
  "augroup END
  " }}}
else
  " {{{ supertab
  " Note: Default tab literal is mapped by `<C-t>`
  NeoBundle 'ervandew/supertab'

  let g:SuperTabDefaultCompletionType = 'context'
  let g:SuperTabMappingTabLiteral='<C-t>'

  augroup vimx
    autocmd FileType typescript
          \ let b:SuperTabCompletionContexts
          \   = [ 's:typescriptContext' ] + g:SuperTabCompletionContexts |
          \ let b:SuperTabContextTextMemberPatterns = [ '\.' ]
  augroup END

  function! s:typescriptContext()
    return "\<C-x>\<C-o>"
  endfunction
  " }}}

  " {{{ neocomplete | neocomplcache
  if has('lua')
    " for windows [download Lua](http://lua-users.org/wiki/LuaBinaries) and put
    " the lua52.dll file in the same directory as gvim.exe
    " for Mac OSX `brew install vim --with-lua`
    NeoBundle 'Shougo/neocomplete.vim'

    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#auto_completion_start_length = 4
    let g:neocomplete#manual_completion_start_length = 4
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_camel_case = 1
  else
    NeoBundle 'Shougo/neocomplcache.vim'

    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_auto_completion_start_length = 4
    let g:neocomplcache_manual_completion_start_length = 4
    let g:neocomplcache_enable_smart_case = 1
    let g:neocomplcache_enable_camel_case_completion = 1
    let g:neocomplcache_enable_underbar_completion = 1
  endif
  " }}}
endif

" {{{ nerdcommenter
" Usage:
" `<leader>cm` minimal comment
" `<leader>cl` aligned comment
" `<leader>cu` uncomments the selected line(s)
NeoBundle 'scrooloose/nerdcommenter'
" }}}

" {{{ unite.vim
" Usage:
" `C-l` clear cache
NeoBundle 'Shougo/unite.vim'

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
nnoremap <silent> <C-f> :<C-u>UniteWithProjectDir -start-insert file_rec/async<CR>

" just like ctrlf.vim
nmap <silent> <S-f> :Unite -no-quit grep<CR>

augroup vimx
  autocmd Filetype unite call s:uniteSettings()
augroup END

function! s:uniteSettings()
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

if neobundle#tap('unite.vim')
  function! neobundle#hooks.on_source(bundle)
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

  call neobundle#untap()
endif
" }}}

" {{{ vimfiler.vim
" Usage:
" `<leader>nt`
" in vimfiler `&` switch to project directory
"NeoBundle 'Shougo/vimfiler.vim'
NeoBundleLazy 'Shougo/vimfiler.vim',
      \ {
      \   'depends': 'Shougo/unite.vim',
      \   'autoload': {
      \     'commands': [
      \       {
      \         'name': 'VimFiler',
      \         'complete': 'customlist,vimfiler#complete'
      \       },
      \       'VimFilerExplorer',
      \       'Edit',
      \       'Read',
      \       'Source',
      \       'Write'
      \     ],
      \     'mappings': '<Plug>',
      \     'explorer': 1
      \   }
      \ }

nmap <silent> <leader>nt :VimFiler -explorer -parent -status -auto-cd -auto-expand -find -force-quit<CR>
" }}}

" {{{ fzf
if executable('fzf')
  if isdirectory('/usr/local/opt/fzf')
    set rtp+=/usr/local/opt/fzf
  else
    NeoBundle 'junegunn/fzf'
  endif

  " use fzf instead of unite
  nnoremap <silent> <C-f> :FZF<CR>
endif
" }}}

" {{{ vim-multiple-cursors
" Usage:
" `<C-n>` next
" `<C-p>` prev
" `<C-x>` skip
" `<Tab>` quit
NeoBundle 'terryma/vim-multiple-cursors'

let g:multi_cursor_quit_key = '<Tab>'
" }}}

" {{{ accelerated-smooth-scroll
" Usage:
" `<C-d>` scroll down
" `<C-u>` scroll up
NeoBundle 'yonchu/accelerated-smooth-scroll'

let g:ac_smooth_scroll_no_default_key_mappings = 1

nmap <silent> <C-d> <Plug>(ac-smooth-scroll-c-d)
nmap <silent> <C-u> <Plug>(ac-smooth-scroll-c-u)
nmap <silent> <S-d> <Plug>(ac-smooth-scroll-c-f)
nmap <silent> <S-u> <Plug>(ac-smooth-scroll-c-b)
" }}}

" {{{ vim-better-whitespace
" Usage: `:StripWhitespace`
NeoBundle 'ntpeters/vim-better-whitespace'

let g:better_whitespace_filetypes_blacklist = ['diff', 'gitcommit', 'unite', 'qf', 'help', 'vimfiler']
" }}}

if v:version > 702
  " {{{ vim-indent-guides
  " Usage: The default mapping to toggle the plugin is `<leader>ig`
  NeoBundle 'nathanaelkane/vim-indent-guides'

  let g:indent_guides_guide_size = 1
  let g:indent_guides_start_level = 2
  " }}}
endif

" {{{ snippet
if g:vimx#env.exists('snippet')
  NeoBundle 'garbas/vim-snipmate',
        \ {
        \   'depends': [
        \     'MarcWeber/vim-addon-mw-utils',
        \     'tomtom/tlib_vim'
        \   ]
        \ }

  NeoBundle 'honza/vim-snippets'
endif
" }}}

" {{{ vim-bookmarks
" Usage:
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
NeoBundle 'MattesGroeger/vim-bookmarks'

let g:bookmark_auto_save_file = $HOME.'/.cache/vim-bookmarks'
" }}}

" {{{ DoxygenToolkit.vim
NeoBundle 'vim-scripts/DoxygenToolkit.vim'
" }}}

" {{{ LargeFile
NeoBundle 'vim-scripts/LargeFile'

let g:LargeFile = 100
" }}}

if executable('ctags')
  " {{{ tagbar
  " Usage: `<leader>tl`
  NeoBundle 'majutsushi/tagbar'

  let g:tagbar_width = 40
  let g:tagbar_autoclose = 1
  let g:tagbar_autofocus = 1
  let g:tagbar_show_linenumbers = 2
  nnoremap <leader>tl :TagbarToggle<CR>
  " }}}
endif

if executable('git')
  if has('signs')
    " {{{ vim-gitgutter
    " Usage:
    " `]c` jump to next hunk (change)
    " `[c` jump to previous hunk (change)
    " `<leader>hs` stage the hunk
    " `<leader>hr` revert it
    " `<leader>hp` preview a hunk's changes
    NeoBundle 'airblade/vim-gitgutter'
    " }}}
  endif

  " {{{ vim-fugitive
  " Usage:
  " `:Gsplit`, `:Gvsplit`
  " `:Gdiff`
  " `:Gstatus`. Press `-` to add/reset a file's changes, or `p` to add/reset --patch
  " `:Gcommit`
  " `:Glog`
  NeoBundle 'tpope/vim-fugitive'
  " }}}

  " {{{ gitv
  " Usage:
  " `:Gitv`
  NeoBundle 'gregsexton/gitv'
  " }}}
endif

" No iconv in windows?
" Download: http://sourceforge.net/projects/gettext
" Put "iconv.dll" in the same directory as gvim.exe to be able to edit files in many encodings.
if has('iconv')
  " {{{ fencview
  " Usage:
  " `:FencView`
  " `:FencAutoDetect`
  " `:FencManualEncoding utf-8`
  NeoBundle 'mbbill/fencview'

  "let g:fencview_autodetect = 1
  "let g:fencview_auto_patterns = '*.cnx,*.txt,*.html,*.php,*.cpp,*.h,*.c,*.css,*.js,*.ts,*.py,*.sh,*.java{|\=}'
  "let g:fencview_checklines = 10
  " }}}
endif

if g:vimx#env.exists('ide')
  " {{{ vim-startify
  " Usage:
  " `:SLoad`
  " `:SSave`
  " `:SDelete`
  " `Startify`
  NeoBundle 'mhinz/vim-startify'

  let g:startify_session_dir = '~/.cache/vimsession'
  let g:startify_session_persistence = 1
  " }}}
endif

" {{{ vim-easymotion
" Usage:
" `;w` word motion
" `;b`
" `;e`
" `;f` looking for
NeoBundle 'easymotion/vim-easymotion'

let g:EasyMotion_smartcase = 1
map ; <Plug>(easymotion-prefix)
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)
" }}}

" {{{ vim-rooter
NeoBundle 'airblade/vim-rooter'

let g:rooter_use_lcd = 1
let g:rooter_change_directory_for_non_project_files = 1
let g:rooter_silent_chdir = 1
" }}}

" {{{ Language specific

" {{{ syntastic
" Syntax checking hacks for vim
if g:vimx#env.exists('syntastic')
  NeoBundle 'scrooloose/syntastic'

  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
endif
" }}}

" {{{ emmet-vim
" Usage: `<C-y>,`
NeoBundleLazy 'mattn/emmet-vim', { 'autoload': { 'filetypes': [ 'html', 'css' ] } }
" }}}

if g:vimx#env.exists('javascript')
  " {{{ vim-css3-syntax
  NeoBundle 'hail2u/vim-css3-syntax', { 'autoload': { 'filetype': [ 'css', 'less', 'stylus' ] } }
  " }}}

  " {{{ vim-less
  NeoBundleLazy 'groenewege/vim-less', { 'autoload': { 'filetype': [ 'less' ] } }
  " }}}

  " {{{ vim-stylus
  NeoBundleLazy 'wavded/vim-stylus', { 'autoload': { 'filetypes': [ 'stylus' ] } }
  " }}}

  " {{{ vim-node
  " Usage:
  " Use `gf` inside `require('...')` to jump to source and module files
  " Use `[I` on any keyword to look for it in the current and required files
  " Use `:Nedit module_name` to edit the main file of a module
  " Use `:Nedit module_name/lib/foo` to edit its `lib/foo.js` file
  " Use `:Nedit .` to edit your Node projects main file
  NeoBundle 'moll/vim-node'
  " }}}

  " {{{ vim-node-dict
  NeoBundleLazy 'guileen/vim-node-dict', { 'autoload': { 'filetypes': [ 'javascript' ] } }

  augroup vimx
    autocmd FileType javascript set dictionary+=$HOME/.vim/bundle/vim-node-dict/dict/node.dict
  augroup END
  " }}}

  " {{{ vim-javascript
  NeoBundleLazy 'pangloss/vim-javascript', { 'autoload': { 'filetypes': [ 'javascript' ] } }

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
  NeoBundle 'marijnh/tern_for_vim'

  augroup vimx
    autocmd FileType javascript call s:ternSettings()
  augroup END

  function! s:ternSettings()
    nmap <silent> <buffer> <C-]> :TernDef<CR>
    nmap <silent> <buffer> <C-^> :TernRefs<CR>
    nmap <silent> <buffer> <C-@> :TernRename<CR>
  endfunction
  " }}}
endif

if g:vimx#env.exists('python')
  " {{{ vim-python-pep8-indent
  NeoBundleLazy 'hynek/vim-python-pep8-indent', { 'autoload': { 'filetypes': [ 'python' ] } }
  " }}}
endif

if g:vimx#env.exists('coffee')
  " {{{ vim-coffee-script
  NeoBundleLazy 'kchmck/vim-coffee-script', { 'autoload': { 'filetypes': [ 'coffee' ] } }
  " }}}
endif

if g:vimx#env.exists('typescript') && (v:version >= 704)
  " {{{ typescript-vim
  " Usage: `:make`
  NeoBundleLazy 'leafgarland/typescript-vim', { 'autoload': { 'filetypes': [ 'typescript' ] } }
  " }}}

  " {{{ tsuquyomi
  " Usage:
  " `<C-]>` Nav to definition
  " `<C-t>` Move the cursor to the location where the last `<C-]>` was typed
  " `<C-^>` Show references
  " `<C-@>` Rename symbols
  NeoBundle 'Quramy/tsuquyomi'

  augroup vimx
    autocmd FileType typescript nmap <silent> <buffer> <C-@> <Plug>(TsuquyomiRenameSymbol)
  augroup END
  " }}}
endif

if g:vimx#env.exists('go')
  " {{{ vim-go
  NeoBundle 'fatih/vim-go'

  augroup vimx
    autocmd FileType go call s:goSettings()
  augroup END

  function! s:goSettings()
    nmap <silent> <buffer> <C-]> :GoDef<CR>
    nmap <silent> <buffer> <C-^> :GoReferrers<CR>
    nmap <silent> <buffer> <C-@> :GoRename<CR>
  endfunction
  " }}}
endif

if g:vimx#env.exists('c') || g:vimx#env.exists('cpp')
  " {{{ a.vim
  " Usage: `:A`
  NeoBundleLazy 'vim-scripts/a.vim', { 'autoload': { 'filetypes': [ 'c', 'cpp' ] } }
  " }}}
endif

if g:vimx#env.exists('rust')
  " {{{ rust.vim
  NeoBundleLazy 'rust-lang/rust.vim', { 'autoload': { 'filetype': [ 'rust' ] } }
  " }}}
endif

" }}}

" {{{ vim-table-mode
" Usage:
" `<leader>tm` Toggle table mode for the current buffer. You can change this using the |toggle-mode-options-toggle-map| option.
" `<leader>tt` Triggers |table-mode-commands-tableize| on the visually selected content.
NeoBundle 'dhruvasagar/vim-table-mode'

let g:table_mode_header_fillchar = '='
" }}}

" {{{ vim-choosewin
" Usage:
" `=` invoke choosewin mode
" `s` Swap window
" `S` Swap window but stay
NeoBundle 't9md/vim-choosewin'

let g:choosewin_overlay_enable = 1

nmap = <Plug>(choosewin)
" }}}

" {{{ lightline.vim
NeoBundle 'itchyny/lightline.vim'
" }}}

" {{{ delimitMate
" `<S-Tab>`
" `<C-G>g`
NeoBundle 'Raimondi/delimitMate'

let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
" }}}

" {{{ Game
NeoBundle 'vim-scripts/TeTrIs.vim'
" }}}

call neobundle#end()

filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" vim:ft=vim fdm=marker et ts=4 sw=2 sts=2
