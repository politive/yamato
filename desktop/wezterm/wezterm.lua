local wezterm = require 'wezterm'  -- Load the wezterm module

local config = wezterm.config_builder()  -- Create a config builder
config.automatically_reload_config = true  -- Enable automatic config reload
config.use_ime = true  -- Enable IME (for Japanese input, etc.)

config.hide_tab_bar_if_only_one_tab = true  -- Hide tab bar if only one tab
config.show_new_tab_button_in_tab_bar = false  -- Hide new tab button in tab bar

config.window_background_opacity = 0.80  -- Set window background opacity
config.macos_window_background_blur = 30  -- Set background blur effect on macOS
config.window_decorations = "RESIZE"  -- Window decorations (allow only resize)

config.font = wezterm.font("HackGen Console NF")  -- Set the font to HackGen Console NF
config.font_size = 14.0  -- Set the font size
config.colors = {
  background = "#132238", -- Background color (deep blue)
}

config.window_frame = {
  border_left_width = 2,  -- Left border width
  border_right_width = 2,  -- Right border width
  border_bottom_height = 2,  -- Bottom border height
  border_top_height = 2,  -- Top border height
  border_left_color = "#89b4fa",   -- Left border color (neon blue)
  border_right_color = "#89b4fa",  -- Right border color
  border_top_color = "#89b4fa",    -- Top border color
  border_bottom_color = "#89b4fa", -- Bottom border color
}

config.window_padding = {
  left = 10,    -- Left padding
  right = 10,   -- Right padding
  top = 10,     -- Top padding
  bottom = 10,  -- Bottom padding
}

-- Symbols for tab title formatting (Nerd Font triangles)
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

-- Customize how tab titles are displayed
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#5c6d74"  -- Default background color
  local foreground = "#FFFFFF"  -- Default text color
  local edge_background = "none"  -- Edge background color
  if tab.is_active then
    background = "#ae8b2d"  -- Active tab background color
    foreground = "#FFFFFF"  -- Active tab text color
  end
  local edge_foreground = background  -- Edge text color
  -- Truncate the title to fit the width
  local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "
  return {
    { Background = { Color = edge_background } },      -- Left edge background
    { Foreground = { Color = edge_foreground } },      -- Left edge text color
    { Text = SOLID_LEFT_ARROW },                       -- Left edge symbol
    { Background = { Color = background } },           -- Tab body background
    { Foreground = { Color = foreground } },           -- Tab body text color
    { Text = title },                                  -- Tab title
    { Background = { Color = edge_background } },      -- Right edge background
    { Foreground = { Color = edge_foreground } },      -- Right edge text color
    { Text = SOLID_RIGHT_ARROW },                      -- Right edge symbol
  }
end)

return config  -- Return the config
