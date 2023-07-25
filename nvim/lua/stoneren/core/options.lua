local opt = vim.opt

-- Editor Options
opt.encoding = "UTF-8"
opt.swapfile = false
opt.backup = false
opt.autochdir = true
-- 总是显示光标位置
opt.ruler = true

-- line numbers
opt.number = true
opt.relativenumber = true

-- tabs & indentation
-- 缩进时是否用空格表示
opt.expandtab = true
opt.autoindent = true
-- Tab set to two spaces
--- 1个tab显示几个空格的长度
opt.tabstop = 2
--- 自动缩进空白字符的个数
opt.shiftwidth = 2
--- 在编辑模式下按退格键缩回的长度
opt.softtabstop = 2

-- line wrapping
-- 长文本换行
opt.wrap = true
-- 保留虚拟行的缩进，只在启用wrap时可见
opt.breakindent = true

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
if os.getenv('COLORTERM') == 'truecolor' or os.getenv('COLORTERM') == '24bit' or vim.g.neovide then
    opt.termguicolors = true
    -- vim.cmd([[ set t_8f=^[[38;2;%lu;%lu;%lum ]])
    -- vim.cmd([[ set t_8b=^[[48;2;%lu;%lu;%lum ]])
end
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard = "unnamedplus"

-- When opening a window put it right or below the current one
opt.splitright = true
opt.splitbelow = true

-- 在遇到破折号的时候当成一个整体
-- opt.iskeyword:append("-")
-- vim.cmd([[
--     set noeb
--     filetype    plugin indent on
--     exec        "nohlsearch"
--     syntax      enable
--     syntax      on
-- ]])
