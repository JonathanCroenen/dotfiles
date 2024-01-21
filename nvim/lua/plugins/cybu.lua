local function config()
  local cybu = require("cybu")
  cybu.setup({
    style = {
      border = "single",
    }
  })

  vim.keymap.set("n", "<C-h>", function() cybu.cycle("prev", "last_used") end, { silent = true, noremap = true })
  vim.keymap.set("n", "<C-l>", function() cybu.cycle("next", "last_used") end, { silent = true, noremap = true })
end


return {
  "ghillb/cybu.nvim",
  event = "BufRead",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = config
}
