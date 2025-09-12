return {
    "sainnhe/edge",
    lazy = false,
    priority = 1000,
    config = function()
        -- must be set BEFORE colorscheme
        vim.g.edge_enable_italic = true
        -- vim.g.edge_style = "neon"
        vim.g.edge_cursor = "yellow"
        vim.g.edge_better_performance = 1

        vim.cmd.colorscheme("edge")
    end,
}
