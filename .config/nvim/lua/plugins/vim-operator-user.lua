return {
    {
        'kana/vim-operator-replace',
        event = 'BufRead',
        dependencies = { 'kana/vim-operator-user' },
        config = function()
            vim.keymap.set('n', 'R', '<Plug>(operator-replace)', { silent = true })
        end,
    },
}
