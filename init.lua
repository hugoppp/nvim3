local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require 'vim-options'
require('lazy').setup {
  { import = 'plugins' },
  { 'numToStr/Comment.nvim', opts = {}, event = 'VeryLazy' },
  { 'wakatime/vim-wakatime', lazy = false },
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
  },
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
  },
  {
    'chrisgrieser/nvim-various-textobjs',
    event = 'VeryLazy',
    opts = { useDefaultKeymaps = true },
  },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    opts = {},
  },
  {
    'akinsho/toggleterm.nvim',
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

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('restore_session', { clear = true }),
  callback = function()
    if vim.fn.getcwd() ~= vim.env.HOME and #vim.fn.argv() == 0 then
      vim.api.nvim_create_autocmd('VimEnter', {
        group = vim.api.nvim_create_augroup('restore_session', { clear = true }),
        callback = function()
          if vim.fn.getcwd() ~= vim.env.HOME then
            require('persistence').load()
          end
        end,
        nested = true,
      })
      require('persistence').load()
    end
  end,
  nested = true,
})
