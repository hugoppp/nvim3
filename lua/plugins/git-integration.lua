return {
  -- {
  --   'tpope/vim-fugitive',
  --   event = 'VeryLazy',
  --   config = function()
  --     vim.keymap.set('n', '<leader>tb', ':G blame<CR>')
  --   end,
  -- },
  {
    'hugoppp/blame.nvim',
    -- 'FabijanZulj/blame.nvim',
    -- dir = '~/git/blame.nvim',
    event = 'VeryLazy',
    config = function()
      require('blame').setup {}
      vim.keymap.set('n', '<leader>tb', ':ToggleBlame virtual<CR>')
    end,
  },
  {
    'NeogitOrg/neogit',
    keys = { '<leader>gg' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'sindrets/diffview.nvim', opts = { enhanced_diff_hl = true } }, -- optional
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('neogit').setup {}
      vim.keymap.set('n', '<leader>gg', function()
        vim.api.nvim_command("silent wa")
        require('neogit').open { kind = 'auto' } end, { desc = 'neogit' })
    end,
  },
  -- {
  --   'kdheepak/lazygit.nvim',
  --   keys = { '<leader>gg', '<leader>gl' },
  --   cmd = {
  --     'LazyGit',
  --     'LazyGitConfig',
  --     'LazyGitCurrentFile',
  --     'LazyGitFilter',
  --     'LazyGitFilterCurrentFile',
  --   },
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     {
  --       'willothy/flatten.nvim',
  --       config = true,
  --       -- or pass configuration with
  --       -- opts = {  }
  --       -- Ensure that it runs first to minimize delay when opening file from terminal
  --       lazy = false,
  --       priority = 1001,
  --     },
  --   },
  --   config = function()
  --     vim.keymap.set('n', '<leader>gg', ':LazyGitCurrentFile<CR>', { desc = 'Git', silent = true })
  --     vim.keymap.set('n', '<leader>gl', ':LazyGitFilterCurrentFile<CR>', { desc = 'Git log', silent = true })
  --   end,
  -- },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      current_line_blame = true,
      on_attach = function(bufnr)
        local gs = require 'gitsigns'
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true })
        map('n', '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true })

        -- Actions
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'stage' })
        map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'stage' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'reset' })
        map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'reset' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'stage file' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'reset file' })
        map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview' })
        map('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = 'blame' })
        map('n', '<leader>hd', gs.diffthis, { desc = 'diff' })
        map('n', '<leader>hD', function() gs.diffthis '~' end, { desc = 'diff' })
        map('n', '<leader>td', gs.toggle_deleted, { desc = 'deleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
    },
  },
}
