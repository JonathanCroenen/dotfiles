return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  tag = "v3.8.2",
  main = "ibl",
  opts = {
    indent = {
      char = "┆",
      smart_indent_cap = true,
    },
    whitespace = {
      remove_blankline_trail = true,
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
    },
    exclude = {
      filetypes = { "help", "alpha", "dashboard", "NvimTree" },
      buftypes = { "terminal", "nofile" },
    }
  }
}
