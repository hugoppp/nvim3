return {
  'folke/which-key.nvim',
  config = function()
    local wk = require 'which-key'
    -- As an example, we will create the following mappings:
    --  * <leader>ff find files
    --  * <leader>fr show recent files
    --  * <leader>fb Foobar
    -- we'll document:
    --  * <leader>fn new file
    --  * <leader>fe edit file
    -- and hide <leader>1

    wk.register({
      s = { name = 'search' },
      f = { name = 'files' },
      g = { name = 'git' },
      r = { name = 'refactor' },
      t = { name = 'toggle' },
      h = { name = 'hunk' },
      c = { name = 'code' },
      i = { name = 'inline' },
      e = 'which_key_ignore',
      I = 'which_key_ignore',
    }, { prefix = '<leader>' })
  end,
}
