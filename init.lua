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
  {
    'chrisgrieser/nvim-various-textobjs',
    lazy = false, -- so that comment will be loaded after this (conflict gcc)
    opts = { useDefaultKeymaps = true },
  },
  { 'numToStr/Comment.nvim', opts = {}, event = 'VeryLazy' },
  { 'wakatime/vim-wakatime', lazy = false },
  { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    opts = {},
  },
  {
    'rmagatti/auto-session',
    opts = { log_level = 'error', auto_session_allowed_dirs = { '~/git/*', '~/.config/nvim' } },
    config = function(_, opts)
      require('auto-session').setup(opts)
      vim.keymap.set('n', '<leader>ss', require('auto-session.session-lens').search_session)
    end,
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

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertLeave', 'BufWinLeave' }, {
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand '%' ~= '' and vim.bo.buftype == '' then
      vim.api.nvim_command 'silent update'
      require('neogit').refresh_manually(vim.fn.expand '%')
    end
  end,
})

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  callback = function()
    if vim.api.nvim_get_mode() ~= 'c' then
      vim.cmd.checktime()
    end
  end,
})

vim.api.nvim_create_autocmd('FileChangedShellPost', {
  callback = function() print 'buffer updated' end,
})
