local function config()
  local none_ls = require("null-ls")
  local formatting = none_ls.builtins.formatting
  local diagnostics = none_ls.builtins.diagnostics

  none_ls.setup({
    debug = false,
    debounce = 250,
    sources = {
      formatting.black,
      formatting.prettier,
      formatting.stylua,
      formatting.clang_format,
      formatting.ocamlformat,
      diagnostics.todo_comments,
    },
  })
end

return {
  "nvimtools/none-ls.nvim",
  -- commit = "6be90f8",
  name = "none-ls",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = config,
}
