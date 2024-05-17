" Plugin: Yggdroot/LeaderF
if !utils#has_plugin('LeaderF')
  finish
endif

" 使用 :LeaderfInstallCExtension 安装模糊匹配算法的C扩展
if executable('rg')
  let g:Lf_DefaultExternalTool = 'rg'
endif

let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_MruMaxFiles=500
let g:Lf_ShowRelativePath = 1
let g:Lf_ShortcutF = ''
let g:Lf_StlColorscheme = 'default'
let g:Lf_StlSeparator = { 'left': '', 'right': ''  }
let g:Lf_StlSeparator = { 'left': '', 'right': ''  }
let g:Lf_ShowDevIcons = 1
let g:Lf_DevIconsFont = ""
let g:Lf_NormalMap = {
      \ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
      \ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']],
      \ "Mru":    [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
      \ "Tag":    [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<CR>']],
      \ "Function":    [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<CR>']],
      \ "Colorscheme":    [["<ESC>", ':exec g:Lf_py "colorschemeExplManager.quit()"<CR>']],
      \}
let g:Lf_WildIgnore = {
      \ 'dir': ['.svn', '.git'],
      \ 'file': ['*.bak', '*.exe', '*.so', '*.o', '*.py[co]', '*.sw?']
      \}

let g:leaderf_github_stars_username='Elijah-F'
" Max length of line, default is 100.
" If maxline is less than the longest repository name, only the repository name is shown.
" So you may set it to 0 to disable description.
let g:leaderf_github_stars_maxline=80

" Optional. Higher rate limit when using token
" let g:leaderf_github_stars_maxline = 'your github token'

nnoremap <Leader>fh :call <SID>search_here()<CR>
nnoremap <Leader>fp :call <SID>search_project()<CR>
nnoremap <Leader>fk :LeaderfMarks<CR>
noremap <Leader>fs :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
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
