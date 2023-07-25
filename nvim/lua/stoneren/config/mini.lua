local bind = vim.keymap.set
require('mini.comment').setup({
  mappings = {
    -- Toggle comment (like `gcip` - comment inner paragraph) for both
    -- Normal and Visual modes
    comment = 'gc',

    -- Toggle comment on current line
    comment_line = 'gcc',

    -- Define 'comment' textobject (like `dgc` - delete whole comment block)
    textobject = 'gc'
  },
})

-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md#default
require('mini.surround').setup({
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    add = 'sa',            -- Add surrounding in Normal and Visual modes
    delete = 'sd',         -- Delete surrounding
    find = 'sf',           -- Find surrounding (to the right)
    find_left = 'sF',      -- Find surrounding (to the left)
    highlight = 'sh',      -- Highlight surrounding
    replace = 'sr',        -- Replace surrounding
    update_n_lines = 'sn', -- Update `n_lines`

    suffix_last = 'l',     -- Suffix to search with "prev" method
    suffix_next = 'n'      -- Suffix to search with "next" method
  },
})

-- 可视模式下选择
-- 比如: vi( va[  va'
require('mini.ai').setup {
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Main textobject prefixes
    around = 'a',
    inside = 'i',

    -- Next/last variants
    around_next = 'an',
    inside_next = 'in',
    around_last = 'al',
    inside_last = 'il',

    -- Move cursor to corresponding edge of `a` textobject
    goto_left = 'g[',
    goto_right = 'g]',
  },
}

require('mini.indentscope').setup()


-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-pairs.md#default
require('mini.pairs').setup()

-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-starter.md#default
-- require('mini.starter').setup()

-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-statusline.md#default
require('mini.statusline').setup()

require('mini.cursorword').setup()

-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-trailspace.md
-- 删除尾部空格
-- :MiniTrailspace.trim() 删除尾随空格
-- :MiniTrailspace.trim_last_lines() 删除尾随空白行
require('mini.trailspace').setup {
  bind("n", "<leader>ct", "<cmd>lua MiniTrailspace.trim()<CR>"),
  bind("n", "<leader>cl", "<cmd>lua MiniTrailspace.trim_last_lines()<CR>")
}

-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-files.md
-- Press j/k to navigate down/up.
-- Press l to expand entry under cursor: show directory or open file in the most recent window.
-- Press h to go to parent directory.
-- Type g? for more information about other available mappings.
-- Move as in any other buffer ($, G, f/t, etc.).
-- require('mini.files').setup {
--   bind("n", "<leader>fo", "<cmd>lua MiniFiles.open()<CR>")
-- }
