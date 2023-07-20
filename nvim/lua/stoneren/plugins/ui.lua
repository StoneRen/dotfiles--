return { {
    "hardhackerlabs/theme-vim",
    name = "hardhacker",
    lazy = false,
    priority = 1000,
    config = function()
        local g = vim.g
        -- g.hardhacker_darker = 0
        -- g.hardhacker_hide_tilde = 1
        -- g.hardhacker_keyword_italic = 1
        -- vim.cmd("colorscheme hardhacker")
    end
}, {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        local alpha_value = 0.9
        local g = vim.g
        if os.getenv('COLORTERM') == 'truecolor' or os.getenv('COLORTERM') == '24bit' or g.neovide then
            local alpha = function()
                return string.format("%x", math.floor(alpha_value))
            end
            g.neovide_transparency = alpha_value
            g.transparency = alpha_value
            g.neovide_background_color = "#0f1117" .. alpha()
            vim.cmd("colorscheme kanagawa")
            -- vim.cmd("colorscheme kanagawa-wave")
            -- vim.cmd("colorscheme kanagawa-dragon")
            -- vim.cmd("colorscheme kanagawa-lotus")
        else
            print 'not truecolor'
        end
    end
} }
