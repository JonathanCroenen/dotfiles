-- [[ Basic Keymappings ]]
local function map(mode, keys, func, desc)
  vim.keymap.set(mode, keys, func, { desc = desc, silent = true })
end

-- Disable annoying defaults
map({ "n", "v" }, "<Space>", "<Nop>", "disable default space")
map("n", "J", "<Nop>", "disable default J")
map("n", "K", "<Nop>", "disable default K")

-- Easier save mapping
local save = function()
  if vim.api.nvim_buf_get_name(0) == "" then
    local filename = vim.fn.input("Save as: ")
    if filename ~= "" then
      vim.cmd.write(filename)
    end
  else
    vim.cmd("silent update")
  end
end

map("n", "<C-s>", save, "save file")

-- Close buffer and go to the previous one
map("n", "<leader>q", ":bnext<CR>:bdelete!#<CR>", "forcefully [q]uit buffer")
map("n", "<C-q>", function()
  vim.cmd.bnext()
  local ok, msg = pcall(vim.cmd.bd, "#")
  if not ok then
    vim.cmd.b("#")
    if msg ~= nil then
      vim.api.nvim_err_writeln(msg)
    end
  end
end, "[q]uit buffer")

-- Mappings for cycling buffers NOTE: handled by cybu
-- map("n", "<C-h>", ":bprev<CR>", "previous buffer")
-- map("n", "<C-l>", ":bnext<CR>", "next buffer")

-- Quickfix list mappings
map("n", "[q", ":cprev<CR>", "previous [q]uickfix item")
map("n", "]q", ":cnext<CR>", "next [q]uickfix item")

-- Remove search highlights
map("n", "<leader>h", ":nohlsearch<CR>", "remove search [h]ighlights")

-- Change indent and keep visual mode
map("v", "<", "<gv", "reduce indent")
map("v", ">", ">gv", "increase indent")

-- Mappings for moving selections
map("v", "J", ":m '>+1<CR>gv=gv", "move selection down")
map("v", "K", ":m '<-2<CR>gv=gv", "move selection up")

-- Move half pages and recenter
map("n", "<C-d>", "zz<C-d>", "half page [d]own")
map("n", "<C-u>", "zz<C-u>", "half page [u]p")

-- Paste in visual mode (and) keep original clipboard
map("v", "p", "\"_dP", "paste over selection")

-- Mappings for surround replacement
map("v", "S(", "<ESC>`>a)<ESC>`<i(<ESC>lv`>l", "[s]urround selection with ()")
map("v", "S[", "<ESC>`>a]<ESC>`<i[<ESC>lv`>l", "[s]urround selection with []]")
map("v", "S{", "<ESC>`>a}<ESC>`<i{<ESC>lv`>l", "[s]urround selection with {}}")
map("v", "S'", "<ESC>`>a'<ESC>`<i'<ESC>lv`>l", "[s]urround selection with ''")
map("v", "S\"", "<ESC>`>a\"<ESC>`<i\"<ESC>lv`>l", "[s]urround selection with \"\"")
map("v", "S`", "<ESC>`>a`<ESC>`<i`<ESC>lv`>l", "[s]urround selection with ``")
map("v", "S<", "<ESC>`>a><ESC>`<i<<ESC>lv`>l", "[s]urround selection with <>")
map("v", "Sd", "<ESC>`>lx`<hxv`>h", "[d]elete [s]urrounding characters")

-- Mappings to ease navigating wrapped lines
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Mapping to open links
map("n", "gx", ":execute '!xdg-open ' . shellescape(expand('<cfile>'), 1)<CR>", "[g]o to url")

-- Mappings to resize splits
map("n", "<C-Up>", ":resize +2<CR>", "increase split size")
map("n", "<C-Down>", ":resize -2<CR>", "decrease split size")
map("n", "<C-Left>", ":vertical resize +2<CR>", "increase vertical split size")
map("n", "<C-Right>", ":vertical resize -2<CR>", "decrease vertical split size")

-- LSP Mappings & Auto CMDs
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    map("n", "<leader>lr", vim.lsp.buf.rename, "[r]ename")
    map("n", "<leader>lf", vim.lsp.buf.format, "[f]ormat buffer")
    map("n", "<leader>la", vim.lsp.buf.code_action, "code [a]ction")
    map("n", "gd", require("telescope.builtin").lsp_definitions, "[g]o [d]efinition")
    map("n", "gD", vim.lsp.buf.declaration, "[g]o [d]eclaration")
    map("n", "gr", require("telescope.builtin").lsp_references, "[g]o [r]eferences")
    map("n", "gI", require("telescope.builtin").lsp_implementations, "[g]o [i]mplementations")
    map("n", "<leader>td", require("telescope.builtin").lsp_type_definitions, "[t]ype [d]efinitions")
    map("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, "[d]ocument [s]ymbols")
    map("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[w]orkspace [s]ymbols")

    map("n", "[d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, "go previous [d]iagnostic")
    map("n", "]d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, "go next [d]iagnostic")
    map("n", "<leader>df", vim.diagnostic.open_float, "open [d]iagnostic [f]loat")
    map("n", "<leader>dq", vim.diagnostic.setloclist, "set [d]iagnostic quicklist")

    map("n", "K", vim.lsp.buf.hover, "hover documentation")
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "[w]orkspace [a]dd folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "[w]orkspace [r]emove folder")
    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[w]orkspace [l]ist folders")

    if client.supports_method("textDocument/documentSymbol") then
      require("nvim-navic").attach(client, args.buf)
    end

    -- Format on save
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
        end,
      })
    end
  end,
})

-- Debugger Mappings
local ok, dap = pcall(require, "dap")
if ok then
  map("n", "<leader>dc", dap.continue, "dap [c]ontinue")
  map("n", "<leader>do", dap.step_over, "dap step [o]ver")
  map("n", "<leader>di", dap.step_into, "dap step [i]nto")
  map("n", "<leader>du", dap.step_out, "dap step out")
  map("n", "<leader>db", dap.toggle_breakpoint, "toggle [b]reakpoint")
  map("n", "<leader>dt", dap.terminate, "dap [t]erminate")
  map("n", "<leader>dp", dap.pause, "dap [p]ause")
  map("n", "<leader>dr", dap.restart, "dap [r]estart")
  map("n", "<leader>dh", dap.run_to_cursor, "dap run to [h]ere")
end

local ok, dapui = pcall(require, "dapui")
if ok then
  map("n", "<M-k>", dapui.eval, "hover value under cursor")
  map("n", "<leader>dui", dapui.toggle, "toggle dapui")
end

-- [[ Nice Auto Commands ]]
-- Highlight yanked text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = vim.api.nvim_create_augroup("yank-highlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 300 })
  end,
})

-- Close common info windows with just q
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "checkhealth", "notify" },
  group = vim.api.nvim_create_augroup("quick-exit", { clear = true }),
  callback = function()
    vim.keymap.set("n", "q", ":close<CR>", { silent = true, buffer = true })
    vim.o.buflisted = false
  end,
})

-- [[ Disable Netrw ]]
vim.g.loaded_netrw = 0
vim.g.leaded_netrwPlugin = 0
