local function config()
  require("rose-pine").setup({
    variant = "main",
    dark_variant = "main",
    dim_inactive_windows = false,
    extend_background_behind_borders = false,

    styles = {
      bold = false,
      italic = false,
      transparency = false,
    },

    highlight_groups = {
      WinBar = { fg = "subtle", bg = "base" },
      WinBarNC = { fg = "muted", bg = "base" },
    },
  })

  vim.cmd.colorscheme("rose-pine")
end

return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    lazy = false,
    config = config,
  },
}
