local wezterm = require("wezterm")
local action = wezterm.action
local sessionizer = require("sessionizer")

local M = {}
M.keys = {
  -- [[ Pane Management ]]
  { key = "_",          mods = "CTRL|SHIFT", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "|",          mods = "CTRL|SHIFT", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "q",          mods = "CTRL|SHIFT", action = action.CloseCurrentPane({ confirm = true }) },

  { key = "z",          mods = "CTRL|SHIFT", action = action.TogglePaneZoomState },

  { key = "h",          mods = "CTRL|SHIFT", action = action.ActivatePaneDirection("Left") },
  { key = "l",          mods = "CTRL|SHIFT", action = action.ActivatePaneDirection("Right") },
  { key = "j",          mods = "CTRL|SHIFT", action = action.ActivatePaneDirection("Down") },
  { key = "k",          mods = "CTRL|SHIFT", action = action.ActivatePaneDirection("Up") },

  { key = "LeftArrow",  mods = "CTRL|SHIFT", action = action.AdjustPaneSize({ "Left", 5 }) },
  { key = "RightArrow", mods = "CTRL|SHIFT", action = action.AdjustPaneSize({ "Right", 5 }) },
  { key = "DownArrow",  mods = "CTRL|SHIFT", action = action.AdjustPaneSize({ "Down", 5 }) },
  { key = "UpArrow",    mods = "CTRL|SHIFT", action = action.AdjustPaneSize({ "Up", 5 }) },

  -- [[ Tab Management ]]
  { key = "Tab",        mods = "CTRL",       action = action.DisableDefaultAssignment },
  { key = "Tab",        mods = "CTRL|SHIFT", action = action.DisableDefaultAssignment },
  { key = "t",          mods = "CTRL|SHIFT", action = action.SpawnTab("CurrentPaneDomain") },
  { key = "d",          mods = "CTRL|SHIFT", action = action.CloseCurrentTab({ confirm = true }) },

  { key = "1",          mods = "CTRL|SHIFT", action = action.ActivateTab(0) },
  { key = "2",          mods = "CTRL|SHIFT", action = action.ActivateTab(1) },
  { key = "3",          mods = "CTRL|SHIFT", action = action.ActivateTab(2) },
  { key = "4",          mods = "CTRL|SHIFT", action = action.ActivateTab(3) },
  { key = "5",          mods = "CTRL|SHIFT", action = action.ActivateTab(4) },
  { key = "6",          mods = "CTRL|SHIFT", action = action.ActivateTab(5) },
  { key = "7",          mods = "CTRL|SHIFT", action = action.ActivateTab(6) },
  { key = "8",          mods = "CTRL|SHIFT", action = action.ActivateTab(7) },
  { key = "9",          mods = "CTRL|SHIFT", action = action.ActivateTab(8) },
  { key = "0",          mods = "CTRL|SHIFT", action = action.ActivateTab(-1) },

  -- [[ Miscelaneous ]]
  { key = "s",          mods = "CTRL|SHIFT", action = wezterm.action_callback(sessionizer.toggle) },
  {
    key = "s",
    mods = "ALT",
    action = action.ShowLauncherArgs({
      title = "Select Workspace",
      flags = "FUZZY|WORKSPACES",
    }),
  },
  { key = "l",   mods = "CTRL|SHIFT", action = action.ShowLauncher },
  { key = "r",   mods = "CTRL|SHIFT", action = action.ReloadConfiguration },
  { key = "F10", mods = "",           action = action.ShowDebugOverlay },
  { key = "F11", mods = "",           action = action.ToggleFullScreen },
}

return M
