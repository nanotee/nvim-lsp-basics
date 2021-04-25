function! lsp_basics#completion#rename(ArgLead, CmdLine, CursorPos) abort
    return expand('<cword>')
endfunction

let s:Lua_workspace_symbol_complete = luaeval('require("lsp_basics.completion").workspace_symbol')

function! lsp_basics#completion#workspace_symbol(ArgLead, CmdLine, CursorPos) abort
    return s:Lua_workspace_symbol_complete(a:ArgLead)
endfunction
