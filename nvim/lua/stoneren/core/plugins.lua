-- auto install packer if not installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({"git", "clone", "--depth", "1", "git@github.com:wbthomason/packer.nvim.git", install_path})
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

return require("packer").startup(function(use)
    -- Packer
    use("wbthomason/packer.nvim")

    -- UI
    use({
        "rebelot/kanagawa.nvim",
        config = function()
            require("stoneren.config.ui-config")
        end
    })

    -- maximizes and restores current window
    use({"szw/vim-maximizer"})

    -- MiniNvim
    use {
        'echasnovski/mini.nvim',
        branch = 'stable',
        config = function()
            require('stoneren.config.mini-config')
        end
    }
    
    use {
        "mg979/vim-visual-multi"
    }

    -- which-key
    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {}
        end
    }

    -- terminal
    use {
        "akinsho/toggleterm.nvim",
        tag = '*',
        config = function()
            require("stoneren.config.term-config")
        end
    }

    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.x',
        config = function()
            require('stoneren.config.telescope-config')
        end,
        requires = {{
            "nvim-telescope/telescope-fzf-native.nvim",
            run = 'make'
        }, {
            "nvim-telescope/telescope-frecency.nvim",
            requires = {"kkharji/sqlite.lua"}
        }, 'nvim-lua/plenary.nvim', "nvim-telescope/telescope-live-grep-args.nvim",
                    'nvim-telescope/telescope-project.nvim', "nvim-telescope/telescope-file-browser.nvim"}
    }

    -- autocompletion
    use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion
    use("hrsh7th/cmp-buffer") -- source for text in buffer
    use("hrsh7th/cmp-path") -- source for file system paths
    -- snippets
    use("L3MON4D3/LuaSnip") -- snippet engine
    use("saadparwaiz1/cmp_luasnip") -- for autocompletion
    use("rafamadriz/friendly-snippets") -- useful snippets
    use({
        "hrsh7th/nvim-cmp",
        config = function()
            require("stoneren.config.amp-config")
        end
    }) -- completion plugin

    -- lsp
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = { -- LSP Support
        {'neovim/nvim-lspconfig'}, -- Required
        { -- Optional
            'williamboman/mason.nvim',
            run = function()
                pcall(vim.cmd, 'MasonUpdate')
            end
        }, {'williamboman/mason-lspconfig.nvim'}, -- Optional
        -- Autocompletion
        {'hrsh7th/nvim-cmp'}, -- Required
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'L3MON4D3/LuaSnip'} -- Required
        },
        config = function()
          require('stoneren.config.lsp-config')
        end
    }

    if packer_bootstrap then
        require("packer").sync()
    end
end)
