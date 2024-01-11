return {
    'folke/tokyonight.nvim',
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        style = "storm",
        light_style = "day",
        transparent = false,
        terminal_colors = true,
        styles = {
            comments = { italic = true },
            keywords = { italic = true },
            functions = {},
            variables = {},
            sidebars = "dark",
            floats = "dark",
        },
        sidebars = { "qf", "help" },
        day_brightness = 0.3,
        hide_inactive_statusline = false,
        dim_inactive = false,
        lualine_bold = false,
    },
    config = function()
        vim.cmd[[colorscheme tokyonight]]
    end
}
