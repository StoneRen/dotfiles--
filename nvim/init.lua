require("stoneren.options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    -- latest stable release
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
        lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = { {
        import = "stoneren.plugins"
    }, {
        import = "stoneren.langs"
    } },
    ui = {
        border = "rounded"
    },
    change_detection = {
        enabled = true,
        notify = false -- get a notification when changes are found
    }
})
