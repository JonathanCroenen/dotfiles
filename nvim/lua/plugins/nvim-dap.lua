local function config()
  require("mason").setup()
  require("mason-nvim-dap").setup({
    ensure_installed = {
      "cppdbg",
      "python",
    },
    handlers = {},
  })

  require("nvim-dap-virtual-text").setup({
    highlight_changed_variables = true,
    highlight_new_as_changed = true,
  })

  local dap, dapui = require("dap"), require("dapui")
  dapui.setup()

  dap.listeners.before.attach.dapui_config = dapui.open
  dap.listeners.before.launch.dapui_config = dapui.open
end

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
    "theHamsta/nvim-dap-virtual-text",
    { "jay-babu/mason-nvim-dap.nvim", dependencies = { "williamboman/mason.nvim" } },
  },
  event = "VeryLazy",
  config = config,
}
