local function config()
  local notify = require("notify")
  local icons = require("config.icons")

  notify.setup({
    timeout = 3000,
    max_width = 120,
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
end

return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  config = config,
}
