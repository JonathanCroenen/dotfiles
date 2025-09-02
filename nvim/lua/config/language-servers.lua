return {
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
      -- to add more checks, create .clang-tidy file in the root directory
      -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
      "--clang-tidy",
      "--completion-style=bundled",
      "--cross-file-rename",
      "--header-insertion=iwyu",
      "--offset-encoding=utf-16",
    },
    capabilities = { offsetEncoding = { "utf-16" } },
  },

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
  ts_ls = {},
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
  ocamllsp = {},
}
