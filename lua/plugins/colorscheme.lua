return 
{
    'marko-cerovac/material.nvim',
    config = function()
        vim.cmd([[colorscheme material]])
        require('material.functions').change_style("darker")
    end,
}
