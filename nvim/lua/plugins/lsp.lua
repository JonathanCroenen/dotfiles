local on_attach = function(client, bufnr)
  local map = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  map("<leader>lr", vim.lsp.buf.rename, "[r]ename")
  map("<leader>lf", vim.lsp.buf.format, "[f]ormat buffer")
  map("<leader>la", vim.lsp.buf.code_action, "code [a]ction")
  map("gd", require("telescope.builtin").lsp_definitions, "[g]o [d]efinition")
  map("gD", vim.lsp.buf.declaration, "[g]o [d]eclaration")
  map("gr", require("telescope.builtin").lsp_references, "[g]o [r]eferences")
  map("gI", require("telescope.builtin").lsp_implementations, "[g]o [i]mplementations")
  map("<leader>td", require("telescope.builtin").lsp_type_definitions, "[t]ype [d]efinitions")
  map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[d]ocument [s]ymbols")
  map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[w]orkspace [s]ymbols")

  map("[d", vim.diagnostic.goto_prev, "go previous [d]iagnostic")
  map("]d", vim.diagnostic.goto_next, "go next [d]iagnostic")
  map("<leader>df", vim.diagnostic.open_float, "open [d]iagnostic [f]loat")
  map("<leader>dq", vim.diagnostic.setloclist, "set [d]iagnostic quicklist")

  map("K", vim.lsp.buf.hover, "hover documentation")
  map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[w]orkspace [a]dd folder")
  map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[w]orkspace [r]emove folder")
  map("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[w]orkspace [l]ist folders")

  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end
end

local function config_navic()
  require("nvim-navic").setup({
    icons = require("config.icons"),
    highlight = true,
  })

  vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
end

local function config()
  require("neodev").setup()
  require("mason").setup()
  require("mason-lspconfig").setup()
  config_navic()

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  local lspconfig = require("lspconfig")
  for name, specific_settings in pairs(require("config.language-servers")) do
    local settings = {
      on_attach = on_attach,
      capabilities = capabilities
    }

    settings = vim.tbl_deep_extend("force", specific_settings, settings)
    lspconfig[name].setup(settings)
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = config,
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",

      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",

      {
        "SmiteshP/nvim-navic",
        event = { "BufReadPre", "BufNewFile" },
      },
    },
  },
}
