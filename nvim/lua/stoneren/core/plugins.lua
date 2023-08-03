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

local useTreesitter = function(use)
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
end

local useNeoTree = function(use)
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      local bind = vim.keymap.set
      local keyopt = { noremap = true, silent = true }
      bind("n", '<F8>', ":Neotree position=float source=buffers action=show toggle=true<CR>", keyopt)
      bind("n", '<F9>', ":Neotree position=right source=filesystem action=show toggle=true<CR>", keyopt)
      bind("n", '<F10>', ":Neotree position=float source=git_status action=show toggle=true<CR>", keyopt)
    end
  }
end

-- 有问题，使用后，没有启动界面了
-- local useTodo = function(use)
  -- use {
  --   "folke/todo-comments.nvim",
  --   requires = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     require("todo-comments").setup({
  --       keywords = {
  --         FIX = {
  --           color = "error",                            -- can be a hex color, or a named color (see below)
  --           alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
  --           -- signs = false, -- configure signs for some keywords individually
  --         },
  --         TODO = { color = "todo" },
  --         HACK = { color = "warning" },
  --         WARN = { color = "warning", alt = { "WARNING", "XXX" } },
  --         PERF = { alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
  --         NOTE = { color = "info", alt = { "INFO" } },
  --         TEST = { color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
  --       },
  --       colors = {
  --         error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
  --         warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
  --         todo = { "DiagnosticOk", "#2563EB" },
  --         info = { "DiagnosticInfo", "#10B981" },
  --         default = { "Identifier", "#7C3AED" },
  --         test = { "Identifier", "#FF00FF" },
  --       },
  --     })
  --   end,
  -- }
-- end


local useTabnine = function(use)
  use {
    'codota/tabnine-nvim',
    run = "./dl_binaries.sh",
    config = function()
      local tabnine = require('tabnine')
      local chat = require('tabnine.chat')
      local bind = vim.api.nvim_set_keymap
      tabnine.setup({
        disable_auto_comment = false,
        accept_keymap = "<Tab>",
        dismiss_keymap = "<C-]>",
        debounce_ms = 800,
        suggestion_color = { gui = "#808080", cterm = 244 },
        exclude_filetypes = { "TelescopePrompt" },
        log_file_path = nil, -- absolute path to Tabnine log file
      })
      bind("x", "<leader>qc", "", { noremap = true, callback = chat.open })
      bind("i", "<leader>qc", "", { noremap = true, callback = chat.open })
      bind("n", "<leader>qc", "", { noremap = true, callback = chat.open })
    end
  }
end

local useSession = function(use)
  use {
    'Shatur/neovim-session-manager',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('stoneren.config.session')
    end
  }
end

local useBasic = function(use)
  use {
    'nvim-tree/nvim-web-devicons',
  }

  use {
    'mbbill/undotree',
    config = function()
      local bind = vim.keymap.set
      bind('n', '<F5>', vim.cmd.UndotreeToggle)
    end
  }
  useTreesitter(use)
  useNeoTree(use)
  -- useSession(use)
  useTabnine(use)
  -- useTodo(use)

  use {
    'windwp/nvim-ts-autotag',
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  }

  -- -- maximizes and restores current window
  -- -- use { "szw/vim-maximizer" }

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
end


local useNotify = function(use)
  use {
    'folke/noice.nvim',
    requires = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    config = function()
      require('stoneren.config.noice')
    end
  }
end

local useEnhance = function(use)
  useNotify(use)
end


local useUI = function(use)
  -- use 'Tsuzat/NeoSolarized.nvim'
  use {
    'rebelot/kanagawa.nvim',
    config = function()
      require('stoneren.config.ui')
    end
  }

  -- use({
  --   "utilyre/barbecue.nvim",
  --   tag = "*",
  --   requires = {
  --     "SmiteshP/nvim-navic",
  --     "nvim-tree/nvim-web-devicons", -- optional dependency
  --   },
  --   after = "nvim-web-devicons",     -- keep this if you're using NvChad
  --   config = function()
  --     require("barbecue").setup()
  --   end,
  -- })
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
    'f-person/git-blame.nvim'
  }
  use {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup({
        preview_config = {
          border = "rounded",
        },
      })
    end,
  }
  use {
    "sindrets/diffview.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require('stoneren.config.git')
    end
  }
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
    requires = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = 'make'
      },
      {
        "nvim-telescope/telescope-frecency.nvim",
        requires = { "kkharji/sqlite.lua" }
      },
      'nvim-lua/plenary.nvim',
      'crispgm/telescope-heading.nvim',
      'TC72/telescope-tele-tabby.nvim',
      "nvim-telescope/telescope-live-grep-args.nvim",
      'nvim-telescope/telescope-project.nvim',
      "nvim-telescope/telescope-file-browser.nvim",
      "HUAHUAI23/telescope-session.nvim",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-ui-select.nvim"
    }
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
  useEnhance(use)

  useKeyMap(use)
  useMini(use)
  useTerminal(use)
  useGit(use)

  useLang(use)
  useTelescope(use)
  useAcp(use)
  useLsp(use)
  useMason(use)


  if packer_bootstrap then
    require("packer").sync()
  end
end)
