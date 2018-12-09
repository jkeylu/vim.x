"
" author: jKey Lu <jkeylu@gmail.com>
"

" Note: Skip initialization for vim-tiny or vim-small
if 0 | endif

if &compatible
  set nocompatible " be iMproved
endif

let mapleader = ','

if empty(glob('~/.vim/autoload/plug.vim'))
    echo 'Downloading plug.vim ...'
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ==============================================================================
" {{{ plug.vim
" ==============================================================================
silent! if plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'Yggdroot/indentLine'
Plug 'yonchu/accelerated-smooth-scroll'
" {{{ Usage
" `<C-d>` scroll down
" `<C-u>` scroll up
" }}}
Plug 'yianwillis/vimcdoc'

" Browsing
Plug 'inkarkat/vim-mark'
" {{{ Usage
" `,m` mark word under the cursor
" }}}
Plug 't9md/vim-choosewin'
" {{{ Usage
" `=` invoke choosewin mode
"   `s` Swap window
"   `S` Swap window but stay
" }}}
Plug 'airblade/vim-rooter'
Plug 'scrooloose/nerdtree'
" {{{ Usage
" `,nt` Open NERDTree
"   `o` open file, open & close node
"   `m` open menu
"   `C` change tree root to selected dir
"   `u` move tree root up a dir
" }}}
Plug 'jlanzarotta/bufexplorer'
" {{{ Usage
" `,,` Open bufexplorer
" }}}
if executable('fzf')
  if isdirectory('/usr/local/opt/fzf')
    Plug '/usr/local/opt/fzf'
  endif
else
  Plug 'junegunn/fzf', { 'do': './install --bin' }
  " {{{ Usage
  " in fzf
  " {
  "   'ctrl-m': 'e',
  "   'ctrl-t': 'tab split',
  "   'ctrl-x': 'split',
  "   'ctrl-v': 'vsplit'
  " }
  " }}}
endif
Plug 'junegunn/fzf.vim'

" Edit
Plug 'easymotion/vim-easymotion'
" {{{ Usage
" `;w` word motion
" `;b`
" `;e`
" `;f` looking for right
" `;F` looking for right
" }}}
Plug 'terryma/vim-multiple-cursors'
" {{{ Usage
" `<C-n>` next
" `<C-p>` prev
" `<C-x>` skip
" `<Tab>` quit
" }}}
Plug 'ntpeters/vim-better-whitespace'
" {{{ Usage
" `:StripWhitespace`
" }}}
Plug 'Raimondi/delimitMate'
" {{{ Usage
" `<S-Tab>`
" `<C-G>g`
" }}}
Plug 'scrooloose/nerdcommenter'
" {{{ Usage
" `<leader>cm` minimal comment
" `<leader>cl` aligned comment
" `<leader>cu` uncomments the selected line(s)
" }}}

" File
Plug 'vim-scripts/LargeFile'
if has('iconv')
  Plug 'mbbill/fencview'
  " {{{ Usage
  " `:FencView`
  " `:FencAutoDetect`
  " `:FencManualEncoding utf-8`
  " }}}
endif

" Git
if has('signs')
  Plug 'airblade/vim-gitgutter'
  " {{{ Usage
  " `]c` jump to next hunk (change)
  " `[c` jump to previous hunk (change)
  " `<leader>hs` stage the hunk
  " `<leader>hr` revert it
  " `<leader>hp` preview a hunk's changes
  " }}}
endif
Plug 'tpope/vim-fugitive'
" {{{ Usage
" `:Gsplit`, `:Gvsplit`
" `:Gdiff`
" `:Gstatus`. Press `-` to add/reset a file's changes, or `p` to add/reset --patch
" `:Gcommit`
" `:Glog`
" }}}
Plug 'idanarye/vim-merginal'
" {{{ Usage
" `:Merginal`
" `C/cc` Checkout the branch under the cursor.
" `A/aa` Create a new branch from the currently checked out branch.
"        You'll be prompted to enter a name for the new branch
" `D/dd` Delete the branch under the cursor.
" `M/mm` Merge the branch under the cursor into the currently checked out
"        branch. If there are merge conflicts, the merge conflicts buffer will open
"        in place of the branch list buffer.
" }}}
Plug 'gregsexton/gitv', { 'on': ['Gitv'] }
" {{{ Usage
" `:Gitv`
" }}}

" Lang
if executable('go')
  Plug 'fatih/vim-go'
  " {{{ Usage
  " `C-]` = `:GoDef`
  " `C-t` = `:GoDefPop`
  " }}}
endif
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'moll/vim-node'
Plug 'leafgarland/typescript-vim'
if executable('tsc')
  Plug 'Quramy/tsuquyomi'
endif

call plug#end()
endif
" }}}

" ==============================================================================
" {{{ PLUGINS
" ==============================================================================

" ------------------------------------------------------------------------------
" morhetz/gruvbox
" ------------------------------------------------------------------------------
if &t_Co <= 16
  let g:gruvbox_termcolors = 16
endif

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'

silent! colorscheme gruvbox

" ------------------------------------------------------------------------------
" yonchu/accelerated-smooth-scroll
" ------------------------------------------------------------------------------
let g:ac_smooth_scroll_no_default_key_mappings = 1

