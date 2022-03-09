" Plugin: neoclide/coc.nvim
if !utils#has_plugin('coc.nvim') || matchstr(&rtp, 'coc.nvim') == ''
  finish
endif

let g:coc_global_extensions = [
      \ 'coc-tsserver',
      \ 'coc-pyright',
      \ 'coc-json',
      \ 'coc-snippets',
      \ 'coc-vimlsp',
      \ 'coc-yaml',
      \ 'coc-go',
      \ 'coc-clangd',
      \ 'coc-emoji',
      \ 'coc-html',
      \ 'coc-prettier',
      \ ]

if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

" Make `<c-k>` used for trigger completion, completion confirm, snippet expand and jump.
inoremap <silent><expr> <c-k>
    \ pumvisible() ? coc#_select_confirm() :
    \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ coc#refresh()
let g:coc_snippet_prev = '<c-p>'

" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nmap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Symbol renaming
nmap <F2> <Plug>(coc-rename)

" 针对不同文件类型制定自动格式化工具
autocmd FileType html nnoremap <buffer> <leader>alx :CocCommand prettier.forceFormatDocument<CR>
autocmd FileType javascript nnoremap <buffer> <leader>alx :CocCommand prettier.forceFormatDocument<CR>
autocmd FileType typescript nnoremap <buffer> <leader>alx :CocCommand prettier.forceFormatDocument<CR>
autocmd FileType vue nnoremap <buffer> <leader>alx :CocCommand prettier.forceFormatDocument<CR>
