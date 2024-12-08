local function config()
  require("nvim-treesitter.configs").setup({
    modules = {},
    ignore_install = {},
    ensure_installed = {
      "c",
      "cpp",
      "lua",
      "python",
      "rust",
      "ocaml",
      "javascript",
      "typescript",
      "vimdoc",
      "vim",
      "bash",
    },
    auto_install = true,
    sync_install = true,
    highlight = {
      enable = true,
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-Space>",
        node_incremental = "<C-Space>",
        scope_incremental = "<C-S>",
        node_decremental = "<S-Space>",
      },
    },
    textobjects = {
      select = { enable = false },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]c"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]C"] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[c"] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[C"] = "@class.outer",
        },
      },
    },
  })
end

return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  event = { "BufReadPre", "BufNewFile" },
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })
  end,

  config = config,
}
