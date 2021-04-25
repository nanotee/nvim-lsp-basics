local M = {}
local lsp = vim.lsp

function M.format_command(bang)
    if bang then
        lsp.buf.formatting_sync()
    else
        lsp.buf.formatting()
    end
end

function M.code_action(range_given)
    if range_given then
        lsp.buf.range_code_action()
    else
        lsp.buf.code_action()
    end
end

return M
