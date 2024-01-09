local function config()
  require("Comment").setup()

  vim.keymap.set("n", "<C-/>", function()
    require("Comment.api").toggle.linewise.current()
  end, { desc = "Comment: toggle line", silent = true })

  vim.keymap.set("x", "<C-/>", function()
    local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
    vim.api.nvim_feedkeys(esc, "nx", false)
    require("Comment.api").toggle.linewise(vim.fn.visualmode())
  end, { desc = "Comment: toggle selection", silent = true })
end

return {
  "numToStr/Comment.nvim",
  config = config,
}
