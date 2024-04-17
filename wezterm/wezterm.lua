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

config.colors = require("lua/rose-pine").colors()
config.window_frame = require("lua/rose-pine").window_frame()

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

wezterm.on("update-right-status", function(window, _)
  window:set_right_status("session: " .. window:active_workspace())
end)

-- [[ Keymappings ]]
local action = wezterm.action

-- config.leader = { key = "e", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  -- [[ Pane Management ]]
  { key = "_",          mods = "CTRL|SHIFT", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "|",         mods = "CTRL|SHIFT", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
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
  { key = "F11",        mods = "",           action = action.ToggleFullScreen },

  -- [[ Sessions ]]
  {
    key = "s",
    mods = "ALT",
    action = action.ShowLauncherArgs({
      title = "Session picker",
      flags = "FUZZY|WORKSPACES",
    }),
  },
  -- {
  --   key = "s",
  --   mods = "CTRL|SHIFT",
  --   action = action.PromptInputLine {
  --     description = wezterm.format {
  --       { Attribute = { Intensity = "Bold" } },
  --       { Foreground = { AnsiColor = "Fuchsia" } },
  --       { Text = "Enter name for new workspace" },
  --     },
  --     action = wezterm.action_callback(function(window, pane, line)
  --       -- line will be `nil` if they hit escape without entering anything
  --       -- An empty string if they just hit enter
  --       -- Or the actual line of text they wrote
  --       if line then
  --         window:perform_action(
  --           action.SwitchToWorkspace {
  --             name = line,
  --           },
  --           pane
  --         )
  --       end
  --     end),
  --   },
  -- },
}

return config
