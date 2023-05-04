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
    -- End terminal

    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.x',
        config = function()
            require('stoneren.config.telescope-config')
        end,
        requires = {'nvim-lua/plenary.nvim', "nvim-telescope/telescope-live-grep-args.nvim",
                    'nvim-telescope/telescope-project.nvim', {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = 'make'
        }, "nvim-telescope/telescope-file-browser.nvim", {
            "nvim-telescope/telescope-frecency.nvim",
            requires = {"kkharji/sqlite.lua"}
        }}
    }

    if packer_bootstrap then
        require("packer").sync()
    end
end)
