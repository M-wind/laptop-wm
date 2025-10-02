local session = {
  "Shatur/neovim-session-manager",
  -- dependencies = "nvim-lua/plenary.nvim",
  keys = {
    { "<leader>sl", "<cmd>SessionManager load_session<cr>", desc = "Select And Load Session" },
    { "<leader>sd", "<cmd>SessionManager delete_session<cr>", desc = "Select And Delete Session" },
    { "<leader>ss", "<cmd>SessionManager save_current_session<cr>", desc = "Save Current Session" },
  },
  opts = {
    sessions_dir = vim.fn.stdpath("state") .. "/sessions/"
  },
}

return { session }
