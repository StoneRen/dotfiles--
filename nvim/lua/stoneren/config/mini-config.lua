require('mini.comment').setup({
  -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md#default-config
  -- Options which control module behavior
  options = {
      -- Whether to ignore blank lines
      ignore_blank_line = false,

      -- Whether to recognize as comment only lines without indent
      start_of_line = false,

      -- Whether to ensure single space pad for comment parts
      pad_comment_parts = true
  },

  -- Module mappings. Use `''` (empty string) to disable one.
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

-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md#default-config
require('mini.surround').setup({
  -- Add custom surroundings to be used on top of builtin ones. For more
  -- information with examples, see `:h MiniSurround.config`.
  custom_surroundings = nil,

  -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
  highlight_duration = 500,

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
      add = 'sa', -- Add surrounding in Normal and Visual modes
      delete = 'sd', -- Delete surrounding
      find = 'sf', -- Find surrounding (to the right)
      find_left = 'sF', -- Find surrounding (to the left)
      highlight = 'sh', -- Highlight surrounding
      replace = 'sr', -- Replace surrounding
      update_n_lines = 'sn', -- Update `n_lines`

      suffix_last = 'l', -- Suffix to search with "prev" method
      suffix_next = 'n' -- Suffix to search with "next" method
  },

  -- Number of lines within which surrounding is searched
  n_lines = 20,

  -- Whether to respect selection type:
  -- - Place surroundings on separate lines in linewise mode.
  -- - Place surroundings on each line in blockwise mode.
  respect_selection_type = false,

  -- How to search for surrounding (first inside current line, then inside
  -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
  -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
  -- see `:h MiniSurround.config`.
  search_method = 'cover',

  -- Whether to disable showing non-error feedback
  silent = false
})

require('mini.indentscope').setup()


-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-pairs.md#default-config
require('mini.pairs').setup()

-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-starter.md#default-config
require('mini.starter').setup()

-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-statusline.md#default-config
require('mini.statusline').setup()