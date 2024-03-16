return {
  'nvim-neo-tree/neo-tree.nvim',
  event = 'VeryLazy',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  opts = {
    close_if_last_window = true,
    event_handlers = {
      {
        event = 'file_opened',
        handler = function() require('neo-tree.command').execute { action = 'close' } end,
      },
    },
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)
    vim.keymap.set('n', '<leader>ff', ':Neotree filesystem reveal left<CR>', { silent = true, desc = '[F]iletree' })

    vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
    vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
    vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })
  end,
}
