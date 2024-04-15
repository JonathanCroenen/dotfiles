local function config()
  local cybu = require("cybu")
  cybu.setup({
    behavior = {
      mode = {
        default = {
          view = "paging",
        },
        last_used = {
          view = "paging",
        },
      },
    },
    style = {
      border = "single",
    },
    display_time = 600,
  })

  vim.keymap.set("n", "<C-h>", function() cybu.cycle("prev", "default") end, { silent = true, noremap = true })
  vim.keymap.set("n", "<C-l>", function() cybu.cycle("next", "default") end, { silent = true, noremap = true })
end


return {
  "ghillb/cybu.nvim",
  event = "BufRead",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = config
}
