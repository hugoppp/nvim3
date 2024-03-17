local function telescope_doucment_methods() require('telescope.builtin').lsp_document_symbols { symbols = 'function', prompt_title = 'Document Methods' } end
local function telescope_methods() require('telescope.builtin').lsp_workspace_symbols { symbols = 'function', prompt_title = 'All Methods' } end
local function telescope_classes() require('telescope.builtin').lsp_workspace_symbols { symbols = 'class', prompt_title = 'All Classes' } end
local function telescope_document_classes() require('telescope.builtin').lsp_workspace_symbols { symbols = 'class', prompt_title = 'Document Classes' } end
local function telescope_find_files_hidden() require('telescope.builtin').find_files { find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' } } end

return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()
      local map = function(keys, func, desc) vim.keymap.set('n', keys, func, { desc = desc }) end

      local builtin = require 'telescope.builtin'

      map('<leader>fa', telescope_find_files_hidden, 'Files all')
      map('<leader>fr', builtin.oldfiles, 'Files recent')

      map('<leader>sa', builtin.live_grep, 'Search all')
      map('<leader>st', builtin.current_buffer_fuzzy_find, 'Search this')
      map('<leader>sw', builtin.grep_string, 'Search word')
      map('<leader>se', builtin.diagnostics, 'Search errors')
      map('<leader>sh', builtin.help_tags, 'Search help')
      map('<leader>gb', builtin.git_branches, 'Git bbranches')

      map('<leader>sm', telescope_doucment_methods, 'LSP: Search methods')
      map('<leader>sM', telescope_methods, 'LSP: Search all mmethods')
      map('<leader>sc', telescope_document_classes, 'LSP: Search classes')
      map('<leader>sC', telescope_classes, 'LSP: Search classes')

      map('<leader>p', builtin.registers, 'Paste from register')
    end,
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {},
          },
        },
      }
      -- To get ui-select loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require('telescope').load_extension 'ui-select'
    end,
  },
}
