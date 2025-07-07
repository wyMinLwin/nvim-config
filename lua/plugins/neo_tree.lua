return 
{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    lazy = false, -- neo-tree will lazily load itself
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
        -- fill any relevant options here
    },
    config = function() 
    
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
    end
}
