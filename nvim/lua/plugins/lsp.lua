local function config_navic()
  ---@diagnostic disable-next-line: missing-fields
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
      capabilities = capabilities,
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
