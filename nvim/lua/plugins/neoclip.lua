local function is_whitespace(line)
  return vim.fn.match(line, [[^\s*$]]) ~= -1
end

local function all(tbl, check)
  for _, entry in ipairs(tbl) do
    if not check(entry) then
      return false
    end
  end
  return true
end

local function config()
  require("neoclip").setup({
    enable_persistent_history = true,
    enable_macro_history = false,
    filter = function(data)
      return not all(data.event.regcontents, is_whitespace)
    end,
    keys = {
      telescope = {
        i = {
          select = "<CR>",
          paste = "<M-p>",
          paste_behind = "<M-P>",
          delete = "<M-d>",
          edit = "<M-e>",
        },
        n = {
          select = "<CR>",
          paste = "p",
          paste_behind = "P",
          delete = "d",
          edit = "e",
        },
      },
    },
  })

  pcall(require("telescope").load_extension, "neoclip")

  vim.keymap.set("n", "<leader>p", function()
    require("telescope").extensions.neoclip.neoclip({ "star", "plus", "b" })
  end, { desc = "clipboard history", silent = true })
end

return {
  "AckslD/nvim-neoclip.lua",
  event = { "BufRead", "BufNewFile" },
  config = config,

  dependencies = {
    "kkharji/sqlite.lua",
    "nvim-telescope/telescope.nvim",
  },
}
