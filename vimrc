let g:mapleader=" "
let s:is_win = has('win32')
let s:is_gvim = has('gui_running')
let s:is_tty = !match(&term, 'linux') || !match(&term, 'win32')
let s:minpac_dir = $HOME . '/.vim/pack/minpac/opt/minpac'

" minpac: A minimal package manager for Vim 8 (and Neovim)
if !isdirectory(s:minpac_dir)
  silent! execute printf('!git clone https://github.com/k-takata/minpac.git %s', s:minpac_dir)
end

if !has('gui_running')
  set t_Co=256
  if has("X11")
    xnoremap <silent>Y "+y
    nnoremap tp "+P
  endif
endif

" enable true color, use following script to check in vim terminal
" https://github.com/gnachman/iTerm2/blob/master/tests/24-bit-color.sh
if has("termguicolors")
    " fix bug for vim
    set t_8f=[38;2;%lu;%lu;%lum
    set t_8b=[48;2;%lu;%lu;%lum
    set termguicolors
endif

if !s:is_tty
  if s:is_win
    set renderoptions=type:directx
    let &listchars = 'tab:▸ ,extends:>,precedes:<,nbsp:.'
    let &showbreak = '-> '
    highlight VertSplit ctermfg=242
    augroup vimrc
      autocmd InsertEnter * set listchars-=trail:⣿
      autocmd InsertLeave * set listchars+=trail:⣿
    augroup END
  elseif has('multi_byte') && &encoding ==# 'utf-8'
    let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
    let &fillchars = 'diff: '  " ⣿
    let &showbreak = '↳ '
    highlight VertSplit ctermfg=242
    augroup vimrc
      autocmd InsertEnter * set listchars-=trail:▚
      autocmd InsertLeave * set listchars+=trail:▚
    augroup END
  else
    let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
    "let &fillchars = 'stlnc:#'
    let &showbreak = '-> '
    augroup vimrc
      autocmd InsertEnter * set listchars-=trail:.
      autocmd InsertLeave * set listchars+=trail:.
    augroup END
  endif
endif " s:is_tty

" Return to last edit position when opening files
augroup vimrc
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal g'\"" |
        \ endif
  autocmd FocusLost * :silent! wa
augroup END

" use <F5> to exec python script
autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" if empty($TMUX)
  " let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  " let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  " let &t_SR = "\<Esc>]50;CursorShape=2\x7"
" else
  " let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  " let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  " let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
" endif

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

inoremap jk <ESC>:w<CR>
noremap <silent> <Leader><CR> :nohlsearch<CR>
noremap <silent> <Leader>n :bn<CR>
noremap <silent> <Leader>p :bp<CR>

xnoremap < <gv
xnoremap > >gv
nnoremap Zll :qall<ESC>

noremap <silent> <C-t>l :set splitright<CR>:vsplit<CR>
noremap <silent> <C-t>h :set nosplitright<CR>:vsplit<CR>
noremap <silent> <C-t>j :set nosplitbelow<CR>:split<CR>
noremap <silent> <C-t>k :set splitbelow<CR>:split<CR>
noremap <silent> <C-t>u  <C-w>t<C-w>H
noremap <silent> <C-t>i  <C-w>t<C-w>K

" enter/exit paste mode and set/unset number
noremap <silent> <C-t>p :set paste!<CR>:set number!<CR>:set relativenumber!<CR>

nnoremap ]e         :<C-u>execute 'move +'. v:count1<CR>
nnoremap [e         :<C-u>execute 'move -1-'. v:count1<CR>
nnoremap [<space>   :<C-u>put! =repeat(nr2char(10), v:count1)<CR>'[
nnoremap ]<space>   :<C-u>put =repeat(nr2char(10), v:count1)<CR>

" list register history
nnoremap <Leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

syntax enable
set list
set cursorline
set number
set relativenumber
set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
set wrap
set showcmd
set showmode
set wildmenu
set hlsearch
set incsearch
set ignorecase   " smartcase relys on ignorecase
set smartcase
set noswapfile
set signcolumn=auto
set foldcolumn=0
set history=1000
set noerrorbells " no BB
set novisualbell
set t_vb=
set encoding=utf-8
set fileencodings=utf-8,gbk,gb18030,gb2312,cp936,usc-bom,euc-jp
set termencoding=utf-8
set nocompatible
set backspace=indent,eol,start
set foldmethod=indent
set foldlevelstart=99
set laststatus=2
set autochdir
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set showtabline=2
filetype on
filetype indent on
filetype plugin on

call plugpac#begin()
Pack 'morhetz/gruvbox'
Pack 'ryanoasis/vim-devicons'
Pack 'vim-airline/vim-airline'
Pack 'vim-airline/vim-airline-themes'
" Pack 'itchyny/lightline.vim'
" Pack 'mengelbrecht/lightline-bufferline'
Pack 'itchyny/vim-cursorword'
Pack 'preservim/nerdcommenter'
Pack 'lfv89/vim-interestingwords'
Pack 'mattn/emmet-vim', { 'for': ['xml', 'html', 'css', 'javascript', 'typescript', 'typescript.tsx']  }
Pack 'othree/html5.vim', {'for': 'html' }
Pack 'w0rp/ale'
Pack 'mhinz/vim-startify'
Pack 'markonm/traces.vim'
Pack 'ervandew/supertab'
Pack 'junegunn/goyo.vim'
Pack 'junegunn/limelight.vim'
Pack 'AndrewRadev/linediff.vim'
Pack 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Pack 'Yggdroot/LeaderF-marks'
Pack 'neoclide/coc.nvim', { 'branch': 'release' }
Pack 'ntpeters/vim-better-whitespace'
Pack 'airblade/vim-rooter'
Pack 'dyng/ctrlsf.vim'
Pack 'svermeulen/vim-yoink'
Pack 'voldikss/vim-translator'
Pack 'tpope/vim-abolish'
Pack 'tpope/vim-fugitive'
Pack 'tpope/vim-repeat'
Pack 'tpope/vim-speeddating'
Pack 'tpope/vim-sensible'
Pack 'tpope/vim-vinegar'
Pack 'luochen1990/rainbow'
Pack 'jiangmiao/auto-pairs'
" @description: enhances netrw.
" @command: I gh ~
" let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

Pack 'tpope/vim-capslock'
" @description: temporary software caps lock.
" @command: <c-g>c or gC

Pack 'tpope/vim-surround'
" @description: easily delete, change and add such surroundings in pairs.
" @command: ds(, cs({, cS({, ysw(, ySw(, yss(, ySS(, S(, gS(

Pack 'machakann/vim-highlightedyank'
Pack 'junegunn/vim-easy-align'
Pack 'octol/vim-cpp-enhanced-highlight'
Pack 'puremourning/vimspector'
Pack 'Yggdroot/indentLine'
" Pack 'mileszs/ack.vim'
Pack 'xolox/vim-misc'
Pack 'xolox/vim-notes'
Pack 'voldikss/vim-codelf'
call plugpac#end()

let g:gruvbox_italic=1
let g:gruvbox_italicize_strings=1
set background=dark
colorscheme gruvbox
