" Plugin: junegunn/goyo.vim
if !plugpac#has_plugin('goyo.vim')
  finish
endif

map <Leader>gy :Goyo<CR>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
