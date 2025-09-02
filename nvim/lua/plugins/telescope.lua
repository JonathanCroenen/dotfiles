local function map(keys, func, desc)
  if desc then
    desc = "Telescope: " .. desc
  end

  vim.keymap.set("n", keys, func, { desc = desc })
end

local function apply_keymaps()
  local telescope = require("telescope")
  local builtin = require("telescope.builtin")

  map("<leader>fr", builtin.oldfiles, "[f]ind [r]ecent files")
  map("<leader>b", builtin.buffers, "[f]ind [b]uffers")
  map("<leader>/", builtin.current_buffer_fuzzy_find, "find in current file")

  map("<leader>f/", function()
    builtin.live_grep({
      grep_open_files = true,
      prompt_title = "Grep in Open Files",
    })
  end, "[f]ind in open files")

  map("<leader>fs", builtin.builtin, "[f]ind builtin finders")
  map("<leader>fg", builtin.git_files, "[f]ind in [g]it files")
  map("<leader>ff", builtin.find_files, "[f]ind [f]iles")
  map("<leader>fh", builtin.help_tags, "[f]ind [h]elp tags")
  map("<leader>fg", builtin.live_grep, "[f]ind by [g]rep")
  map("<leader>fd", builtin.diagnostics, "[f]ind [d]iagnostics")
  map("<leader>fr", builtin.resume, "[f]ind [r]esume previous")

  map("<leader>fB", telescope.extensions.file_browser.file_browser, "[f]ile [b]rowser")
  map("<leader>fb", function()
    telescope.extensions.file_browser.file_browser({
      path = vim.fn.expand("%:p:h"),
    })
  end, "[f]ile [b]rowser")
end

local function apply_style()
  local fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg
  local fg_alt = vim.api.nvim_get_hl(0, { name = "Function" }).fg
  local bg = vim.api.nvim_get_hl(0, { name = "NormalFloat" }).bg
  local bg_alt = vim.api.nvim_get_hl(0, { name = "Visual" }).bg

  vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = bg_alt, bg = bg })
  vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = bg })
  vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = bg, bg = bg })
  vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = bg })
  vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = bg, bg = fg_alt })
  vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = bg_alt, bg = bg_alt })
  vim.api.nvim_set_hl(0, "TelescopePromptNormal", { fg = fg, bg = bg_alt })
  vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = fg_alt, bg = bg_alt })
  vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = bg, bg = fg_alt })
  vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = bg, bg = bg })
  vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = bg })
  vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = bg, bg = bg })
end

local function config()
  local actions = require("telescope.actions")
  local telescope = require("telescope")

  telescope.setup({
    defaults = {
      layout_strategy = "horizontal",
      layout_config = {
        width = 0.8,
        height = 0.8,
        preview_width = 0.5,
        prompt_position = "top",
      },
      prompt_prefix = "  ",
      selection_caret = "▶ ",
      file_ignore_patterns = { ".git/", "node_modules/" },
      sorting_strategy = "ascending",
      path_display = { "smart" },
      mappings = {
        i = {
          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-n>"] = false,
          ["<C-p>"] = false,
        },
      },
    },
    pickers = {
      buffers = {
        show_all_buffers = true,
        sort_mru = true,
        mappings = {
          i = {
            ["<M-d>"] = actions.delete_buffer,
          },
        },
      },
      current_buffer_fuzzy_find = {
        previewer = false,
        layout_config = {
          width = 0.5,
          height = 0.5,
        },
      },
    },
    extensions = {
      file_browser = {
        git_status = true,
        hijack_netrw = true,
        hidden = { file_browser = true, folder_browser = true },
        display_stat = { date = true, size = true },
        no_ignore = true,
      },
      ["ui-select"] = {
        layout_config = {
          width = 0.4,
          height = 0.4,
        },
      },
    },
  })

  local ok, _ = pcall(telescope.load_extension, "fzf")
  if not ok then
    vim.notify("Telescope FZF extension not found. Please install it.", vim.log.levels.ERROR)
  end
  ok, _ = pcall(telescope.load_extension, "file_browser")
  if not ok then
    vim.notify("Telescope File Browser extension not found. Please install it.", vim.log.levels.ERROR)
  end
  ok, _ = pcall(telescope.load_extension, "ui-select")
  if not ok then
    vim.notify("Telescope UI Select extension not found. Please install it.", vim.log.levels.ERROR)
  end

  apply_style()
  apply_keymaps()
end

return {
  "nvim-telescope/telescope.nvim",
  lazy = false, -- So that telescope file browser can open on startup
  config = config,

  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
}
