local function config()
  local notify = require("notify")
  local icons = require("config.icons")

---@diagnostic disable-next-line: missing-fields
  notify.setup({
    timeout = 3000,
    max_width = 60,
    render = "default",
    stages = "fade",
    icons = {
      ERROR = icons.error,
      WARN = icons.warn,
      INFO = icons.info,
      DEBUG = icons.debug,
      TRACE = icons.trace,
    },
    on_open = function(win)
      local conf = vim.api.nvim_win_get_config(win)
      conf.border = "single"
      vim.api.nvim_win_set_config(win, conf)
    end,
  })

  vim.notify = notify

  local telescope = require("telescope")
  pcall(telescope.load_extension, "notify")
  vim.keymap.set("n", "<leader>fn", telescope.extensions.notify.notify, { desc = "Telescope: [f]ind [n]otifications" })
end

return {
  "rcarriga/nvim-notify",
  version = "*",
  event = "VeryLazy",
  config = config,

  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
}
