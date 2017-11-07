
" {{{ gruvbox
if g:vimx_loading_bundle
  call dein#add('morhetz/gruvbox',
        \ {
        \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
        \ })
else
  autocmd User dein#source#gruvbox call s:gruvbox_on_source()
  function s:gruvbox_on_source()
    if &t_Co <= 16
      let g:gruvbox_termcolors = 16
    endif

    let g:gruvbox_contrast_dark = 'hard'
    let g:gruvbox_contrast_light = 'hard'

    silent! colorscheme gruvbox
  endfunction
endif
" }}}

" {{{ vimcdoc
if g:vimx_loading_bundle
  call dein#add('yianwillis/vimcdoc')
endif
" }}}

" {{{ vimproc.vim
if g:vimx_loading_bundle
  call dein#add('Shougo/vimproc.vim', { 'build': 'make' })
endif
" }}}

" {{{ mark2666
if g:vimx_loading_bundle
  call dein#add('jkeylu/mark2666',
        \ {
        \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
        \ })
else
  autocmd User dein#source#mark2666 call s:mark2666_on_source()
  function s:mark2666_on_source()
    if has('gui_running')
      let g:mwDefaultHighlightingPalette = 'extended'
      let g:mwDefaultHighlightingNum = 18
    endif
  endfunction
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
if g:vimx_loading_bundle
  call dein#add('Valloric/YouCompleteMe',
        \ {
        \   'build': './install.py',
        \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
        \ })
else
  autocmd User dein#source#YouCompleteMe call s:you_complete_me_on_source()
  function s:you_complete_me_on_source()
    "augroup vimx
    "  autocmd FileType javascript nmap <silent> <buffer> <C-^> :YcmCompleter GoToReferences<CR>
    "  autocmd FileType javascript,typescript,go,c,cpp nmap <silent> <buffer> <C-]> :YcmCompleter GoTo<CR>
    "augroup END
  endfunction
endif
" }}}

" {{{ nerdcommenter
" Usage:
" `<leader>cm` minimal comment
" `<leader>cl` aligned comment
" `<leader>cu` uncomments the selected line(s)
if g:vimx_loading_bundle
  call dein#add('scrooloose/nerdcommenter')
endif
" }}}

" {{{ unite.vim
" Usage:
" `C-l` clear cache
if g:vimx_loading_bundle
  call dein#add('Shougo/unite.vim',
        \ {
        \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name',
        \   'hook_post_source': 'execute "doautocmd <nomodeline> User" "dein#post_source#".g:dein#plugin.name'
        \ })
else
  autocmd User dein#source#unite.vim call s:unite_vim_on_source()
  autocmd User dein#post_source#unite.vim call s:unite_vim_on_post_source()
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
endif
" }}}

" {{{ vimfiler.vim
" Usage:
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
if g:vimx_loading_bundle
  call dein#add('Shougo/vimfiler.vim',
        \ {
        \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
        \ })
else
  autocmd User dein#source#vimfiler.vim call s:vimfiler_vim_on_source()
  function s:vimfiler_vim_on_source()
    let g:vimfiler_as_default_explorer = 1
    nmap <silent> <leader>nt :VimFiler -explorer -parent -status -auto-cd -auto-expand -find -force-quit<CR>
  endfunction
endif
" }}}

if executable('fzf')
  " {{{ fzf
  " in fzf
  " {
  "   'ctrl-m': 'e',
  "   'ctrl-t': 'tab split',
  "   'ctrl-x': 'split',
  "   'ctrl-v': 'vsplit'
  " }
  if g:vimx_loading_bundle
    if !isdirectory('/usr/local/opt/fzf')
      call dein#add('junegunn/fzf',
            \ {
            \   'hook_post_source': 'execute "doautocmd <nomodeline> User" "dein#post_source#".g:dein#plugin.name'
            \ })
    endif
  else
    autocmd User dein#post_source#fzf call s:fzf_on_post_source()
    function s:fzf_on_post_source()
      " use fzf instead of unite
      nnoremap <silent> <C-f> :FZF<CR>
    endfunction

    if isdirectory('/usr/local/opt/fzf')
      set rtp+=/usr/local/opt/fzf
      call s:fzf_on_post_source()
    endif
  endif
  " }}}
endif

