local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = { { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true } },
    lazy = true,
    cmd = "Telescope",
}

local builtin = require("telescope.builtin")

-- File Pickers
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})

-- Vim Pickers
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

function M.config()
    local telescope_config = require("telescope.config")
    local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }

    require("telescope").setup {
        defaults = {
            vimgrep_arguments = vimgrep_arguments
        },
        pickers = {
            find_files = {
                find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" }
            }
        },
        extensions = {
            fzf = {
                fuzzy = true,                   -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true,    -- override the file sorter
                case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            },
        }
    }
end

return M
