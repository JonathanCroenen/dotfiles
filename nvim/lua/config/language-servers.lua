return {
  clangd = { capabilities = { offsetEncoding = { "utf-8" } } },

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
  texlab = {},
  omnisharp = {},
  grammarly = {
    filetypes = { "markdown", "tex", "plaintex" },
  },
  matlab_ls = {
    single_file_support = true,
    settings = {
      MATLAB = {
        indexWorkspace = true,
        telemetry = false,
      },
    },
  },
}
