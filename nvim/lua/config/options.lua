local options = {
  backup = false,
  writebackup = false,
  clipboard = "unnamedplus",
  cmdheight = 0,
  completeopt = { "menu", "menuone", "noselect", "noinsert", "preview" },
  conceallevel = 0,
  fileencoding = "utf-8",
  hlsearch = true,
  incsearch = true,
  ignorecase = true,
  mouse = "a",
  showmode = false,
  showtabline = 1,
  smartcase = true,
  autoindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  termguicolors = true,
  timeoutlen = 300,
  undofile = true,
  updatetime = 300,
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  cursorline = true,
  number = true,
  relativenumber = true,
  numberwidth = 4,
  signcolumn = "yes",
  wrap = true,
  linebreak = true,
  scrolloff = 8,
  sidescrolloff = 6,
  whichwrap = "bs<>[]hl",
  shell = "/usr/bin/zsh",
  foldenable = false,
  fillchars = {
    eob = " ",
    fold = " ",
  },
  list = true,
  listchars = {
    tab = "→ ",
    trail = "·",
    extends = "…",
    precedes = "…",
    nbsp = "␣",
  },
  laststatus = 2,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- vim.cmd("filetype on")
-- vim.cmd("filetype plugin off")
-- vim.cmd("filetype indent on")
