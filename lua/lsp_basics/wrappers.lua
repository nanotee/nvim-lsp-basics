local M = {}
local lsp = vim.lsp

function M.format_command(range_given, line1, line2, bang)
    if range_given then
        lsp.buf.range_formatting(nil, {line1, 0}, {line2, 99999999})
    elseif bang then
        lsp.buf.formatting_sync()
    else
        lsp.buf.formatting()
    end
end

function M.code_action(range_given, line1, line2)
    if range_given then
        lsp.buf.range_code_action(nil, {line1, 0}, {line2, 99999999})
    else
        lsp.buf.code_action()
    end
end

return M
