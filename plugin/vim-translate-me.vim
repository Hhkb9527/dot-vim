" Plugin: voldikss/vim-translator
if !utils#has_plugin('vim-translator')
  finish
endif

nmap gY <Plug>Translate
vmap gY <Plug>TranslateV
