return {
  { 'stevearc/dressing.nvim', opts = {} },
  -- Useful status updates for LSP.
  { 'j-hui/fidget.nvim', opts = {}, event = 'VeryLazy' },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = { theme = 'catppuccin' },
  },
  {
    'nanozuki/tabby.nvim',
    event = 'VimEnter',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('tabby.tabline').use_preset('tab_only', {
        lualine_theme = 'catppuccin',
      })
    end,
  },
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    version = '*',
    opts = { open_mapping = [[<c-\>]] },
    winbar = {
      enabled = false,
      name_formatter = function(term) --  term: Terminal
        return term.name
      end,
    },
  },
}
