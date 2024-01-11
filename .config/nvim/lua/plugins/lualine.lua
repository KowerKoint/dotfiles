return {
    'nvim-lualine/lualine.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require('lualine').setup({
            options = {
                path = 1
            },
        })
    end
}
