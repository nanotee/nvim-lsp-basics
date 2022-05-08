local M = {}
local lsp = vim.lsp

local formatting = lsp.buf.format and function()
    lsp.buf.format({ async = true })
end or lsp.buf.formatting

local formatting_sync = lsp.buf.format and function()
    lsp.buf.format({ async = false })
end or lsp.buf.formatting_sync

function M.format_command(range_given, line1, line2, bang)
    if range_given then
        lsp.buf.range_formatting(nil, {line1, 0}, {line2, math.huge})
    elseif bang then
        formatting_sync()
    else
        formatting()
    end
end

function M.code_action(range_given, line1, line2)
    if range_given then
        lsp.buf.range_code_action(nil, {line1, 0}, {line2, math.huge})
    else
        lsp.buf.code_action()
    end
end

return M
