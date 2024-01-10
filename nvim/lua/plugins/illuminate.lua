local function config()
  vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
  vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
  vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

  require("illuminate").configure({
    providers = {
      "treesitter",
      "regex",
    },
    delay = 300,
    filetypes_denylist = {
      "fugitive",
      "alpha",
      "neogitstatus",
      "Trouble",
      "lir",
      "Outline",
      "DressingSelect",
      "TelescopePrompt",
    },
    under_cursor = true,
    large_file_cutoff = 5000,
    min_count_to_highlight = 2,
  })
end

return {
  "RRethy/vim-illuminate",
  event = { "BufReadPre *", "BufNewFile" },
  config = config
}
