local M = {
    "nvim-treesitter/nvim-treesitter",
}

function M.config()
    require("nvim-treesitter.configs").setup {
        ensure_installed = {
            "bash",
            "c",
            "javascript",
            "lua",
            "markdown",
            "markdown_inline",
            "typescript",
            "vim",
            "vimdoc",
            "query"
        },
        sync_install = false,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        auto_install = true,
        indent = {
            enable = true,
            disable = { "yaml" },
        },
        autopairs = { enable = true },
    }
end

return M
