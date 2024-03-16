return {
  'nvimtools/none-ls.nvim',
  event = 'VeryLazy',
  config = function()
    local null_ls = require 'null-ls'
    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.eslintd,
        null_ls.builtins.completion.spell,
      },
      vim.keymap.set('n', '==', vim.lsp.buf.format, {}),
    }
  end,
}
