return {
    'goolord/alpha-nvim',
    requires = {
        'echasnovski/mini.icons',
        'nvim-lua/plenary.nvim'
    },
    config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
}
