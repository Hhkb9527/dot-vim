" Plugin: tpope/vim-commentary
if !plugpac#has_plugin('vim-commentary')
  finish
endif

autocmd FileType apache setlocal commentstring=#\ %s
