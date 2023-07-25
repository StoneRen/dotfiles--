-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "git@github.com:wbthomason/packer.nvim.git", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

local useBasic = function(use)
  use {
    'nvim-tree/nvim-web-devicons',
  }

  use {
    'windwp/nvim-ts-autotag',
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  }

  -- maximizes and restores current window
  use { "szw/vim-maximizer" }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({
        enable_check_bracket_line = false,
        ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
      })
    end,
  }

  -- 块选择
  -- https://github.com/mg979/vim-visual-multi
  use { "mg979/vim-visual-multi" }

  use {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({
        keywords = {
          FIX = {
            color = "error",                            -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          TODO = { color = "todo" },
          HACK = { color = "warning" },
          WARN = { color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { color = "info", alt = { "INFO" } },
          TEST = { color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        colors = {
          error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
          warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
          todo = { "DiagnosticOk", "#2563EB" },
          info = { "DiagnosticInfo", "#10B981" },
          default = { "Identifier", "#7C3AED" },
          test = { "Identifier", "#FF00FF" },
        },
      })
    end,
  }
end


local useUI = function(use)
  use 'Tsuzat/NeoSolarized.nvim'
  use {
    'rebelot/kanagawa.nvim',
    config = function()
      require('stoneren.config.ui')
    end
  }
end

local useMini = function(use)
  use {
    'echasnovski/mini.nvim',
    config = function()
      require('stoneren.config.mini')
    end
  }
end


local useKeyMap = function(use)
  -- which-key
  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {}
    end
  }
end

local useGit = function(use)
  use {
    'lewis6991/gitsigns.nvim',
    -- tag = 'release'
  }

  use {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup({
        preview_config = {
          border = "rounded",
        },
      })
    end,
  }
  use { "sindrets/diffview.nvim", dependencies = { "nvim-lua/plenary.nvim" } }
end

local useTerminal = function(use)
  use {
    "akinsho/toggleterm.nvim",
    tag = '*',
    config = function()
      require("stoneren.config.term")
    end
  }
end

local useTreesitter = function(use)
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
end

local useMarkdown = function(use)
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", { noremap = true, silent = true })
    end,
    ft = { "markdown" }
  })
end

local useLang = function(use)
  useMarkdown(use)
end

local useTelescope = function(use)
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.x',
    config = function()
      require('stoneren.config.telescope')
    end,
    requires = { {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = 'make'
    }, {
      "nvim-telescope/telescope-frecency.nvim",
      requires = { "kkharji/sqlite.lua" }
    }, 'nvim-lua/plenary.nvim', "nvim-telescope/telescope-live-grep-args.nvim",
      'nvim-telescope/telescope-project.nvim', "nvim-telescope/telescope-file-browser.nvim" }
  }
end

local useAcp = function(use)
  -- autocompletion
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-buffer" }
  use { "hrsh7th/cmp-path" }
  use { "hrsh7th/cmp-cmdline" }
  use { "onsails/lspkind.nvim" }
  -- snippets
  use("L3MON4D3/LuaSnip")             -- snippet engine
  use("saadparwaiz1/cmp_luasnip")     -- for autocompletion
  use("rafamadriz/friendly-snippets") -- useful snippets
  use({
    "hrsh7th/nvim-cmp",
    config = function()
      require("stoneren.config.acp")
    end
  }) -- completion plugin
end

local useLsp = function(use)
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {                   -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        run = ":MasonUpdate"
      }, { 'williamboman/mason-lspconfig.nvim' }, -- Optional
      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },                     -- Required
      { 'hrsh7th/cmp-nvim-lsp' },                 -- Required
      { 'L3MON4D3/LuaSnip' }                      -- Required
    },
    config = function()
      require('stoneren.config.lsp')
    end
  }
end

local useMason = function(use)
  use {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    requires = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        automatic_setup = true,
      })
    end
  }
end

return require("packer").startup(function(use)
  -- Packer
  use 'wbthomason/packer.nvim'

  useUI(use)
  useBasic(use)
  useKeyMap(use)
  useMini(use)
  useTerminal(use)
  useGit(use)

  useLang(use)
  useTreesitter(use)
  useTelescope(use)
  useAcp(use)
  useLsp(use)
  useMason(use)


  if packer_bootstrap then
    require("packer").sync()
  end
end)
