local function config()
  require("noice").setup({
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      signature = {
        opts = {
          position = {
            -- col = 50, -- is equal to cmp maxwidth to prevent overlap with completion menu
          },
        },
      },
    },
    presets = {
      bottom_search = false,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = true,
    },
    views = {
      cmdline_popup = {
        position = {
          row = "50%",
          col = "50%",
        },
        border = {
          style = "double",
        },
        win_options = {
          winhighlight = { NormalFloat = "NormalFloat", FloatBorder = "FloatBorder" },
        },
      },
      hover = {
        border = {
          style = "single",
        },
      },
      confirm = {
        border = {
          style = "single",
        },
      },
      popup = {
        border = {
          style = "single",
        },
      },
      popupmenu = {
        border = {
          style = "single",
        },
      },
    },
    format = {
      level = {
        icons = {
          error = require("config.icons").error,
          warn = require("config.icons").warn,
          info = require("config.icons").info,
        },
      },
    },
  })

  local telescope = require("telescope")
  pcall(telescope.load_extension, "noice")
  vim.keymap.set("n", "<leader>fm", telescope.extensions.noice.noice, { desc = "Telescope: [f]ind [m]messages" })
end

return {
  enabled = false,
  "folke/noice.nvim",
  event = "VeryLazy",
  config = config,

  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
