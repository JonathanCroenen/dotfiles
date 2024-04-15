local function config()
  local icons = require("config.icons")

  vim.diagnostic.config({
    virtual_text = false
  })

  require("corn").setup({
    icons = {
      error = icons.error,
      warn = icons.warn,
      hint = icons.hint,
      nifo = icons.info,
    },
    blacklisted_modes = { "i" },
    on_toggle = function(is_hidden)
      vim.diagnostic.config({
        virtual_text = not is_hidden
      })
    end,
    item_preprocess_func = function(item)
      return item
    end,
  })
end

return {
  "RaafatTurki/corn.nvim",
  config = config,
}
