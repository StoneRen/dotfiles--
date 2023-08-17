require("mason").setup()
local lsp = require('lsp-zero').preset({})
local bind = vim.keymap.set

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
  lsp.buffer_autoformat()
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/lsp.md#explicit-setup
lsp.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    -- ['lua_ls'] = { 'lua' },
    -- ['rust_analyzer'] = { 'rust' },
    -- ['ts-standard'] = { 'ts' },
    -- if you have a working setup with null-ls
    -- you can specify filetypes it can format.
    -- ['null-ls'] = { 'javascript', 'typescript' },
  }
})
-- lua
-- brew install lua-language-server

lsp.setup {}

bind('n', '<leader>ft', '<cmd>LspZeroFormat<cr>', { noremap = true, silent = true })
