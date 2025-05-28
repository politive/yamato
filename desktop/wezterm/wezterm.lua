local wezterm = require 'wezterm'

local config = wezterm.config_builder()
config.automatically_reload_config = true
config.use_ime = true

config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false

config.window_background_opacity = 0.80
config.macos_window_background_blur = 30
config.window_decorations = "RESIZE"

config.colors = {
  background = "#132238", -- 深い青系（透過時に効果的）
}

config.window_frame = {
  border_left_width = 2,
  border_right_width = 2,
  border_bottom_height = 2,
  border_top_height = 2,
  border_left_color = "#89b4fa",   -- 💎 ネオンブルー
  border_right_color = "#89b4fa",
  border_top_color = "#89b4fa",
  border_bottom_color = "#89b4fa",
}

config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

-- タブタイトル整形はそのまま
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#5c6d74"
  local foreground = "#FFFFFF"
  local edge_background = "none"
  if tab.is_active then
    background = "#ae8b2d"
    foreground = "#FFFFFF"
  end
  local edge_foreground = background
  local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "
  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_LEFT_ARROW },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_RIGHT_ARROW },
  }
end)

return config
