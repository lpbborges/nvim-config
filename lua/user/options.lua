local options = {
    backup = false,
    breakindent = true,
    clipboard = "unnamedplus",
    cmdheight = 1,
    completeopt = { "menuone", "noselect" },
    colorcolumn = { "80", "120" },
    conceallevel = 0,
    expandtab = true,
    fileencoding = "utf-8",
    guicursor = "a:blinkon0",
    guifont = "monospace:h17",
    hlsearch = false,
    ignorecase = true,
    incsearch = true,
    inccommand = "split",
    laststatus = 3,
    linebreak = true,
    number = true,
    pumheight = 10,
    relativenumber = true,
    ruler = false,
    scrolloff = 0,
    shiftwidth = 4,
    showcmd = false,
    --showmode = false,
    sidescrolloff = 8,
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
    title = true,
    titlelen = 0,
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
