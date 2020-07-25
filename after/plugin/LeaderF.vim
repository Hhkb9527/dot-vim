if executable('rg')
  let g:Lf_DefaultExternalTool = 'rg'
endif

let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_MruMaxFiles=500
let g:Lf_ShowRelativePath = 1
let g:Lf_ShortcutF = ''
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2" }
noremap <Leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <Leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <Leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <Leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR><CR>
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR><CR>


function! s:search_here() abort
  let l:sv = get(g:, 'Lf_WorkingDirectoryMode', 'c')
  let g:Lf_WorkingDirectoryMode = 'f'
  execute 'LeaderfFile'
  let g:Lf_WorkingDirectoryMode = l:sv
endfunction

function! s:search_project() abort
  let l:sv = get(g:, 'Lf_WorkingDirectoryMode', 'c')
  let g:Lf_WorkingDirectoryMode = 'A'
  execute 'LeaderfFile'
  let g:Lf_WorkingDirectoryMode = l:sv
endfunction

nnoremap <leader>fh  :call <SID>search_here()<CR>
nnoremap <leader>fp  :call <SID>search_project()<CR>
