return {
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local wk = require("which-key")
      require("gitsigns").setup({
        preview_config = {
          border = "rounded",
        },
      })

      -- :DiffviewOpen
      -- :DiffviewOpen HEAD~2
      -- :DiffviewOpen HEAD~4..HEAD~2
      -- :DiffviewOpen d4a7b0d
      -- :DiffviewOpen d4a7b0d^!
      -- :DiffviewOpen d4a7b0d..519b30e
      -- :DiffviewOpen origin/main...HEAD
      -- :DiffviewClose: Close the current diffview. You can also use :tabclose.
      -- :DiffviewToggleFiles: Toggle the file panel.
      -- :DiffviewFocusFiles: Bring focus to the file panel.
      -- :DiffviewRefresh: Update stats and entries in the file list of the current Diffview.
      -- :DiffviewFileHistory
      -- :DiffviewFileHistory %
      -- :DiffviewFileHistory path/to/some/file.txt
      -- :DiffviewFileHistory path/to/some/directory
      -- :DiffviewFileHistory include/this and/this :!but/not/this
      -- :DiffviewFileHistory --range=origin..HEAD
      -- :DiffviewFileHistory --range=feat/example-branch
      -- :'<,'>DiffviewFileHistory
      wk.register({
        ["<leader>d"] = {
          name = "+diff prefix",
          f    = { ":DiffviewOpen<CR>", "查看当前文件改动" },
          h    = { ":DiffviewFileHistory<CR>", "查看提交历史" },
          x    = { ":DiffviewClose<CR>", "关闭当前view" }
        }
      })
    end,
  },

  { "sindrets/diffview.nvim", dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" } },
}
