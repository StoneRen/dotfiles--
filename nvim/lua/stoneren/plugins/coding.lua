return {
    -- auto-tag
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end
    },
    -- auto-pairs
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({
                enable_check_bracket_line = false,
                ignored_next_char = "[%w%.]" -- will ignore alphanumeric and `.` symbol
            })
        end
    },
    -- auto completion
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("stoneren/config/autocmp")()
        end
    },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "onsails/lspkind.nvim" },

    -- multi-selection
    -- https://github.com/mg979/vim-visual-multi
    {
        "mg979/vim-visual-multi",
    },


    -- icons in autocomplete source
    -- todo comments
    -- Preview
    -- TODO: todo
    -- FIX: fix
    -- WARNING: warning
    -- HACK: hack
    -- NOTE: note
    -- PERF: perf
    -- TEST: test
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("todo-comments").setup({
                keywords = {
                    FIX = {
                        color = "error",                           -- can be a hex color, or a named color (see below)
                        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } -- a set of other keywords that all map to this FIX keywords
                        -- signs = false, -- configure signs for some keywords individually
                    },
                    TODO = {
                        color = "todo"
                    },
                    HACK = {
                        color = "warning"
                    },
                    WARN = {
                        color = "warning",
                        alt = { "WARNING", "XXX" }
                    },
                    PERF = {
                        alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" }
                    },
                    NOTE = {
                        color = "info",
                        alt = { "INFO" }
                    },
                    TEST = {
                        color = "test",
                        alt = { "TESTING", "PASSED", "FAILED" }
                    }
                },
                colors = {
                    error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
                    warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
                    todo = { "DiagnosticOk", "#2563EB" },
                    info = { "DiagnosticInfo", "#10B981" },
                    default = { "Identifier", "#7C3AED" },
                    test = { "Identifier", "#FF00FF" }
                }
            })
        end
    },
    -- guess indent
    {
        "nmac427/guess-indent.nvim",
        config = function()
            require("guess-indent").setup({})
        end
    } }
