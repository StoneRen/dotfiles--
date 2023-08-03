-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
local M = {}
local builtin = require('telescope.builtin')
local is_inside_work_tree = {}

-- 查询文件时，蝉寻项目文件
M.find_project_files = function()
  local opts = {} -- define here if you want to define something

  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  if is_inside_work_tree[cwd] then
    builtin.git_files(opts)
  else
    builtin.find_files(opts)
  end
end

-- 查询git的submodule
-- https://github.com/nvim-telescope/telescope.nvim/issues/410

return M
