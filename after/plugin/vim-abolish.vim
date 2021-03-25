" Plugin: 'tpope/vim-abolish'
if !plugpac#has_plugin('vim-abolish')
  finish
endif

Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}
Abolish improt import
