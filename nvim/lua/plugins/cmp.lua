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

local function cmp_formatting(_, vim_item)
  vim_item.kind = string.format("%s%s", require("config.icons")[vim_item.kind], vim_item.kind)

  local MAX_LABEL_WIDTH = 60
  local label = vim_item.abbr
  local truncated = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
  if truncated ~= label then
    vim_item.abbr = truncated .. "…"
  end

  vim_item.menu = ""
  return vim_item
end

local function config()
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
    mapping = {
      ["<C-p>"] = cmp.mapping.scroll_docs(-2),
      ["<C-n>"] = cmp.mapping.scroll_docs(2),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete({}), { "i", "c" }),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<C-y>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
      ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

      ["<C-f>"] = cmp.mapping(function(fb)
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fb()
        end
      end),
      ["<C-b>"] = cmp.mapping(function(fb)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fb()
        end
      end),
    },
    formatting = {
      fields = { "abbr", "kind" },
      expandable_indicator = true,
      format = cmp_formatting,
    },
    window = {
      completion = cmp.config.window.bordered({
        border = "single",
      }),
      documentation = cmp.config.window.bordered({
        border = "single",
      }),
    },
    sources = cmp.config.sources({
      {
        name = "nvim_lsp",
        entry_filter = function(entry, _)
          return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
        end,
      },
      { name = "nvim_lsp_signature_help" },
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
      { name = "buffer", keyword_length = 5 },
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

  apply_diagnostic_icons()
  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
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
      "hrsh7th/cmp-nvim-lsp-signature-help",

      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
      },
      "saadparwaiz1/cmp_luasnip",
    },
  },
}
