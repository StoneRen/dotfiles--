if os.getenv('COLORTERM') == 'truecolor' or os.getenv('COLORTERM') == '24bit' or vim.g.neovide then
  vim.cmd.colorscheme('kanagawa')
else
  print 'not truecolor'
end
