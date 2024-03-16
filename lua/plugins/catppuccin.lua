return {
  'catppuccin/nvim',
  lazy = false,
  priority = 1000,
  opts = {
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      mason = true,
      notify = false,
      min = {
        enabled = true,
        indentscope_color = '',
      },
    },
  },
  config = function() vim.cmd.colorscheme 'catppuccin' end,
}
