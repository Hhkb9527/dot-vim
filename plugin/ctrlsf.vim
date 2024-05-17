" Plugin: dyng/ctrlsf.vim
if !utils#has_plugin('ctrlsf.vim')
  finish
endif

let g:ctrlsf_auto_preview = 1
let g:ctrlsf_auto_focus = { "at": "start" }
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_search_mode = 'async'
" let g:ctrlsf_default_view_mode = 'compact'

nmap     <leader>sf <Plug>CtrlSFCwordExec
nmap     <leader>sF <Plug>CtrlSFPrompt
vmap     <leader>sf <Plug>CtrlSFVwordExec
vmap     <leader>sF <Plug>CtrlSFVwordPath
nmap     <leader>sp <Plug>CtrlSFPwordPath
nnoremap <leader>so :CtrlSFOpen<CR>
nnoremap <leader>st :CtrlSFToggle<CR>
