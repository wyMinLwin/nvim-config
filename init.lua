vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

require("config.lazy")
--vim.o.background = "dark" -- or "light" for light mode
--vim.cmd([[colorscheme kanagawa]])

local builtin = require('telescope.builtin')
require('telescope').setup{
  pickers = {
    git_files = {
      theme = "dropdown",
    }
},
}

require("neo-tree").setup({
  sources = { "filesystem", "git_status", "buffers" }, -- this line is important
  filesystem = {
    follow_current_file = { enabled = true }, -- optional: focus current file
    use_libuv_file_watcher = true,            -- auto-update files
    filtered_items = {
      hide_gitignored = false,                -- show .gitignored files if needed
    },
  },
  default_component_configs = {
    git_status = {
      symbols = {
        added     = "A",
        modified  = "M",
        deleted   = "D",
        renamed   = "R",
        untracked = "?",
        ignored   = "◌",
        unstaged  = "✗",
        staged    = "✓",
        conflict  = "",
      }
    }
  }
})

--vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>ff', function()
  builtin.git_files({ show_untracked = true })
end, { desc = 'Telescope git files (tracked + untracked, .gitignore respected)' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>n',':Neotree filesystem reveal left<CR>',{})
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "javascript", "typescript", "svelte", "rust", "css", "c_sharp" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = {},

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {},
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require('lualine').setup()

