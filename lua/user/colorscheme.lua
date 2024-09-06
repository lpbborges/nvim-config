local M = {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
}

function M.config()
    vim.cmd.colorscheme "onedark"
end

return M
