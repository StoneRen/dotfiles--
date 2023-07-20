return { {
  -- https://github.com/folke/which-key.nvim
  'nvim-telescope/telescope.nvim',
  dependencies = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
  config = function()
    require 'telescope'.setup {}

    local option = {
      noremap = true,
      silent = true
    }

    local builtin = require('telescope.builtin')
    local wk = require("which-key")

    wk.register({
      ["<leader>t"] = {
        name = "+telescope",
        f = { builtin.find_files, "Find File", option },
        r = { builtin.oldfiles, "recent fils", option },
        g = { builtin.live_grep, "live grep", option },
        s = { builtin.grep_string, "grep string", option },
        b = { builtin.buffers, "buffers", option },
      },
    })
  end
} }
