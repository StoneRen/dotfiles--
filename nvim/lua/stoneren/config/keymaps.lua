-- https://github.com/folke/which-key.nvim
return function()
    local wk = require("which-key")
    local bind = vim.keymap.set
    local setkeymap = vim.api.nvim_set_keymap
    local cmd = vim.cmd
    local keyopt = { silent = true, noremap = true }
    local g = vim.g



    g.neovide_scale_factor = 1.0
    -- https://neovide.dev/faq.html#how-can-i-use-cmd-ccmd-v-to-copy-and-paste
    if g.neovide then
        bind('n', '<D-s>', ':w<CR>')      -- Save
        bind('v', '<D-c>', '"+y')         -- Copy
        bind('n', '<D-v>', '"+P')         -- Paste normal mode
        bind('v', '<D-v>', '"+P')         -- Paste visual mode
        bind('c', '<D-v>', '<C-R>+')      -- Paste command mode
        bind('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

        local change_scale_factor = function(delta)
            g.neovide_scale_factor = g.neovide_scale_factor * delta
        end
        bind("n", "<D-=>", function()
            change_scale_factor(1.25)
        end)
        bind("n", "<D-->", function()
            change_scale_factor(1 / 1.25)
        end)
    end
    -- Allow clipboard copy paste in neovim
    setkeymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
    setkeymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
    setkeymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
    setkeymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })


    wk.register({
        ["<leader>q"] = { ":q<CR>", "推出文件", keyopt },
        ["<leader>qq"] = { ":qa!<CR>", "【慎用】强制推出所有文件", keyopt },
        ["<leader>,"] = { ":tabnew ~/.config/nvim/init.lua<CR>", keyopt },
        ["<leader>a"] = { ":keepjumps normal! ggVG<CR>", "全选" },
    })
    wk.register({
        ["<leader>s"] = {
            name = "窗口管理",
            v = { "<C-w>v", "垂直分割窗口" },
            h = { "<C-w>s", "水平分割窗口" },
            e = { "<C-w>=", "平均分割窗口" },
            x = { ":close<CR>", "关闭当前窗口" }
        },
        ["<C-w>"] = {
            name = "窗口移动",
            k = { ":wincmd k<CR>", "切换到上边的窗口" },
            j = { ":wincmd j<CR>", "切换到下边的窗口" },
            h = { ":wincmd h<CR>", "切换到左边的窗口" },
            l = { ":wincmd l<CR>", "切换到右边的窗口" }
        },
    })

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
end

-- 默认操作
-- yy 或 Y 复制当前行。
-- yw 用来复制往后一个词，y3w 复制往后三个词。
-- yiw 复制当前词。
-- y$ 复制到行尾，y^ 复制到行首。
-- yf. 复制直到下一个 . 字符。
-- ggyG 或 :%y 复制整个文件

-- 在插入模式下粘贴
-- Ctrl+r " 插入最近一次复制/剪切/删除的内容。" 是 Vim 的匿名寄存器。
-- Ctrl+r 0 插入最近一次复制的内容。其中 0 属于 Vim 的编号寄存器，保存最近一次拷贝的内容


-- https://vonheikemen.github.io/devlog/tools/build-your-first-lua-config-for-neovim/
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
