local function config()
  local notify = require("notify")
  local icons = require("config.icons")

  notify.setup({
    timeout = 3000,
    max_width = 60,
    icons = {
      ERROR = icons.error,
      WARN = icons.warn,
      INFO = icons.info,
      DEBUG = icons.debug,
      TRACE = icons.trace,
    },
  })

  vim.notify = notify

  vim.api.nvim_set_hl(0, "NotifyERRORBorder", { link = "Error" })
  vim.api.nvim_set_hl(0, "NotifyWARNBorder", { link = "WarningMsg" })
  vim.api.nvim_set_hl(0, "NotifyINFOBorder", { link = "LspInfoList" })
  vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { link = "Debug" })
  vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { link = "Character" })

  vim.api.nvim_set_hl(0, "NotifyERRORIcon", { link = "Error" })
  vim.api.nvim_set_hl(0, "NotifyWARNIcon", { link = "WarningMsg" })
  vim.api.nvim_set_hl(0, "NotifyINFOIcon", { link = "LspInfoList" })
  vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { link = "Debug" })
  vim.api.nvim_set_hl(0, "NotifyTRACEIcon", { link = "Character" })

  vim.api.nvim_set_hl(0, "NotifyERRORTitle", { link = "Error" })
  vim.api.nvim_set_hl(0, "NotifyWARNTitle", { link = "WarningMsg" })
  vim.api.nvim_set_hl(0, "NotifyINFOTitle", { link = "LspInfoList" })
  vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { link = "Debug" })
  vim.api.nvim_set_hl(0, "NotifyTRACETitle", { link = "Character" })
end

return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  config = config,
}
