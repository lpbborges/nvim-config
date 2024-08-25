vim.keymap.set("n", "<leader>vd", "<cmd>lua vim.diagnostic.open_float()<cr>")
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
    callback = function(event)
        local opts = { buffer = event.buf }
        local keymap = vim.keymap.set

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
    end,
})

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local default_setup = function(server_name)
    require("lspconfig")[server_name].setup({
        capabilities = lsp_capabilities,
    })
end

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = {
        "cssls",
        "eslint",
        "html",
        "jsonls",
        "lua_ls",
        "tailwindcss",
        "tsserver",
        "rust_analyzer",
        "yamlls",
    },
    handlers = {
        default_setup,
        lua_ls = function()
            require("lspconfig").lua_ls.setup({
                capabilities = lsp_capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT"
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                vim.env.VIMRUNTIME,
                            }
                        }
                    }
                }
            })
        end,
    },
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "buffer" },
    })
})

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
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
})
