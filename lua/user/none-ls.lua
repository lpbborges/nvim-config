local M = {
    "nvimtools/none-ls.nvim",
}

function M.config()
    local null_ls = require "null-ls"
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    null_ls.setup {
        debug = true,
        sources = {
            formatting.prettier,
            --        diagnostics.eslint,
        },
    }
end

return M