" {{{ vim-multiple-cursors
" Usage:
" `<C-n>` next
" `<C-p>` prev
" `<C-x>` skip
" `<Tab>` quit
if g:vimx_loading_bundle
  call dein#add('terryma/vim-multiple-cursors',
        \ {
        \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
        \ })
else
  autocmd User dein#source#vim-multiple-cursors call s:vim_multiple_cursors_on_source()
  function s:vim_multiple_cursors_on_source()
    let g:multi_cursor_quit_key = '<Tab>'
  endfunction
endif
" }}}

" {{{ accelerated-smooth-scroll
" Usage:
" `<C-d>` scroll down
" `<C-u>` scroll up
if g:vimx_loading_bundle
  call dein#add('yonchu/accelerated-smooth-scroll',
        \ {
        \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
        \ })
else
  autocmd User dein#source#accelerated-smooth-scroll call s:accelerated_smooth_scroll_on_source()
  function s:accelerated_smooth_scroll_on_source()
    let g:ac_smooth_scroll_no_default_key_mappings = 1

    nmap <silent> <C-d> <Plug>(ac-smooth-scroll-c-d)
    nmap <silent> <C-u> <Plug>(ac-smooth-scroll-c-u)
    nmap <silent> <S-d> <Plug>(ac-smooth-scroll-c-f)
    nmap <silent> <S-u> <Plug>(ac-smooth-scroll-c-b)
  endfunction
endif
" }}}

" {{{ vim-better-whitespace
" Usage: `:StripWhitespace`
if g:vimx_loading_bundle
  call dein#add('ntpeters/vim-better-whitespace',
        \ {
        \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
        \ })
else
  autocmd User dein#source#vim-better-whitespace call s:vim_better_whitespace_on_source()
  function s:vim_better_whitespace_on_source()
    let g:better_whitespace_filetypes_blacklist = ['diff', 'gitcommit', 'unite', 'qf', 'help', 'vimfiler']
  endfunction
endif
" }}}

" {{{ vim-indent-guides
" Usage: The default mapping to toggle the plugin is `<leader>ig`
if g:vimx_loading_bundle
  call dein#add('nathanaelkane/vim-indent-guides',
        \ {
        \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
        \ })
else
  autocmd User dein#source#vim-indent-guides call s:vim_indent_guides_on_source()
  function s:vim_indent_guides_on_source()
    let g:indent_guides_guide_size = 1
    let g:indent_guides_start_level = 2
  endfunction
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
if g:vimx_loading_bundle
  call dein#add('MattesGroeger/vim-bookmarks',
        \ {
        \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
        \ })
else
  autocmd User dein#source#vim-bookmarks call s:vim_bookmarks_on_source()
  function s:vim_bookmarks_on_source()
    let g:bookmark_auto_save_file = $HOME.'/.cache/vim-bookmarks'
  endfunction
endif
" }}}

" {{{ LargeFile
if g:vimx_loading_bundle
  call dein#add('vim-scripts/LargeFile',
        \ {
        \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
        \ })
else
  autocmd User dein#source#LargeFile call s:large_file_on_source()
  function s:large_file_on_source()
    let g:LargeFile = 100
  endfunction
endif
" }}}

if executable('ctags')
  " {{{ tagbar
  " Usage: `<leader>tl`
  if g:vimx_loading_bundle
    call dein#add('majutsushi/tagbar',
          \ {
          \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
          \ })
  else
    autocmd User dein#source#tagbar call s:tagbar_on_source()
    function s:tagbar_on_source()
      let g:tagbar_width = 40
      let g:tagbar_autoclose = 1
      let g:tagbar_autofocus = 1
      let g:tagbar_show_linenumbers = 2
      nnoremap <leader>tl :TagbarToggle<CR>
    endfunction
  endif
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
    if g:vimx_loading_bundle
      call dein#add('airblade/vim-gitgutter')
    endif
    " }}}
  endif

  " {{{ vim-fugitive
  " Usage:
  " `:Gsplit`, `:Gvsplit`
  " `:Gdiff`
  " `:Gstatus`. Press `-` to add/reset a file's changes, or `p` to add/reset --patch
  " `:Gcommit`
  " `:Glog`
  if g:vimx_loading_bundle
    call dein#add('tpope/vim-fugitive')
  endif
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
  if g:vimx_loading_bundle
    call dein#add('idanarye/vim-merginal')
  endif
  " }}}

  " {{{ gitv
  " Usage:
  " `:Gitv`
  if g:vimx_loading_bundle
    call dein#add('gregsexton/gitv')
  endif
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
  if g:vimx_loading_bundle
    call dein#add('mbbill/fencview',
          \ {
          \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
          \ })
  else
    autocmd User dein#source#fencview call s:fencview_on_source()
    function s:fencview_on_source()
      "let g:fencview_autodetect = 1
      "let g:fencview_auto_patterns = '*.cnx,*.txt,*.html,*.php,*.cpp,*.h,*.c,*.css,*.js,*.ts,*.py,*.sh,*.java{|\=}'
      "let g:fencview_checklines = 10
    endfunction
  endif
  " }}}
