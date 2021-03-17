" Plugin: mhinz/vim-startify
if !plugpac#has_plugin('vim-startify')
  finish
endif

let g:startify_list_order = [
    \ ['   MRU:'],
    \ 'files',
    \ ]

let g:startify_update_oldfiles = 1
let g:startify_use_env = 1
