local progress = function()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local chars = { "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

local icons = require("config.icons")

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn", "hint" },
  symbols = {
    error = icons.error,
    warn = icons.warn,
    info = icons.info,
    hint = icons.hint,
  },
  colored = true,
  always_visible = true,
}

local diff = {
  "diff",
  symbols = {
    added = icons.added,
    modified = icons.modified,
    removed = icons.removed,
  },
  colored = true,
  cond = function()
    return vim.fn.winwidth(0) > 80
  end,
}

local filetype = {
  "filetype",
  icons_enabled = true,
}

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      icons_enabled = false,
      theme = "auto",
      component_separator = "|",
      section_separator = "",
      disabled_filetypes = { "alpha", "dashboard" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", diff, diagnostics },
      lualine_c = { "filename" },
      lualine_x = { "encoding", "fileformat", filetype },
      lualine_y = { "location" },
      lualine_z = { progress },
    },
  },
}
