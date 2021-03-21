" Plugin: tpope/vim-markdown
if !plugpac#has_plugin('vim-markdown')
  finish
endif

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'cpp', 'c', 'go']
let g:markdown_syntax_conceal = 0
let g:markdown_minlines = 100
