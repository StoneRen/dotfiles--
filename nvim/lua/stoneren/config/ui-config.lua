local alpha_value = 0.9
if os.getenv('COLORTERM') == 'truecolor' or os.getenv('COLORTERM') == '24bit' or vim.g.neovide then
  local alpha = function()
    return string.format("%x", math.floor(alpha_value))
  end
  vim.g.neovide_transparency = alpha_value
  vim.g.transparency = alpha_value
  vim.g.neovide_background_color = "#0f1117" .. alpha()
  vim.cmd.colorscheme('kanagawa')
else
  print 'not truecolor'
end
