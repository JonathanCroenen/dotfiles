local function config()
  require("copilot").setup({
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = false,
    },
  })

  require("copilot_cmp").setup()
end

return {
  "zbirenbaum/copilot-cmp",
  event = "VeryLazy",
  dependencies = {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
  },
  config = config,
}
