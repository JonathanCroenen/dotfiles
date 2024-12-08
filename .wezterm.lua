local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.audible_bell = "Disabled"
config.check_for_updates = false

-- [[ Appearance ]]
config.font = wezterm.font_with_fallback({
  "JetBrainsMono Nerd Font Mono",
  "SF Mono"
})

config.font_size = 11.5

config.initial_cols = 135
config.initial_rows = 32

local colorscheme = require("colors")
config.colors = colorscheme.colors
config.window_frame = colorscheme.window_frame

config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_max_width = 20

config.inactive_pane_hsb = {
  saturation = 1.0,
  brightness = 1.0,
}

config.window_padding = {
  left = 1,
  right = 1,
  top = 1,
  bottom = 1,
}

config.keys = require("keys").keys

wezterm.on("update-right-status", function(window, _)
  window:set_right_status("Workspace: " .. window:active_workspace())
end)

return config
