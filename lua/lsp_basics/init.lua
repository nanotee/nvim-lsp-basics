local M = {}
local api = vim.api
local cmd = vim.api.nvim_command

local function make_lsp_commands(client)
    local cap
    if vim.fn.has('nvim-0.8.0') == 1 then
        cap = client.server_capabilities
    else
        cap = client.resolved_capabilities
    end
    if cap.code_action or cap.codeActionProvider then
        cmd 'command! -buffer -range LspCodeAction lua require("lsp_basics.wrappers").code_action(<range> ~= 0, <line1>, <line2>)'
    end
    if cap.rename or cap.renameProvider then
        cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'lsp_basics.completion'.rename LspRename lua vim.lsp.buf.rename(<f-args>)"
    end
    if cap.hover or cap.hoverProvider then
        cmd 'command! -buffer LspHover lua vim.lsp.buf.hover()'
    end
    if cap.signature_help or cap.signatureHelpProvider then
        cmd 'command! -buffer LspSignatureHelp lua vim.lsp.buf.signature_help()'
    end
    if cap.declaration or cap.declarationProvider then
        cmd 'command! -buffer LspDeclaration lua vim.lsp.buf.declaration()'
    end
    if cap.goto_definition or cap.definitionProvider then
        cmd 'command! -buffer LspDefinition lua vim.lsp.buf.definition()'
    end
    if cap.type_definition or cap.typeDefinitionProvider then
        cmd 'command! -buffer LspTypeDefinition lua vim.lsp.buf.type_definition()'
    end
    if cap.implementation or cap.implementationProvider then
        cmd 'command! -buffer LspImplementation lua vim.lsp.buf.implementation()'
    end
    if cap.find_references or cap.referencesProvider then
        cmd 'command! -buffer LspReferences lua vim.lsp.buf.references()'
    end
    if cap.document_symbol or cap.documentSymbolProvider then
        cmd 'command! -buffer LspDocumentSymbol lua vim.lsp.buf.document_symbol()'
    end
    if cap.workspace_symbol or cap.workspaceSymbolProvider then
        cmd "command! -buffer -nargs=? -complete=customlist,v:lua.require'lsp_basics.completion'.workspace_symbol LspWorkspaceSymbol lua vim.lsp.buf.workspace_symbol(<f-args>)"
    end
    if
        (cap.document_formatting or cap.document_range_formatting) or
        (cap.documentFormattingProvider or cap.documentRangeFormattingProvider)
    then
        cmd 'command! -buffer -range -bang LspFormat lua require("lsp_basics.wrappers").format_command(<range> ~= 0, <line1>, <line2>, "<bang>" == "!")'
    end
    if cap.call_hierarchy or cap.callHierarchyProvider then
        cmd 'command! -buffer LspIncomingCalls lua vim.lsp.buf.incoming_calls()'
        cmd 'command! -buffer LspOutgoingCalls lua vim.lsp.buf.outgoing_calls()'
    end
    cmd 'command! -buffer LspListWorkspaceFolders lua print(table.concat(vim.lsp.buf.list_workspace_folders(), "\\n"))'
    if
        (cap.workspace_folder_properties and cap.workspace_folder_properties.supported) or
        (cap.workspace and cap.workspace.workspaceFolders and cap.workspace.workspaceFolders.supported)
    then
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
