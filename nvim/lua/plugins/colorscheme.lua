local function config()
  require("rose-pine").setup({
    variant = "main",
    dark_variant = "main",
    dim_inactive_windows = false,
    extend_background_behind_borders = false,

    styles = {
      bold = false,
      italic = true,
      transparency = false,
    }
  })

  vim.cmd.colorscheme("rose-pine")
end


return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    lazy = false,
    config = config
  }
}
