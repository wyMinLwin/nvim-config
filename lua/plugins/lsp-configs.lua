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

			vim.lsp.config("rust_analyzer", {})
			vim.lsp.config("eslint_d", {
				settings = {
					validate = "on",
					experimental = {
						useFlatConfig = true,
					},
					workingDirectory = { mode = "location" },
				},
                capabilities = capabilities
			})
			vim.lsp.config("ast_grep", {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})

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
  end,  },
}
