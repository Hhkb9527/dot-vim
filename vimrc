" font: Iosevka Term curly
let g:mapleader=" "
let s:is_win = has('win32')
let s:is_gvim = has('gui_running')
let s:is_tty = !match(&term, 'linux') || !match(&term, 'win32')

if !has('gui_running')
  set t_Co=256
endif

if s:is_gvim
  set guifont=Sarasa\ Term\ CL\ 14
  let g:gruvbox_italic = 1
  let g:gruvbox_italicize_strings = 1
else
  let g:gruvbox_italic = 0
  let g:gruvbox_italicize_strings = 0
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
    let &fillchars = 'diff: '  " ▚
    let &showbreak = '↳ '
    highlight VertSplit ctermfg=242
    augroup vimrc
      autocmd InsertEnter * set listchars-=trail:⣿
      autocmd InsertLeave * set listchars+=trail:⣿
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

augroup vimrc
  " go back to where you exited
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal g'\"" |
        \ endif
  " save on focus lost
  autocmd FocusLost * :silent! wa
augroup END

autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

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

" powerline font 没生效
" let g:powerline_pycmd="py3"

inoremap jk <ESC>:w<CR>
noremap <Leader><CR> :nohlsearch<CR>
noremap <Leader>n :bn<CR>
noremap <Leader>p :bp<CR>
" noremap <Leader>d :bdelete<CR>

" fuck q的记录功能,总tm按错
" nnoremap q <nop>
xnoremap < <gv
xnoremap > >gv
nnoremap Zll :qall<ESC>

noremap <silent> <C-t>l :set splitright<CR>:vsplit<CR>
noremap <silent> <C-t>h :set nosplitright<CR>:vsplit<CR>
noremap <silent> <C-t>j :set nosplitbelow<CR>:split<CR>
noremap <silent> <C-t>k :set splitbelow<CR>:split<CR>
noremap <silent> <C-t>u  <C-w>t<C-w>H
noremap <silent> <C-t>i  <C-w>t<C-w>K

" 需要gvim的X11支持
xnoremap <silent>Y "+y
nnoremap tp "+P

nnoremap ]e         :<C-u>execute 'move +'. v:count1<CR>
nnoremap [e         :<C-u>execute 'move -1-'. v:count1<CR>
nnoremap [<space>   :<C-u>put! =repeat(nr2char(10), v:count1)<CR>'[
nnoremap ]<space>   :<C-u>put =repeat(nr2char(10), v:count1)<CR>

" 调用寄存器历史
nnoremap <Leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

syntax enable
set nu
set list
set cursorline
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
set ignorecase   "ignorecase 存在 smartcase 才会生效
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
filetype on
filetype indent on
filetype plugin on

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'powerline/powerline'
" Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
" Plug 'sickill/vim-monokai'
" Plug 'lifepillar/vim-gruvbox8'
" Plug 'joshdick/onedark.vim'
" Plug 'altercation/vim-colors-solarized'

Plug 'itchyny/vim-cursorword'
Plug 'preservim/nerdcommenter'
Plug 'lfv89/vim-interestingwords' " 默认<leader>k,每次更新记得改下源码
Plug 'mattn/emmet-vim', { 'for': ['xml', 'html', 'css', 'javascript', 'typescript', 'typescript.tsx']  }
Plug 'othree/html5.vim', {'for': 'html' }
" Plug 'dense-analysis/ale'
Plug 'w0rp/ale'
Plug 'mhinz/vim-startify'
Plug 'markonm/traces.vim'
Plug 'ervandew/supertab'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'AndrewRadev/linediff.vim'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'Yggdroot/LeaderF-marks'
" Plug 'bennyyip/LeaderF-github-stars' " 没生效
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'ntpeters/vim-better-whitespace'
Plug 'airblade/vim-rooter'
Plug 'dyng/ctrlsf.vim'
Plug 'svermeulen/vim-yoink'
Plug 'voldikss/vim-translate-me'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-vinegar'
Plug 'luochen1990/rainbow'
" @description: enhances netrw.
" @command: I gh ~
" let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

Plug 'tpope/vim-capslock'
" @description: temporary software caps lock.
" @command: <c-g>c or gC

Plug 'tpope/vim-surround'
" @description: easily delete, change and add such surroundings in pairs.
" @command: ds(, cs({, cS({, ysw(, ySw(, yss(, ySS(, S(, gS(

Plug 'machakann/vim-highlightedyank'
Plug 'junegunn/vim-easy-align'
Plug 'octol/vim-cpp-enhanced-highlight'

" Plug 'Shougo/denite.nvim'
" Plug 'godlygeek/tabular'
" Plug 'skywind3000/asyncrun.vim'
" Plug 'mileszs/ack.vim'
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'vim-python/python-syntax', { 'for': 'python' }
" Plug 'kana/vim-textobj-entire'

Plug 'iamcco/markdown-preview.vim'

Plug 'puremourning/vimspector'
Plug 'Yggdroot/indentLine'
call plug#end()

" Yggdroot/indentLine
let g:indentLine_char_list = ['|', '¦', '┆', '┊']



" let g:gruvbox_contrast_dark='middle'
set background=dark
colorscheme gruvbox

" colorscheme gruvbox8
" let g:gruvbox_material_background = 'hard'
" let g:gruvbox_plugin_hi_groups = 1
" let g:gruvbox_filetype_hi_groups = 1
" let s:colorscheme = get(g:, 'colors_name', 'default')