endif

" {{{ vim-easymotion
" Usage:
" `;w` word motion
" `;b`
" `;e`
" `;f` looking for right
" `;F` looking for right
if g:vimx_loading_bundle
  call dein#add('easymotion/vim-easymotion',
        \ {
        \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
        \ })
else
  autocmd User dein#source#vim-easymotion call s:vim_easymotion_on_source()
  function s:vim_easymotion_on_source()
    let g:EasyMotion_smartcase = 1
    map ; <Plug>(easymotion-prefix)
    map / <Plug>(easymotion-sn)
    omap / <Plug>(easymotion-tn)
    map n <Plug>(easymotion-next)
    map N <Plug>(easymotion-prev)
    " https://github.com/easymotion/vim-easymotion/issues/348
    autocmd VimEnter * :EMCommandLineNoreMap <C-v> <C-r>+
  endfunction
endif
" }}}

" {{{ vim-rooter
if g:vimx_loading_bundle
  call dein#add('airblade/vim-rooter',
        \ {
        \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
        \ })
else
  autocmd User dein#source#vim-rooter call s:vim_router_on_source()
  function s:vim_router_on_source()
    let g:rooter_use_lcd = 1
    let g:rooter_change_directory_for_non_project_files = 1
    let g:rooter_silent_chdir = 1
  endfunction
endif
" }}}

" {{{ vim-table-mode
" Usage:
" `<leader>tm` Toggle table mode for the current buffer. You can change this using the |toggle-mode-options-toggle-map| option.
" `<leader>tt` Triggers |table-mode-commands-tableize| on the visually selected content.
if g:vimx_loading_bundle
  call dein#add('dhruvasagar/vim-table-mode',
        \ {
        \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
        \ })
else
  autocmd User dein#source#vim-table-mode call s:vim_table_mode_on_source()
  function s:vim_table_mode_on_source()
    let g:table_mode_auto_align = 0

    " Markdown-compatible
    let g:table_mode_corner = '|'

    " ReST-compatible
    " let g:table_mode_corner = '+'
    " let g:table_mode_header_fillchar = '='
  endfunction
endif
" }}}

" {{{ vim-choosewin
" Usage:
" `=` invoke choosewin mode
" `s` Swap window
" `S` Swap window but stay
if g:vimx_loading_bundle
  call dein#add('t9md/vim-choosewin',
        \ {
        \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
        \ })
else
  autocmd User dein#source#vim-choosewin call s:vim_choosewin_on_source()
  function s:vim_choosewin_on_source()
    let g:choosewin_overlay_enable = 1

    nmap = <Plug>(choosewin)
  endfunction
endif
" }}}

" {{{ lightline.vim
if g:vimx_loading_bundle
  call dein#add('itchyny/lightline.vim')
endif
" }}}

" {{{ delimitMate
" `<S-Tab>`
" `<C-G>g`
if g:vimx_loading_bundle
  call dein#add('Raimondi/delimitMate',
        \ {
        \   'hook_source': 'execute "doautocmd <nomodeline> User" "dein#source#".g:dein#plugin.name'
        \})
else
  autocmd User dein#source#delimitMate call s:delimit_mate_on_source()
  function s:delimit_mate_on_source()
    "let delimitMate_expand_cr = 1
    "let delimitMate_expand_space = 1
  endfunction
endif
" }}}

" vim:ft=vim fdm=marker et ts=4 sw=2 sts=2
