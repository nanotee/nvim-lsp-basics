local fn = vim.fn
local lsp = vim.lsp

local M = {}

function M.workspace_symbol(arglead)
    local query_results = lsp.buf_request_sync(0, "workspace/symbol", {query = arglead}, 1000) or {{}}
    local symbols = query_results[1].result or {}
    return vim.tbl_map(function(symbol) return symbol.name end, symbols)
end

return M
