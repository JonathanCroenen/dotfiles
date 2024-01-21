return {
  clangd = { capabilities = { offsetEncoding = { "utf-16" } } },

  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        },
        telemetry = { enable = false },
      },
    },
  },

  html = {},
  tsserver = {},
  pyright = {},
  rust_analyzer = {},
  marksman = {},
  racket_langserver = {},
}
