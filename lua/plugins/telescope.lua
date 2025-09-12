return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			require("telescope").setup({
				pickers = {
					git_files = {
						theme = "dropdown",
					},
					find_files = {
						theme = "dropdown",
					},
					current_buffer_fuzzy_find = {
						theme = "dropdown",
					},
				},
			})
			--vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
			vim.keymap.set("n", "<leader>ff", function()
				builtin.find_files({
					hidden = true,
				})
			end, { desc = "Telescope find files (tracked + untracked, .gitignore respected)" })
			vim.keymap.set("n", "<leader>fg", function()
				builtin.git_files({
					hidden = true,
				})
			end, { desc = "Telescope git files (tracked + untracked, .gitignore respected)" })

			vim.keymap.set("n", "<leader>fl", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
			vim.keymap.set(
				"n",
				"<leader>/",
				builtin.current_buffer_fuzzy_find,
				{ desc = "Fuzzy Search in current buffer" }
			)
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
				},
			})
			-- To get ui-select loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require("telescope").load_extension("ui-select")
		end,
	},
}
