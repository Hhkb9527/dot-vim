finish

let s:is_tty = !match(&term, 'linux') || !match(&term, 'win32')
let g:lightline#bufferline#enable_devicons=1

let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \   'left':  [ [ 'mode', 'paste' ], [ 'fugitive', 'filename', "readonly" ] ],
    \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'cocstatus', 'fileencoding', 'fileformat', 'filetype' ] ]
    \ },
    \ 'tabline': {
    \   'left': [ ['buffers'] ],
    \   'right': [ ['close'] ]
    \ },
    \ 'inactive': {
    \   'left':  [ [ 'filename' ] ],
    \   'right': [ [ 'lineinfo', 'percent' ] ]
    \ },
    \ 'component_function': {
    \   'modified'    :  'LightlineModified',
    \   'readonly'    :  'LightlineReadonly',
    \   'fugitive'    :  'LightlineFugitive',
    \   'filename'    :  'LightlineFilename',
    \   'fileformat'  :  'LightlineFileformat',
    \   'filetype'    :  'LightlineFiletype',
    \   'fileencoding':  'LightlineFileencoding',
    \   'mode'        :  'LightlineMode',
    \   'cocstatus'   :  'coc#status',
    \ },
    \ 'component_expand': {
    \   'buffers': 'lightline#bufferline#buffers'
    \ },
    \ 'component_type': {
    \   'buffers': 'tabsel'
    \ }
    \ }

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()


function! LightlineFugitive() "[[[4
  try
    if expand('%:t') !~? 'Tagbar\|Mundo\|NERD' && &filetype !~? 'vimfiler' && exists('*fugitive#head')
      let l:mark = ''  " edit here for cool mark
      let l:branch = fugitive#head()
      return l:branch !=# '' ? (s:is_tty ? '' : "\ue0a0 ").l:branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineReadonly() "[[[4
  return &filetype !~? 'help\|vimfiler\|Mundo\|qf' && &readonly ? (s:is_tty ? 'RO' : "\ue0a2") : ''
endfunction


function! LightlineModified() "[[[4
  return &filetype =~# 'help\|vimfiler\|Mundo\|qf' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineFilename() "[[[4
  if &filetype ==# 'qf'
    let wininfo = filter(getwininfo(), {i,v -> v.winnr == winnr()})[0]
    if wininfo.loclist
      return "[Location List]"
    else
      return "[Quickfix List]"
    endif
  endif

  let l:fname = expand('%:~')
  return l:fname ==# '__Tagbar__' ? g:lightline.l:fname :
        \ l:fname =~# '__Mundo\|NERD_tree' ? '' :
        \ &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'denite' ? denite#get_status_sources() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ ('' !=# LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' !=# l:fname ? l:fname : '[No Name]') .
        \ ('' !=# LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineMode() "[[[4
  let l:fname = expand('%:t')
  return l:fname ==# '__Tagbar__' ? 'Tagbar' :
        \ l:fname =~# 'NERD_tree' ? 'NERDTree' :
        \ &filetype ==# 'denite' ? 'Denite' :
        \ &filetype ==# 'vimfiler' ? 'VimFiler' :
        \ &filetype ==# 'vimshell' ? 'VimShell' :
        \ lightline#mode()[0]
        "\ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineFileformat() "[[[4
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype() "[[[4
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding() "[[[4
  return winwidth(0) > 70 ? (&fileencoding !=# '' ? &fileencoding : &encoding) : ''
endfunction
