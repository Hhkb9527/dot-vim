" Plugin: junegunn/vim-easy-align
if !plugpac#has_plugin('vim-easy-align')
  finish
endif

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <cr> <plug>(LiveEasyAlign)
