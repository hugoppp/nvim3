return {
  {
    event = 'VeryLazy',
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim',
    },
    opts = {},
    config = function()
      vim.keymap.set({ 'n', 'x' }, '<leader>ii', ':Refactor inline_var')
      vim.keymap.set('n', '<leader>II', ':Refactor inline_func')

      vim.keymap.set('x', '<leader>im', ':Refactor extract ')
      vim.keymap.set('x', '<leader>iv', ':Refactor extract_var ')
      vim.keymap.set('x', '<leader>iM', ':Refactor extract_to_file ')

      require('telescope').load_extension 'refactoring'
      vim.keymap.set({ 'n', 'x' }, '<leader>rr', function() require('telescope').extensions.refactoring.refactors() end)
    end,
  },
  {
    event = 'InsertEnter',
    'mizlan/iswap.nvim',
  },
}
