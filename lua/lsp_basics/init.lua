local M = {}
local api = vim.api
local cmd = vim.api.nvim_command

local function make_lsp_commands(client)
    local cap = client.resolved_capabilities
    if cap.code_action then
        cmd 'command! -buffer -range LspCodeAction lua require("lsp_basics.wrappers").code_action(<range> ~= 0, <line1>, <line2>)'
    end
    if cap.rename then
        cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'lsp_basics.completion'.rename LspRename lua vim.lsp.buf.rename(<f-args>)"
    end
    if cap.hover then
        cmd 'command! -buffer LspHover lua vim.lsp.buf.hover()'
    end
    if cap.signature_help then
        cmd 'command! -buffer LspSignatureHelp lua vim.lsp.buf.signature_help()'
    end
    if cap.declaration then
        cmd 'command! -buffer LspDeclaration lua vim.lsp.buf.declaration()'
    end
    if cap.goto_definition then
        cmd 'command! -buffer LspDefinition lua vim.lsp.buf.definition()'
    end
    if cap.type_definition then
        cmd 'command! -buffer LspTypeDefinition lua vim.lsp.buf.type_definition()'
    end
    if cap.implementation then
        cmd 'command! -buffer LspImplementation lua vim.lsp.buf.implementation()'
    end
    if cap.find_references then
        cmd 'command! -buffer LspReferences lua vim.lsp.buf.references()'
    end
    if cap.document_symbol then
        cmd 'command! -buffer LspDocumentSymbol lua vim.lsp.buf.document_symbol()'
    end
    if cap.workspace_symbol then
        cmd "command! -buffer -nargs=? -complete=customlist,v:lua.require'lsp_basics.completion'.workspace_symbol LspWorkspaceSymbol lua vim.lsp.buf.workspace_symbol(<f-args>)"
    end
    if cap.document_formatting or cap.document_range_formatting then
        cmd 'command! -buffer -range -bang LspFormat lua require("lsp_basics.wrappers").format_command(<range> ~= 0, <line1>, <line2>, "<bang>" == "!")'
    end
    if cap.call_hierarchy then
        cmd 'command! -buffer LspIncomingCalls lua vim.lsp.buf.incoming_calls()'
        cmd 'command! -buffer LspOutgoingCalls lua vim.lsp.buf.outgoing_calls()'
    end
    cmd 'command! -buffer LspListWorkspaceFolders lua print(table.concat(vim.lsp.buf.list_workspace_folders(), "\\n"))'
    if cap.workspace_folder_properties.supported then
        cmd 'command! -buffer -nargs=? -complete=dir LspAddWorkspaceFolder lua vim.lsp.buf.add_workspace_folder(<q-args> ~= "" and vim.fn.fnamemodify(<q-args>, ":p"))'
        cmd 'command! -buffer -nargs=? -complete=customlist,v:lua.vim.lsp.buf.list_workspace_folders LspRemoveWorkspaceFolder lua vim.lsp.buf.remove_workspace_folder(<f-args>)'
    end
    cmd "command! -buffer LspLog execute '<mods> pedit +$' v:lua.vim.lsp.get_log_path()"
end

function M.make_lsp_commands(client, bufnr)
    api.nvim_buf_call(bufnr, function()
        make_lsp_commands(client)
    end)
end

function M.make_lsp_mappings(client, bufnr)
    -- TODO
end

return M
