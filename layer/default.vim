
function! s:SID()
  return matchstr(expand('<sfile>'), '\zs<SNR>\d\+_\zeSID$')
endfunction

" {{{ gruvbox
call dein#add('morhetz/gruvbox', { 'hook_source': 'call ' . s:SID() . 'gruvbox_on_source()' })

if &t_Co <= 16
  let g:gruvbox_termcolors = 16
endif

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'

function s:gruvbox_on_source()
  silent! colorscheme gruvbox
endfunction
" }}}

" {{{ vimcdoc
call dein#add('jkeylu/vimcdoc')
" }}}

" {{{ vimproc.vim
call dein#add('Shougo/vimproc.vim', { 'build': 'make' })
" }}}

" {{{ mark2666
call dein#add('jkeylu/mark2666')

if has('gui_running')
  let g:mwDefaultHighlightingPalette = 'extended'
  let g:mwDefaultHighlightingNum = 18
endif
" }}}

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
call dein#add('Valloric/YouCompleteMe', { 'build': './install.py' })

"augroup vimx
"  autocmd FileType javascript nmap <silent> <buffer> <C-^> :YcmCompleter GoToReferences<CR>
"  autocmd FileType javascript,typescript,go,c,cpp nmap <silent> <buffer> <C-]> :YcmCompleter GoTo<CR>
"augroup END
" }}}

" {{{ nerdcommenter
" Usage:
" `<leader>cm` minimal comment
" `<leader>cl` aligned comment
" `<leader>cu` uncomments the selected line(s)
call dein#add('scrooloose/nerdcommenter')
" }}}

" {{{ unite.vim
" Usage:
" `C-l` clear cache
call dein#add('Shougo/unite.vim', { 'hook_source': 'call ' . s:SID() . 'unite_vim_on_source()' })

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

function! s:unite_vim_on_source()
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
" Usage:
" `<leader>nt`
" in vimfiler `&` switch to project directory
call dein#add('Shougo/vimfiler.vim')

nmap <silent> <leader>nt :VimFiler -explorer -parent -status -auto-cd -auto-expand -find -force-quit<CR>
" }}}

" {{{ fzf
" in fzf
" {
"   'ctrl-m': 'e',
"   'ctrl-t': 'tab split',
"   'ctrl-x': 'split',
"   'ctrl-v': 'vsplit'
" }
if executable('fzf')
  if isdirectory('/usr/local/opt/fzf')
    set rtp+=/usr/local/opt/fzf
  else
    call dein#add('junegunn/fzf')
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
call dein#add('terryma/vim-multiple-cursors')

let g:multi_cursor_quit_key = '<Tab>'
" }}}

" {{{ accelerated-smooth-scroll
" Usage:
" `<C-d>` scroll down
" `<C-u>` scroll up
call dein#add('yonchu/accelerated-smooth-scroll')

let g:ac_smooth_scroll_no_default_key_mappings = 1

nmap <silent> <C-d> <Plug>(ac-smooth-scroll-c-d)
nmap <silent> <C-u> <Plug>(ac-smooth-scroll-c-u)
nmap <silent> <S-d> <Plug>(ac-smooth-scroll-c-f)
nmap <silent> <S-u> <Plug>(ac-smooth-scroll-c-b)
" }}}

" {{{ vim-better-whitespace
" Usage: `:StripWhitespace`
call dein#add('ntpeters/vim-better-whitespace')

let g:better_whitespace_filetypes_blacklist = ['diff', 'gitcommit', 'unite', 'qf', 'help', 'vimfiler']
" }}}

" {{{ vim-indent-guides
" Usage: The default mapping to toggle the plugin is `<leader>ig`
call dein#add('nathanaelkane/vim-indent-guides')

let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
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
call dein#add('MattesGroeger/vim-bookmarks')

let g:bookmark_auto_save_file = $HOME.'/.cache/vim-bookmarks'
" }}}

" {{{ LargeFile
call dein#add('vim-scripts/LargeFile')

let g:LargeFile = 100
" }}}

if executable('ctags')
  " {{{ tagbar
  " Usage: `<leader>tl`
  call dein#add('majutsushi/tagbar')

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
    call dein#add('airblade/vim-gitgutter')
    " }}}
  endif

  " {{{ vim-fugitive
  " Usage:
  " `:Gsplit`, `:Gvsplit`
  " `:Gdiff`
  " `:Gstatus`. Press `-` to add/reset a file's changes, or `p` to add/reset --patch
  " `:Gcommit`
  " `:Glog`
  call dein#add('tpope/vim-fugitive')
  " }}}

  " {{{ vim-merginal
  " Usage:
  " `:Merginal`
  " `C/cc` Checkout the branch under the cursor.
  " `A/aa` Create a new branch from the currently checked out branch.
  "        You'll be prompted to enter a name for the new branch
  " `D/dd` Delete the branch under the cursor.
  " `M/mm` Merge the branch under the cursor into the currently checked out
  "        branch. If there are merge conflicts, the merge conflicts buffer will open
  "        in place of the branch list buffer.
  call dein#add('idanarye/vim-merginal')
  " }}}

  " {{{ gitv
  " Usage:
  " `:Gitv`
  call dein#add('gregsexton/gitv')
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
  call dein#add('mbbill/fencview')

  "let g:fencview_autodetect = 1
  "let g:fencview_auto_patterns = '*.cnx,*.txt,*.html,*.php,*.cpp,*.h,*.c,*.css,*.js,*.ts,*.py,*.sh,*.java{|\=}'
  "let g:fencview_checklines = 10
  " }}}
endif

" {{{ vim-easymotion
" Usage:
" `;w` word motion
" `;b`
" `;e`
" `;f` looking for right
" `;F` looking for right
call dein#add('easymotion/vim-easymotion')

let g:EasyMotion_smartcase = 1
map ; <Plug>(easymotion-prefix)
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)
" }}}

" {{{ vim-rooter
call dein#add('airblade/vim-rooter')

let g:rooter_use_lcd = 1
let g:rooter_change_directory_for_non_project_files = 1
let g:rooter_silent_chdir = 1
" }}}

" {{{ vim-table-mode
" Usage:
" `<leader>tm` Toggle table mode for the current buffer. You can change this using the |toggle-mode-options-toggle-map| option.
" `<leader>tt` Triggers |table-mode-commands-tableize| on the visually selected content.
call dein#add('dhruvasagar/vim-table-mode')

" Markdown-compatible
let g:table_mode_corner = '|'

" ReST-compatible
" let g:table_mode_corner = '+'
" let g:table_mode_header_fillchar = '='
" }}}

" {{{ vim-choosewin
" Usage:
" `=` invoke choosewin mode
" `s` Swap window
" `S` Swap window but stay
call dein#add('t9md/vim-choosewin')

let g:choosewin_overlay_enable = 1

nmap = <Plug>(choosewin)
" }}}

" {{{ lightline.vim
call dein#add('itchyny/lightline.vim')
" }}}

" {{{ delimitMate
" `<S-Tab>`
" `<C-G>g`
call dein#add('Raimondi/delimitMate')

let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
" }}}

" vim:ft=vim fdm=marker et ts=4 sw=2 sts=2
