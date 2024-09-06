local M = {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "nvim-lua/plenary.nvim",
    },
}

M.execs = {
    "bashls",
    "cssls",
    "eslint",
    "gopls",
    "html",
    "jsonls",
    "lua_ls",
    "tailwindcss",
    "tsserver",
    "rust_analyzer",
    "yamlls",
}

function M.config()
    require("mason").setup {
        ui = {
            border = "rounded",
        },
    }
    require("mason-lspconfig").setup {
        ensure_installed = M.execs,
    }
end

return M
