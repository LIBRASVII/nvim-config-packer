local lsp_zero = require('lsp-zero')
lsp_zero.extend_lsconfig()

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

lsp_zero.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = '»',
})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'rust_analyzer', 'clangd', 'lua_ls'},
  handlers = {
    lsp_zero.default_setup,
  },
})
