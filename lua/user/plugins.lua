local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

-- Use a protected call so we don"t error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Install your plugins here
return packer.startup(function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.6",
        -- or                            , branch = "0.1.x",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    -- Treesitter
    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
    use("nvim-treesitter/playground")

    -- Harpoon
    use("ThePrimeagen/harpoon")

    -- Undotree
    use("mbbill/undotree")

    -- Fugitive
    use("tpope/vim-fugitive")

    -- LSP
    use "neovim/nvim-lspconfig"

    -- Mason
    use { "williamboman/mason.nvim" }
    use { "williamboman/mason-lspconfig.nvim" }

    -- Autocompletion
    use { "hrsh7th/nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lsp" }
    use { "hrsh7th/cmp-buffer" }
    use { "hrsh7th/cmp-path" }
    use { "hrsh7th/cmp-cmdline" }
    use { "L3MON4D3/LuaSnip", run = "make install_jsregexp" }
    use { "saadparwaiz1/cmp_luasnip" }
    use { "j-hui/fidget.nvim" }

    -- Autopairs
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    -- Comment
    use {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    }
    use "JoosepAlviste/nvim-ts-context-commentstring"

    -- Toggleterm
    use { "akinsho/toggleterm.nvim", tag = "*", config = function()
        require("toggleterm").setup()
    end }

    -- Colorschemes
    use "wojciechkepka/vim-github-dark"
    use {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    }
    use { "sonph/onehalf", rtp = "vim" }
    use "olimorris/onedarkpro.nvim"

    -- Codeium
    -- use "Exafunction/codeium.vim"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
