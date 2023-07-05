local bind = vim.keymap.set
require("toggleterm").setup {
    open_mapping = [[<c-\>]]
}
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  -- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  bind('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  bind('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  bind('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  bind('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  bind('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
