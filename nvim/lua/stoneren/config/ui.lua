local alpha_value = 0.9
local g = vim.g
local cmd = vim.cmd
if os.getenv('COLORTERM') == 'truecolor' or os.getenv('COLORTERM') == '24bit' or g.neovide then
  local alpha = function()
    return string.format("%x", math.floor(alpha_value))
  end
  g.neovide_transparency = alpha_value
  g.transparency = alpha_value
  g.neovide_background_color = "#0f1117" .. alpha()
  cmd.colorscheme('kanagawa')
else
  print 'not truecolor'
end
