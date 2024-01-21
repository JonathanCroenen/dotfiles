local on_attach = function(_, bufnr)
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
end

local function apply_diagnostic_icons()
  local set_diagnostic_sign = function(type, icon)
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  local icons = require("config.icons")
  set_diagnostic_sign("Error", icons.error)
  set_diagnostic_sign("Warn", icons.warn)
  set_diagnostic_sign("Info", icons.info)
  set_diagnostic_sign("Hint", icons.hint)
end

local function config()
  require("neodev").setup()
  require("mason").setup()

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  local lspconfig = require("lspconfig")
  for name, settings in pairs(require("config.language-servers")) do
    lspconfig[name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = settings,
      filetypes = settings.filetypes,
    })
  end

  local cmp = require("cmp")
  local luasnip = require("luasnip")
  require("luasnip.loaders.from_vscode").lazy_load()
  luasnip.config.setup({})

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<Up>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.close()
        end
        fallback()
      end, { "i" }),
      ["<Down>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.close()
        end
        fallback()
      end, { "i" }),
      ["<C-p>"] = cmp.mapping.scroll_docs(-2),
      ["<C-n>"] = cmp.mapping.scroll_docs(2),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete({}), { "i", "c" }),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = false,
      }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    formatting = {
      fields = { "kind", "abbr", "menu" },
      expandable_indicator = true,
      format = require("lspkind").cmp_format({
        mode = "symbol_text",
        maxwidth = 60,
        ellipsis_char = "...",
        symbol_map = {
          Copilot = "",
        },
        before = function(entry, vim_item)
          if vim.tbl_contains({ "path" }, entry.source.name) then
            local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)

            if icon then
              vim_item.kind = icon
              vim_item.kind_hl_group = hl_group
            end
          end
          return vim_item
        end,
      }),
    },
    sources = cmp.config.sources({
      {
        name = "nvim_lsp",
        entry_filter = function(entry, _)
          return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
        end,
      },
      { name = "copilot" },
      { name = "luasnip" },
      {
        name = "path",
        option = {
          trailing_slash = true,
          get_cwd = vim.loop.cwd,
        },
      },
    }, {
      { name = "buffer" },
    }),
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "path" },
      { name = "cmdline" },
    },
  })

  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
  apply_diagnostic_icons()
end

return {
  {
    "hrsh7th/nvim-cmp",
    event = { "BufReadPre", "BufNewFile" },
    config = config,

    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",

      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",

      {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
          { "williamboman/mason.nvim", config = true },
          "williamboman/mason-lspconfig.nvim",

          "folke/neodev.nvim",
        },
      },
    },
  },
}
