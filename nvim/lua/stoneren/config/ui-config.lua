if os.getenv('COLORTERM') == 'truecolor' or os.getenv('COLORTERM') == '24bit' then
  vim.cmd.colorscheme('kanagawa')
end