local function config()
  require("git-conflict").setup({
    default_mappings = {
      ours = "c",
      theirs = "i",
      none = "0",
      both = "b",
      next = "n",
      prev = "p",
    },
  })

  vim.api.nvim_create_autocmd("User", {
    pattern = "GitConflictDetected",
    callback = function()
      vim.notify("Conflict detected in " .. vim.fn.expand("<afile>"))
    end,
  })
end

return {
  "akinsho/git-conflict.nvim",
  version = "*",
  config = config,
}
