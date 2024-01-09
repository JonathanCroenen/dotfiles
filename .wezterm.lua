local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.audible_bell = "Disabled"
config.check_for_updates = false

-- [[ Appearance ]]
config.font = wezterm.font("JetBrains Mono")
config.color_scheme = "rose-pine"

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_max_width = 20

config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.9,
}

config.window_padding = {
  left = 1, right = 1,
  top = 1, bottom = 1,
}

-- [[ Keymappings ]]
local action = wezterm.action

config.keys = {
  -- [[ Pane Management ]]
  { key = "_", mods = "CTRL|SHIFT", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "|", mods = "CTRL|SHIFT", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "d", mods = "CTRL|SHIFT", action = action.CloseCurrentPane({ confirm = true }) },

  { key = "z", mods = "CTRL|SHIFT", action = action.TogglePaneZoomState },

  { key = "h", mods = "CTRL|SHIFT", action = action.ActivatePaneDirection("Left") },
  { key = "l", mods = "CTRL|SHIFT", action = action.ActivatePaneDirection("Right") },
  { key = "j", mods = "CTRL|SHIFT", action = action.ActivatePaneDirection("Down") },
  { key = "k", mods = "CTRL|SHIFT", action = action.ActivatePaneDirection("Up") },

  { key = "LeftArrow", mods = "CTRL|SHIFT", action = action.AdjustPaneSize({ "Left", 2 }) },
  { key = "RightArrow", mods = "CTRL|SHIFT", action = action.AdjustPaneSize({"Right", 2}) },
  { key = "DownArrow", mods = "CTRL|SHIFT", action = action.AdjustPaneSize({"Down", 2}) },
  { key = "UpArrow", mods = "CTRL|SHIFT", action = action.AdjustPaneSize({"Up", 2}) },

  -- [[ Tab Management ]]
  { key = "t", mods = "CTRL|SHIFT", action = action.SpawnTab("CurrentPaneDomain") },
  { key = "w", mods = "CTRL|SHIFT", action = action.CloseCurrentTab({ confirm = true }) },

  { key = "Tab", mods = "CTRL", action = action.ActivateTabRelative(1) },
  { key = "Tab", mods = "CTRL|SHIFT", action = action.ActivateTabRelative(-1) },

  { key = "!", mods = "CTRL|SHIFT", action = action.ActivateTab(0) },
  { key = "@", mods = "CTRL|SHIFT", action = action.ActivateTab(1) },
  { key = "#", mods = "CTRL|SHIFT", action = action.ActivateTab(2) },
  { key = "$", mods = "CTRL|SHIFT", action = action.ActivateTab(3) },
  { key = "%", mods = "CTRL|SHIFT", action = action.ActivateTab(4) },
  { key = "^", mods = "CTRL|SHIFT", action = action.ActivateTab(5) },
  { key = "^", mods = "CTRL|SHIFT", action = action.ActivateTab(6) },
  { key = "&", mods = "CTRL|SHIFT", action = action.ActivateTab(7) },
  { key = "(", mods = "CTRL|SHIFT", action = action.ActivateTab(8) },
  { key = ")", mods = "CTRL|SHIFT", action = action.ActivateTab(-1) },

  -- [[ Miscelaneous ]]
  { key = "6", mods = "ALT", action = action.SendKey({ key = "Home" }) },
  { key = "4", mods = "ALT", action = action.SendKey({ key = "End" }) },
}

return config

