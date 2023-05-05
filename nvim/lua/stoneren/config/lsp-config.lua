local lsp = require('lsp-zero').preset({})
local bind = vim.keymap.set

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

-- lua
-- brew install lua-language-server

lsp.setup {}

bind('n', '<leader>ft', '<cmd>LspZeroFormat<cr>', { noremap = true, silent = true })

