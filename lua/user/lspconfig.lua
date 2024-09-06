local M = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
}

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    local keymap = vim.keymap.set

    keymap("n", "<leader>vd", function() vim.diagnostic.open_float() end)
    keymap("n", "[d", function() vim.diagnostic.goto_prev() end)
    keymap("n", "]d", function() vim.diagnostic.goto_next() end)
    keymap("n", "K", function() vim.lsp.buf.hover() end, opts)
    keymap("n", "gd", function() vim.lsp.buf.definition() end, opts)
    keymap("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    keymap("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    keymap("n", "gt", function() vim.lsp.buf.type_definition() end, opts)
    keymap("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    keymap("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    keymap("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    keymap("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    keymap("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
end

M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)

    if client.supports_method "textDocument/inlayHint" then
        vim.lsp.inlay_hint.enable(true)
    end
end

M.toggle_inlay_hints = function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
end

function M.common_capabilities()
    local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if status_ok then
        return cmp_nvim_lsp.default_capabilities()
    end

    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

    return lsp_capabilities
end

function M.config()
    local lspconfig = require "lspconfig"

    local servers = {
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

    vim.diagnostic.config({
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "E",
                [vim.diagnostic.severity.WARN] = "W",
                [vim.diagnostic.severity.HINT] = "H",
                [vim.diagnostic.severity.INFO] = "I",
            }
        },
        virtual_text = true,
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            header = "",
            prefix = "",
        },
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    require("lspconfig.ui.windows").default_options.border = "rounded"

    for _, server in pairs(servers) do
        if server == "tsserver" then
            server = "ts_ls"
        end
        local opts = {
            on_attach = M.on_attach,
            capabilities = M.common_capabilities(),
        }

        local require_ok, settings = pcall(require, "user.lspsettings." .. server)
        if require_ok then
            opts = vim.tbl_deep_extend("force", settings, opts)
        end

        lspconfig[server].setup(opts)
    end
end

return M
