let g:mapleader=" "
let s:is_win = has('win32')
let s:is_gvim = has('gui_running')
let s:is_tty = !match(&term, 'linux') || !match(&term, 'win32')
let s:plugin_dir = $HOME . '/.vim/autoload/plug.vim'

" auto download plug.vim plugin manager
if !filereadable(s:plugin_dir)
    execute printf('!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
endif

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
            autocmd InsertEnter * set listchars-=trail:▚
            autocmd InsertLeave,BufReadPre * set listchars+=trail:▚
        augroup END
    elseif has('multi_byte') && &encoding ==# 'utf-8'
        let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
        let &fillchars = 'diff: '    " ⣿
        let &showbreak = '↳ '
        highlight VertSplit ctermfg=242
        augroup vimrc
            autocmd InsertEnter * set listchars-=trail:⣿
            autocmd InsertLeave,BufReadPre * set listchars+=trail:⣿
        augroup END
    else
        let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
        "let &fillchars = 'stlnc:#'
        let &showbreak = '-> '
        augroup vimrc
            autocmd InsertEnter * set listchars-=trail:.
            autocmd InsertLeave,BufReadPre * set listchars+=trail:.
        augroup END
    endif
endif " s:is_tty

" Return to last edit position when opening files
augroup vimrc
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \     exe "normal g'\"" |
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

xnoremap < <gv
xnoremap > >gv
nnoremap Zll :qall<ESC>

noremap <silent> <C-t>l :set splitright<CR>:vsplit<CR>
noremap <silent> <C-t>h :set nosplitright<CR>:vsplit<CR>
noremap <silent> <C-t>j :set nosplitbelow<CR>:split<CR>
noremap <silent> <C-t>k :set splitbelow<CR>:split<CR>
noremap <silent> <C-t>u <C-w>t<C-w>H
noremap <silent> <C-t>i <C-w>t<C-w>K

" enter/exit paste mode and set/unset number
noremap <silent> <C-t>p :set paste!<CR>:set number!<CR>:set relativenumber!<CR>

nnoremap ]e :<C-u>execute 'move +'. v:count1<CR>
nnoremap [e :<C-u>execute 'move -1-'. v:count1<CR>
nnoremap [<space> :<C-u>put! =repeat(nr2char(10), v:count1)<CR>'[
nnoremap ]<space> :<C-u>put =repeat(nr2char(10), v:count1)<CR>

" list register history
nnoremap <Leader>m :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

" auto generate title when file created
autocmd BufNewFile *.py exec ":call SetTitle()"
    func SetTitle()
        call setline(1,"#!/usr/bin/env python3")
        call setline(2,"# -*- coding: utf-8 -*-")
        " call setline(3,"# Copyright (c) 2021, Tencent Inc. All rights reserved.")
        " call setline(4,"# Author: fufuzhao (fufuzhao@tencent.com)")
    endfunc
autocmd BufNewFile * normal G

" Remove all trailing whitespace
nnoremap <Leader>al :call TrimWhitespace()<CR>
function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction

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
set wildmode=full
set wildignore=*.pyc,*.dll,*.exe,*.jpg,*.gif,*.png
set hlsearch
set incsearch
set ignorecase " smartcase relys on ignorecase
set smartcase
set noswapfile
set signcolumn=auto
set foldcolumn=0
set foldmethod=indent
set foldlevelstart=99
set history=1000
set noerrorbells " no BB
set novisualbell
set t_vb=
set encoding=utf-8
set fileencodings=utf-8,gbk,gb18030,gb2312,cp936,usc-bom,euc-jp
set termencoding=utf-8
set nocompatible
set backspace=indent,eol,start
set laststatus=2
set autochdir
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set showtabline=2
filetype plugin indent on

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/vim-cursorword'
Plug 'lfv89/vim-interestingwords'
Plug 'othree/html5.vim', {'for': 'html' }
Plug 'w0rp/ale'
Plug 'mhinz/vim-startify'
Plug 'markonm/traces.vim'
Plug 'ervandew/supertab'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'AndrewRadev/linediff.vim'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'Yggdroot/LeaderF-marks'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'airblade/vim-rooter'
Plug 'dyng/ctrlsf.vim'
Plug 'svermeulen/vim-yoink'
Plug 'voldikss/vim-translator'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-vinegar'
Plug 'luochen1990/rainbow'
Plug 'jiangmiao/auto-pairs'
" @description: enhances netrw.
" @command: I gh ~
" let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

Plug 'tpope/vim-capslock'
" @description: temporary software caps lock.
" @command: <c-g>c or gC

Plug 'tpope/vim-surround'
" @description: easily delete, change and add such surroundings in pairs.
" @command: ds(, cs({, cS({, ysw(, ySw(, yss(, ySS(, S(, gS(

Plug 'junegunn/vim-easy-align'
Plug 'Yggdroot/indentLine'
Plug 'voldikss/vim-codelf'

"== enable fenced code block syntax highlighting in markdown documents
Plug 'tpope/vim-markdown'
"== Make the yanked region apparent!
Plug 'machakann/vim-highlightedyank'
"== a plugin to place, toggle and display marks.
Plug 'kshenoy/vim-signature'
"== comment plugin, Striving for minimalism
Plug 'tpope/vim-commentary'
"== This repository contains snippets files for various programming languages.
Plug 'honza/vim-snippets'
call plug#end()

let g:gruvbox_italic=1
let g:gruvbox_italicize_strings=1
let g:gruvbox_contrast_dark="hard"

nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>

nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?

set background=dark
colorscheme gruvbox
