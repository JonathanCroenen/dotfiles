return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChatToggle<CR>", desc = "toggle chat window" },
    },
    opts = {
      chat_window = {
        layout = "vertical",
        width = 0.35,
        height = 0.5,
      },
      question_header = " user ",
      answer_header = " copilot ",
      error_header = " error ",
      separator = "───",
    },
  },
}
