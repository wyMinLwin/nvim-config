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
			ensure_installed = { "lua_ls", "rust_analyzer", "svelte", "eslint", "pyright", "ast_grep" },
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
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},

		config = function()
			local conf = require("lspconfig")

			conf.lua_ls.setup({})
			conf.rust_analyzer.setup({})
			conf.prettier.setup({})
			conf.eslint.setup({
				settings = {
					validate = "on",
					experimental = {
						useFlatConfig = true, -- ✅ Required if you're using eslint.config.js
					},
				},
			})
            conf.ast_grep.setup({})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})

			vim.diagnostic.config({
				virtual_text = {
					prefix = "●", -- or "", "▶", "", etc.
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
