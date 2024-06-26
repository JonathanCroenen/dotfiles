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
map("n", "<C-Q>", ":bnext<CR>:bdelete!#<CR>", "forcefully [q]uit buffer")
map("n", "<C-q>", ":bnext<CR>:bdelete#<CR>", "[q]uit buffer")

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
