" TODO: refact this function with vim-plug interface
function! utils#has_plugin(plugin)
    return index(s:get_plugin_list(), a:plugin) != -1
endfunction

function! s:get_plugin_list()
    if exists("s:plugin_list")
        return s:plugin_list
    endif
    let l:pat = 'plugged/*'
    let s:plugin_list = filter(globpath(&packpath, l:pat, 0, 1), {-> isdirectory(v:val)})
    call map(s:plugin_list, {-> substitute(v:val, '^.*[/\\]', '', '')})
    return s:plugin_list
endfunction
