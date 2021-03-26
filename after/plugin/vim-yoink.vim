" Plugin: svermeulen/vim-yoink
if !utils#has_plugin('vim-yoink')
  finish
endif

nmap <c-p> <plug>(YoinkPostPasteSwapBack)
nmap <c-n> <plug>(YoinkPostPasteSwapForward)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

" nmap [y <plug>(YoinkRotateBack)
" nmap ]y <plug>(YoinkRotateForward)
" nmap <c-=> <plug>(YoinkPostPasteToggleFormat)
