local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.audible_bell = "Disabled"
config.check_for_updates = false

-- [[ Appearance ]]
config.font = wezterm.font("JetBrains Mono Nerd Font Mono")
config.font_size = 11.5

config.initial_cols = 135
config.initial_rows = 32

config.color_scheme = "rose-pine"

config.hide_tab_bar_if_only_one_tab = true
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

-- [[ Keymappings ]]
local action = wezterm.action

config.leader = { key = "e", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  -- [[ Pane Management ]]
  { key = "-", mods = "LEADER", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "\\", mods = "LEADER", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "w", mods = "LEADER", action = action.CloseCurrentPane({ confirm = true }) },

  { key = "z", mods = "LEADER", action = action.TogglePaneZoomState },

  { key = "h", mods = "LEADER", action = action.ActivatePaneDirection("Left") },
  { key = "l", mods = "LEADER", action = action.ActivatePaneDirection("Right") },
  { key = "j", mods = "LEADER", action = action.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = action.ActivatePaneDirection("Up") },

  { key = "LeftArrow", mods = "LEADER", action = action.AdjustPaneSize({ "Left", 5 }) },
  { key = "RightArrow", mods = "LEADER", action = action.AdjustPaneSize({ "Right", 5 }) },
  { key = "DownArrow", mods = "LEADER", action = action.AdjustPaneSize({ "Down", 5 }) },
  { key = "UpArrow", mods = "LEADER", action = action.AdjustPaneSize({ "Up", 5 }) },

  -- [[ Tab Management ]]
  { key = "t", mods = "LEADER", action = action.SpawnTab("CurrentPaneDomain") },
  { key = "d", mods = "LEADER", action = action.CloseCurrentTab({ confirm = true }) },

  { key = "1", mods = "LEADER", action = action.ActivateTab(0) },
  { key = "2", mods = "LEADER", action = action.ActivateTab(1) },
  { key = "3", mods = "LEADER", action = action.ActivateTab(2) },
  { key = "4", mods = "LEADER", action = action.ActivateTab(3) },
  { key = "5", mods = "LEADER", action = action.ActivateTab(4) },
  { key = "6", mods = "LEADER", action = action.ActivateTab(5) },
  { key = "7", mods = "LEADER", action = action.ActivateTab(6) },
  { key = "8", mods = "LEADER", action = action.ActivateTab(7) },
  { key = "9", mods = "LEADER", action = action.ActivateTab(8) },
  { key = "0", mods = "LEADER", action = action.ActivateTab(-1) },

  -- [[ Motions ]]
  { key = "0", mods = "ALT", action = action.SendKey({ key = "Home" }) },
  { key = "4", mods = "ALT", action = action.SendKey({ key = "End" }) },
  { key = "h", mods = "ALT", action = action.SendKey({ key = "LeftArrow" }) },
  { key = "l", mods = "ALT", action = action.SendKey({ key = "RightArrow" }) },

  -- [[ Miscelaneous ]]
  { key = "F11", mods = "", action = action.ToggleFullScreen },
}

return config
