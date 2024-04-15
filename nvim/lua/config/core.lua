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

-- Disable unused fold keymaps
map("n", "za", "<Nop>", "disable default za")
map("n", "zA", "<Nop>", "disable default zA")
map("n", "zc", "<Nop>", "disable default zc")
map("n", "zC", "<Nop>", "disable default zC")
map("n", "zi", "<Nop>", "disable default zi")
map("n", "zm", "<Nop>", "disable default zm")
map("n", "zM", "<Nop>", "disable default zM")
map("n", "zo", "<Nop>", "disable default zo")
map("n", "zO", "<Nop>", "disable default zO")
map("n", "zr", "<Nop>", "disable default zr")
map("n", "zR", "<Nop>", "disable default zR")
map("n", "zx", "<Nop>", "disable default zx")
map("n", "zf", "<Nop>", "disable default zf")

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

-- [[ Latex Optimizations ]]
vim.g.tex_flavor = "latex"

local function latex_build()
  local function on_exit(obj)
    vim.schedule(function()
      vim.cmd("redraw!")
    end)

    if obj.code ~= 0 then
      vim.notify("LaTeX build failed:\n" .. obj.stderr, "error")
    else
      vim.notify("LaTeX build succesful")
    end
  end

  return vim.system(
    { "latexmk", "-pdf", "-interaction=nonstopmode", "-silent", "-outdir=build/" },
    { cwd = vim.fn.getcwd(), text = true },
    on_exit
  )
end

local function open_file(file, hl)
  if hl then
    vim.system({ "okular", "--unique", file, "--find", hl }, { cwd = vim.fn.getcwd(), text = true })
  else
    vim.system({ "okular", "--unique", file }, { cwd = vim.fn.getcwd(), text = true })
  end
end

local function find_compiled_pdf()
  local cwd = vim.fn.getcwd()
  local content = vim.split(vim.fn.glob(cwd .. "/build/*"), "\n", { trimempty = true })
  for _, item in pairs(content) do
    if item:match("%.pdf$") then
      return item
    end
  end

  return nil
end

local function latex_view(hl)
  latex_build():wait()
  open_file(find_compiled_pdf(), hl)
end

local function latex_highlight_line()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[1]
  open_file(find_compiled_pdf(), line)
end

local latex_augroup = vim.api.nvim_create_augroup("latex", { clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "tex", "plaintex", "bib" },
  group = latex_augroup,
  callback = function()
    vim.keymap.set("n", "<leader>lb", latex_build, { desc = "LaTeX: [b]uild", buffer = true })
    vim.keymap.set("n", "<leader>lv", latex_view, { desc = "LaTeX: [v]iew", silent = true, buffer = true })
    vim.keymap.set(
      "n",
      "<leader>lh",
      latex_highlight_line,
      { desc = "LaTeX: [h]ighlight current line", silent = true, buffer = true }
    )
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.tex", "*.bib" },
  group = latex_augroup,
  callback = function()
    latex_build()
  end,
})
