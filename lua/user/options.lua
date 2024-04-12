local options = {
    backup = false,
    -- cmdheight = 2,
    colorcolumn = "80",
    -- completeopt = { "menuone", "noselect"},
    conceallevel = 0,
    -- cursorline = false,
    expandtab = true,
    fileencoding = "utf-8",
    guicursor = "",
    guifont = "monospace:h17",
    hlsearch = false,
    incsearch = true,
    linebreak = true,
    number = true,
    relativenumber = true,
    scrolloff = 8,
    shiftwidth = 4,
    sidescrolloff = 8,
    -- showmode = false,
    -- showtabline = 2,
    signcolumn = "yes",
    smartcase = true,
    smartindent = true,
    softtabstop = 4,
    splitbelow = true,
    splitright = true,
    swapfile = false,
    tabstop = 4,
    termguicolors = true,
    timeoutlen = 300,
    undodir = os.getenv("HOME") .. "/.vim/undodir",
    undofile = true,
    updatetime = 50,
    whichwrap = "bs<>[]hl",
    wrap = false,
    writebackup = false
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.opt.formatoptions:remove({ "c", "r", "o" })
vim.opt.isfname:append "@-@"
vim.opt.shortmess:append "c"
