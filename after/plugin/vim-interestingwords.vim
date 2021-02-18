" Plugin: lfv89/vim-interestingwords
if !plugpac#has_plugin('vim-interestingwords')
  finish
endif

noremap <silent> <leader>u :call InterestingWords('n')<cr>
noremap <silent> <leader>U :call UncolorAllWords()<cr>
" nnoremap <silent> n :call WordNavigation('forward')<cr>
" nnoremap <silent> N :call WordNavigation('backward')<cr>
let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF']
let g:interestingWordsRandomiseColors = 1
