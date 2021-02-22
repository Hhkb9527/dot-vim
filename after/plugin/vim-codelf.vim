" Plugin: voldikss/vim-codelf
if !plugpac#has_plugin('vim-codelf')
  finish
endif

inoremap <silent> <F9> <C-R>=codelf#start()<CR>
nnoremap <silent> <F9> :call codelf#start()<CR>
