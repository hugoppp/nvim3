return {
  {
    'NeogitOrg/neogit',
    keys = { '<leader>gg'},
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'sindrets/diffview.nvim', opts = { enhanced_diff_hl = true } }, -- optional
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('neogit').setup {}
      vim.keymap.set('n', '<leader>gg', function() require('neogit').open { kind = 'auto' } end)
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
        map('n', '<leader>hs', gs.stage_hunk)
        map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end)
        map('n', '<leader>hr', gs.reset_hunk)
        map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end)
        map('n', '<leader>hS', gs.stage_buffer)
        map('n', '<leader>hu', gs.undo_stage_hunk)
        map('n', '<leader>hR', gs.reset_buffer)
        map('n', '<leader>hp', gs.preview_hunk)
        map('n', '<leader>hb', function() gs.blame_line { full = true } end)
        map('n', '<leader>tb', gs.toggle_current_line_blame)
        map('n', '<leader>hd', gs.diffthis)
        map('n', '<leader>hD', function() gs.diffthis '~' end)
        map('n', '<leader>td', gs.toggle_deleted)

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
    },
  },
}