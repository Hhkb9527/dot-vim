nmap <silent> ]s <Plug>(ale_next_wrap)
nmap <silent> [s <Plug>(ale_previous_wrap)
nmap <silent> <leader>alx <Plug>(ale_fix)
nmap <silent> <leader>+ <Plug>(ale_enable_buffer)]

let g:ale_fix_on_save = 0
let g:ale_set_highlights = 0
let g:ale_sign_error = '☠ '
let g:ale_sign_warning = '☢ '
let g:ale_statusline_format = ['☠  %d', '☢  %d', '☪  OK']
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" ~/.pylintc中不能存在bug，否则linter将不会生效，可以提前使用python命令检测
let g:ale_linters = {
  \ 'javascript': ['eslint'],
  \ 'typescript': ['eslint'],
  \ 'python': ['pylint'],
  \ }
let g:ale_fixers = {
  \ 'vim': [],
  \ 'javascript': ['prettier', 'eslint'],
  \ 'typescript': ['prettier', 'eslint'],
  \ 'javascriptreact': ['prettier', 'eslint'],
  \ 'typescriptreact': ['prettier', 'eslint'],
  \ 'json': ['jq'],
  \ 'html': ['tidy'],
  \ 'c': ['clang-format'],
  \ 'cpp': ['clang-format'],
  \ 'python': ['autopep8', 'isort'],
  \ }
