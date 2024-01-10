vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  install = { colorscheme = { "rose-pine" } },
  checker = {
    enabled = true,
    concurrency = 1,
    notify = true,
    frequency = 60 * 60 * 24, -- every 2 days
  },
  change_detection = {
    enable = true,
    notify = false,
  },
})

require("config.core")
require("config.options")
