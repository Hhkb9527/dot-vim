" Plugin: tpope/vim-commentary
if !utils#has_plugin('vim-commentary')
  finish
endif

autocmd FileType apache setlocal commentstring=#\ %s