nmap <silent> <C-d> <Plug>(ac-smooth-scroll-c-d)
nmap <silent> <C-u> <Plug>(ac-smooth-scroll-c-u)
nmap <silent> <S-d> <Plug>(ac-smooth-scroll-c-f)
nmap <silent> <S-u> <Plug>(ac-smooth-scroll-c-b)

" ------------------------------------------------------------------------------
" nathanaelkane/vim-indent-guides
" ------------------------------------------------------------------------------
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" ------------------------------------------------------------------------------
" t9md/vim-choosewin
" ------------------------------------------------------------------------------
let g:choosewin_overlay_enable = 1

nmap = <Plug>(choosewin)

" ------------------------------------------------------------------------------
" airblade/vim-rooter
" ------------------------------------------------------------------------------
let g:rooter_use_lcd = 1
"let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_silent_chdir = 1

" ------------------------------------------------------------------------------
" scrooloose/nerdtree
" ------------------------------------------------------------------------------
let NERDTreeChDirMode = 2
let NERDTreeWinSize = 25
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMapToggleHidden = '.'

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif

nnoremap <silent> <leader>nt :call <SID>open_nerdtree()<CR>

function! s:is_nerdtree_opened()
  return exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
endfunction

function! s:open_nerdtree()
  if !s:is_nerdtree_opened() && &modifiable && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
  else
    NERDTree
  endif
endfunction

" ------------------------------------------------------------------------------
" jlanzarotta/bufexplorer
" ------------------------------------------------------------------------------
let g:bufExplorerSplitBelow = 1
let g:bufExplorerSplitHorzSize = 20
nnoremap <silent> <leader><leader> :BufExplorerHorizontalSplit<CR>

" ------------------------------------------------------------------------------
" junegunn/fzf
" ------------------------------------------------------------------------------
nnoremap <silent> <C-f> :FZF<CR>

" ------------------------------------------------------------------------------
" junegunn/fzf.vim
" ------------------------------------------------------------------------------

if executable('rg')
  " https://github.com/BurntSushi/ripgrep
  nnoremap <S-f> :Rg<CR>
elseif executable('ag')
  " https://github.com/ggreer/the_silver_searcher
  nnoremap <S-f> :Ag<CR>
endif

" ------------------------------------------------------------------------------
" easymotion/vim-easymotion
" ------------------------------------------------------------------------------
let g:EasyMotion_smartcase = 1
map ; <Plug>(easymotion-prefix)
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)
" https://github.com/easymotion/vim-easymotion/issues/348
autocmd VimEnter * silent! :EMCommandLineNoreMap <C-v> <C-r>+

" ------------------------------------------------------------------------------
" terryma/vim-multiple-cursors
" ------------------------------------------------------------------------------
let g:multi_cursor_quit_key = '<Tab>'

" ------------------------------------------------------------------------------
" ntpeters/vim-better-whitespace
" ------------------------------------------------------------------------------
let g:better_whitespace_filetypes_blacklist = ['diff', 'gitcommit', 'unite', 'qf', 'help', 'vimfiler']

" ------------------------------------------------------------------------------
" Raimondi/delimitMate
" ------------------------------------------------------------------------------
"let delimitMate_expand_cr = 1
"let delimitMate_expand_space = 1

" ------------------------------------------------------------------------------
" jkeylu/mark2666
" ------------------------------------------------------------------------------
if has('gui_running')
  let g:mwDefaultHighlightingPalette = 'extended'
  let g:mwDefaultHighlightingNum = 18
endif

" ------------------------------------------------------------------------------
" vim-scripts/LargeFile
" ------------------------------------------------------------------------------
let g:LargeFile = 100

" ------------------------------------------------------------------------------
" mbbill/fencview
" ------------------------------------------------------------------------------
"let g:fencview_autodetect = 1
"let g:fencview_auto_patterns = '*.cnx,*.txt,*.html,*.php,*.cpp,*.h,*.c,*.css,*.js,*.ts,*.py,*.sh,*.java{|\=}'
"let g:fencview_checklines = 10

" ------------------------------------------------------------------------------
" fatih/vim-go
" ------------------------------------------------------------------------------
autocmd FileType go call <SID>go_settings()

function! s:go_settings()
  nmap <silent> <buffer> <C-^> :GoReferrers<CR>
  nmap <silent> <buffer> <C-@> :GoRename<CR>
endfunction

" ------------------------------------------------------------------------------
" pangloss/vim-javascript
" ------------------------------------------------------------------------------
let g:javascript_plugin_jsdoc = 1

" ------------------------------------------------------------------------------
" Quramy/tsuquyomi
" ------------------------------------------------------------------------------
let g:tsuquyomi_completion_detail = 1

autocmd FileType typescript nmap <silent> <buffer> <C-@> <Plug>(TsuquyomiRenameSymbol)

" }}}

" ==============================================================================
" {{{ BASIC
" ==============================================================================
set background=dark
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
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
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

" }}}

" ==============================================================================
" {{{ EXTRA
" ==============================================================================

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
" }}}

" vim:ft=vim fdm=marker et ts=4 sw=2 sts=2
