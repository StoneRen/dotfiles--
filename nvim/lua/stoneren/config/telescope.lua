local telescope = require('telescope')
-- local acitons = require('telescope.actions')
local bind = vim.keymap.set
local builtin = require('telescope.builtin')

telescope.setup {
  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    frecency = {
      show_unindexed = true,
      ignore_patterns = { "*.git/*", "*/tmp/*" },
    },
    heading = {
      treesitter = true,
    }
  },
}

local keymapOpt = {
  noremap = true, silent = true
}

-- https://github.com/nvim-telescope/telescope.nvim/issues/2201#issuecomment-1485886554
-- local Path = require("plenary.path")
-- local action_state = require("telescope.actions.state")
-- local actions = require("telescope.actions")


bind('n', '<leader>tf', ':lua require("stoneren.config.ts-project").find_project_files()<CR>', keymapOpt)
-- bind('n', '<leader>tf', builtin.find_files, keymapOpt)
-- bind('n', '<leader>ts', builtin.grep_string, keymapOpt)
bind('n', '<leader>tg', builtin.git_files, keymapOpt)
-- bind('n', '<leader>tl', builtin.live_grep, keymapOpt)
-- 用下面的 `fg` 吧 更好用
-- bind('n', '<leader>tl', ts_select_dir_for_grep, keymapOpt)
bind('n', '<leader>tb', builtin.buffers, keymapOpt)
bind('n', '<leader>th', builtin.help_tags, keymapOpt)

telescope.load_extension("live_grep_args")
bind('n', '<leader>fg', ":Telescope live_grep_args<CR>", keymapOpt)

telescope.load_extension('fzf')
-- https://github.com/HUAHUAI23/telescope-session.nvim
-- require("telescope").load_extension("xray23")
-- bind('n', '<leader>tsl', ":Telescope xray23 list<CR>", keymapOpt)
-- bind('n', '<leader>tss', ":Telescope xray23 save<CR>", keymapOpt)


telescope.load_extension("file_browser")
bind('n', '<leader>e', ":Telescope file_browser path=%:p:h select_buffer=true<CR>", keymapOpt)
bind('n', '<leader>te', ":tabnew | Telescope file_browser path=%:p:h select_buffer=true<CR>", keymapOpt)

--[[
| Insert / Normal | fb_actions           | Description                                                                      |
| --------------- | -------------------- | -------------------------------------------------------------------------------- |
| `<A-c>/c`       | create               | Create file/folder at current `path` (trailing path separator creates folder)    |
| `<S-CR>`        | create_from_prompt   | Create and open file/folder from prompt (trailing path separator creates folder) |
| `<A-r>/r`       | rename               | Rename multi-selected files/folders                                              |
| `<A-m>/m`       | move                 | Move multi-selected files/folders to current `path`                              |
| `<A-y>/y`       | copy                 | Copy (multi-)selected files/folders to current `path`                            |
| `<A-d>/d`       | remove               | Delete (multi-)selected files/folders                                            |
| `<C-o>/o`       | open                 | Open file/folder with default system application                                 |
| `<C-g>/g`       | goto_parent_dir      | Go to parent directory                                                           |
| `<C-e>/e`       | goto_home_dir        | Go to home directory                                                             |
| `<C-w>/w`       | goto_cwd             | Go to current working directory (cwd)                                            |
| `<C-t>/t`       | change_cwd           | Change nvim's cwd to selected folder/file(parent)                                |
| `<C-f>/f`       | toggle_browser       | Toggle between file and folder browser                                           |
| `<C-h>/h`       | toggle_hidden        | Toggle hidden files/folders                                                      |
| `<C-s>/s`       | toggle_all           | Toggle all entries ignoring `./` and `../`                                       |
| `<Tab>`         | see `telescope.nvim` | Toggle selection and move to next selection                                      |
| `<S-Tab>`       | see `telescope.nvim` | Toggle selection and move to prev selection                                      |
| `<bs>/`         | backspace            | With an empty prompt, goes to parent dir. Otherwise acts normally                |
--]]
telescope.load_extension("frecency")
bind('n', '<leader>fr', ":Telescope frecency<CR>", keymapOpt)

telescope.load_extension('project')
bind('n', '<leader>fp', ":Telescope project<CR>", keymapOpt)
-- 在打开项目窗口的时候，可以采用如下快捷键
-- 下面全是在插入模式下
-- <c-w> change workspace
-- <c-a> create a project
-- <c-d> delete a project
-- <c-v> rename currently selected project
-- <c-s> search inside files within your project
-- <c-b> browse inside files within your project
-- <c-f> find a file in currently selected project
-- <c-r> find a recentyly opened file whithin currently selected project
-- <c-l> change to the selected project's directory without opening it

telescope.load_extension("notify")
bind('n', '<leader>tn', ":Telescope notify<CR>", keymapOpt)

telescope.load_extension('ui-select')

telescope.load_extension('heading')
bind('n', '<leader>th', ":Telescope heading<CR>", keymapOpt)

telescope.load_extension('tele_tabby')
bind('n', '<leader>tt', ":Telescope tele_tabby list<CR>", keymapOpt)


telescope.load_extension('undo')
bind('n', '<leader>tu', ":Telescope undo<CR>", keymapOpt)

