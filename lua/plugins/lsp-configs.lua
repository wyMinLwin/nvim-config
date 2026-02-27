return {
    {
        "mason-org/mason.nvim",
        opts = {},
        config = function()
            require("mason").setup()
            vim.keymap.set("n", "<leader>ms", ":Mason<CR>", {})
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "lua_ls", "svelte", "eslint", "pyright" },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "folke/lazydev.nvim",
                version = "*",
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
            { "saghen/blink.cmp" },
        },

        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            vim.lsp.config("lua_ls", { capabilities = capabilities })
            vim.lsp.enable("lua_ls")

            vim.lsp.config("pyright", { capabilities = capabilities })
            vim.lsp.enable("pyright")

            vim.lsp.config("svelte", { capabilities = capabilities })
            vim.lsp.enable("svelte")

            vim.lsp.config("eslint", {
                settings = {
                    validate = "on",
                    experimental = {
                        useFlatConfig = true,
                    },
                    workingDirectory = { mode = "location" },
                },
                capabilities = capabilities,
            })
            vim.lsp.enable("eslint")

            -- LSP keymaps only active in buffers with an attached server
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local opts = { buffer = args.buf }
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                end,
            })

            vim.diagnostic.config({
                virtual_text = {
                    prefix = "●",
                    spacing = 4,
                },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })
        end,
    },
}
