local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

local fd = "/opt/homebrew/bin/fd"
local home = os.getenv("HOME") .. "/"
local dev = home .. "Dev/"

M.toggle = function(window, pane)
  local projects = {}

  local success, stdout, stderr = wezterm.run_child_process({
    fd,
    "-HI",
    "-td",
    "--max-depth=1",
    "--prune",
    ".",
    dev,
    -- add more paths here
  })

  if not success then
    wezterm.log_error("Failed to run fd: " .. stderr)
    return
  end

  -- fill table with results
  for line in stdout:gmatch("([^\n]*)\n?") do
    local project = line
    local label = project:gsub(home, "")
    local _, _, id = string.find(project, ".*/(.+)/")

    -- handle git bare repositories,
    -- assuming following name convention `myproject.git`
    if string.match(project, "%.git/$") then
      success, stdout, stderr =
          wezterm.run_child_process({ fd, "-HI", "-td", "--max-depth=1", ".", project .. "worktrees" })
      if success then
        for wt_line in stdout:gmatch("([^\n]*)\n?") do
          local wt_project = wt_line
          local wt_label = wt_project:gsub(home, "")
          local wt_id = wt_project
          table.insert(projects, { label = tostring(wt_label), id = tostring(wt_id) })
        end
      else
        wezterm.log_error("Failed to run fd for git worktree: " .. stderr)
      end
    end

    table.insert(projects, { label = tostring(label), id = tostring(id) })
  end

  window:perform_action(
    act.InputSelector({
      action = wezterm.action_callback(function(win, _, id, label)
        if not id and not label then
          wezterm.log_info("Cancelled")
        else
          wezterm.log_info("Selected " .. label)
          win:perform_action(
            act.SwitchToWorkspace({
              name = id,
              spawn = { cwd = home .. label },
            }),
            pane
          )
        end
      end),
      fuzzy = true,
      title = "Select Project",
      choices = projects,
    }),
    pane
  )
end

return M
