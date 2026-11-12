return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup{}
    vim.keymap.set('n', '<leader>t', function()
      require('nvim-tree.api').tree.toggle()
    end)
  end,
}
