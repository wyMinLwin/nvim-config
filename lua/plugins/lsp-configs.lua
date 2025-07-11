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
			ensure_installed = { "lua_ls", "rust_analyzer", "svelte-language-server", "eslint-lsp", "pyright" },
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				-- ft = "lua", -- only load on lua files
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
