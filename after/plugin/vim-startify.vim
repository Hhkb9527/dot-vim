" Plugin: mhinz/vim-startify
if !plugpac#has_plugin('vim-startify')
  finish
endif

" let g:ascii = [
    " \"             ________ ++     ________             ",
    " \"            /VVVVVVVV\++++  /VVVVVVVV\\           ",
    " \"            \VVVVVVVV/++++++\VVVVVVVV/            ",
    " \"             |VVVVVV|++++++++/VVVVV/'             ",
    " \"             |VVVVVV|++++++/VVVVV/'               ",
    " \"            +|VVVVVV|++++/VVVVV/'+                ",
    " \"          +++|VVVVVV|++/VVVVV/'+++++              ",
    " \"        +++++|VVVVVV|/VVV___++++++++++            ",
    " \"          +++|VVVVVVVVVV/##/ +_+_+_+_             ",
    " \"            +|VVVVVVVVV___ +/#_#,#_#,\\           ",
    " \"             |VVVVVVV//##/+/#/+/#/'/#/            ",
    " \"             |VVVVV/'+/#/+/#/+/#/ /#/             ",
    " \"             |VVV/'++/#/+/#/ /#/ /#/              ",
    " \"             'V/'  /##//##//##//###/              ",
    " \"                      ++                          ",
    " \"                                                  ",
    " \"                                                  ",
    " \]
" let g:startify_custom_header = g:ascii + startify#fortune#boxed()
let g:startify_skiplist = [
    \ 'COMMIT_EDITMSG',
    \ 'bundle/.*/doc',
    \ '/data/repo/neovim/runtime/doc',
    \ '/Users/mhi/local/vim/share/vim/vim74/doc',
    \ ]
let g:startify_bookmarks = [
    \ { 'c': $VIMRC  },
    \ ]
let g:startify_transformations = [
    \ ['.*vimrc$', 'vimrc'],
    \ ]
let g:startify_list_order = [
    \ ['   MRU:'],
    \ 'files',
    \ ]
" let g:startify_change_to_dir = 0
" let g:startify_enable_special = 0
" let g:startify_files_number = 15
let g:startify_update_oldfiles = 1
let g:startify_use_env = 1

function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction
