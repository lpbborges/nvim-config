local telescope = require("telescope")
local telescope_config = require("telescope.config")
local builtin = require("telescope.builtin")

local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }

-- File Pickers
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})

-- Vim Pickers
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

telescope.setup {
    defaults = {
        vimgrep_arguments = vimgrep_arguments
    },
    pickers = {
        find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" }
        }
    }
}
