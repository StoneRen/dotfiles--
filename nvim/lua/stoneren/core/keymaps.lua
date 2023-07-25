local global = vim.g
local bind = vim.keymap.set
local setkeymap = vim.api.nvim_set_keymap
local defaultKeyOption = { noremap = true, silent = true }

-- Map <leader> to space
global.mapleader = ' '
global.maplocalleader = ' '

-- https://vonheikemen.github.io/devlog/tools/build-your-first-lua-for-neovim/
--[[
vim.bind({mode}, {lhs}, {rhs}, {opts})

mode:
n: 普通模式
i: 插入模式
x：可视模式
s: 选择模式
v: 视觉+选择
t: 终端模式
o：操作员待定
'': 一个空字符串。相当于 n + v + o

lhs: 绑定的快捷键
rhs: 执行的动作

opts: 设置
desc: 描述
remap: 布尔值，绑定键是否递归。默认值为false，建议不要启动
buffer: 可以是布尔值或数字。如果我们分配布尔值 true ，这意味着键绑定将只在当前文件中有效。如果我们分配一个数字，它需要是一个打开的缓冲区的“id”
silent: 布尔值，确定绑定键是否显示消息
expr: 通过vimscript或lua计算 {rhs} 的值
--]]
-- basic keymaps
bind("n", "<leader>w", ":w<CR>") -- save
bind("n", "<leader>q", ":q<CR>") -- quit
bind("n", "<leader>qq", ":qa!<CR>") -- quit all without saving
bind("n", "<leader>,", ":tabnew ~/.config/nvim/init.lua")
bind('n', '<leader>a', ':keepjumps normal! ggVG<cr>', defaultKeyOption, "全选") -- select all

-- https://neovide.dev/faq.html#how-can-i-use-cmd-ccmd-v-to-copy-and-paste
if vim.g.neovide then
  bind('n', '<D-s>', ':w<CR>')      -- Save
  bind('v', '<D-c>', '"+y')         -- Copy
  bind('n', '<D-v>', '"+P')         -- Paste normal mode
  bind('v', '<D-v>', '"+P')         -- Paste visual mode
  bind('c', '<D-v>', '<C-R>+')      -- Paste command mode
  bind('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
end
setkeymap('', '<D-v>', '+p<CR>', defaultKeyOption)
setkeymap('!', '<D-v>', '<C-R>+', defaultKeyOption)
setkeymap('t', '<D-v>', '<C-R>+', defaultKeyOption)
setkeymap('v', '<D-v>', '<C-R>+', defaultKeyOption)

-- better up/down
bind("n", "j", "v:count == 0 ? 'gj' : 'j'", {
  expr = true,
  silent = true
})
bind("n", "k", "v:count == 0 ? 'gk' : 'k'", {
  expr = true,
  silent = true
})

-- Undo break points
local break_points = { '<Space>', '-', '_', ':', '.', '/' }
for _, char in ipairs(break_points) do
  bind('i', char, char .. '<C-g>u')
end

-- window management
bind("n", "<leader>sv", "<C-w>v")     -- split window vertically
bind("n", "<leader>sh", "<C-w>s")     -- split window horizontally
bind("n", "<leader>se", "<C-w>=")     -- make split windows equal width & height
bind("n", "<leader>sx", ":close<CR>") -- close current split window
bind("n", "<C-w>k", ":wincmd k<CR>")  -- 切换到上边的窗口
bind("n", "<C-w>j", ":wincmd j<CR>")  -- 切换到下边的窗口
bind("n", "<C-w>h", ":wincmd h<CR>")  -- 切换到左边的窗口
bind("n", "<C-w>l", ":wincmd l<CR>")  -- 切换到右边的窗口

-- bind("n", "<leader>to", ":tabnew<CR>") -- open new tab
-- bind("n", "<leader>tx", ":tabclose<CR>") -- close current tab
-- bind("n", "<leader>tn", ":tabn<CR>") --  go to next tab
-- bind("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

----------------------
-- Plugin Keybinds
----------------------

-- toggle split window maximization
-- require szw/vim-maximizer
bind("n", "<leader>sm", ":MaximizerToggle<CR>")

-- zf   将选中位置创建折叠区域
-- za  反复展开或折叠当前区域
-- zR   展开所有折叠区
-- zM   合上所有折叠区
