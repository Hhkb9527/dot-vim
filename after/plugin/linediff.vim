" Plugin: AndrewRadev/linediff.vim
if !utils#has_plugin('linediff.vim')
  finish
endif

vnoremap zd :Linediff<CR>
autocmd User LinediffBufferReady nnoremap <buffer> q :LinediffReset<CR>
