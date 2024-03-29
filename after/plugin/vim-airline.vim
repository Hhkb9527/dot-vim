" Plugin: vim-airline/vim-airline
if !utils#has_plugin('vim-airline')
  finish
endif

let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'

" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_alt_sep = ''
"
let g:airline_left_sep = '   '
let g:airline_right_sep = '   '

let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.notexists = 'Ɇ'
