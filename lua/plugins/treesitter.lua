return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup({
            modules = {},
            -- a list of parser names, or "all" (the listed parsers must always be installed)
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "markdown",
                "markdown_inline",
                "javascript",
                "typescript",
                "svelte",
                "rust",
                "css",
                "c_sharp",
                "python",
            },

            -- install parsers synchronously (only applied to ensure_installed)
            sync_install = false,

            -- automatically install missing parsers when entering buffer
            -- recommendation: set to false if you don't have tree-sitter cli installed locally
            auto_install = true,

            -- list of parsers to ignore installing (or "all")
            ignore_install = {},

            ---- if you need to change the installation directory of the parsers (see -> advanced setup)
            -- parser_install_dir = "/some/path/to/store/parsers", -- remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

            highlight = {
                enable = true,

                -- note: these are the names of the parsers and not the filetype. (for example if you want to
                -- disable highlighting for the tex filetype, you need to include latex in this list as this is
                -- the name of the parser)
                -- list of language that will be disabled
                -- disable = {},
                -- or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                disable = function(_, buf)
                    local max_filesize = 100 * 1024 -- 100 kb
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,

                -- setting this to true will run :h syntax and tree-sitter at the same time.
                -- set this to true if you depend on 'syntax' being enabled (like for indentation).
                -- using this option may slow down your editor, and you may see some duplicate highlights.
                -- instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
        })
    end,
}
