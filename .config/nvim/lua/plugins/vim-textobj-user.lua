return {
    {
        'kana/vim-textobj-entire',
        event = 'BufRead',
        dependencies = { 'kana/vim-textobj-user' },
    },
    {
        'kana/vim-textobj-line',
        event = 'BufRead',
        dependencies = { 'kana/vim-textobj-user' },
    },
    {
        'kana/vim-textobj-function',
        event = 'BufRead',
        dependencies = { 'kana/vim-textobj-user' },
    },
    {
        'mattn/vim-textobj-url',
        event = 'BufRead',
        dependencies = { 'kana/vim-textobj-user' },
    },
    {
        'h1mesuke/textobj-wiw',
        event = 'BufRead',
        dependencies = { 'kana/vim-textobj-user' },
    },
    {
        'sgur/vim-textobj-parameter',
        event = 'BufRead',
        dependencies = { 'kana/vim-textobj-user' },
        config = function()
            vim.g.vim_textobj_parameter_mapping = ','
        end,
    },
}
