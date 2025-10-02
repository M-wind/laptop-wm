return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 100
    end,
    opts = {
      -- preset = "helix",
      preset = false,
      win = {
        width = { min = 30, max = 60 },
        height = { min = 4, max = 0.75 },
        padding = { 0, 1 },
        col = 1,
        row = -1,
        border = "rounded",
        title = true,
        title_pos = "center",
        no_overlap = true,
      },
      layout = { spacing = 3, width = { min = 30 } },
      keys = {
        scroll_down = "<c-f>",
        scroll_up = "<c-d>",
      },
      icons = {
        rules = false,
        keys = {
          Space = "󱁐",
        },
      },
      triggers = {
        { "<leader>", mode = { "n", "v" } },
        { "g", mode = { "n", "v" } },
      },
      plugins = {
        marks = false,
        registers = false,
        spelling = { enabled = false },
        presets = {
          operators = true,
          motions = false,
          text_objects = false,
          windows = false,
          nav = false,
          g = false,
          z = false,
        },
      },
      show_help = false,
      show_keys = false,
      debug = false,
      spec = {
        {
          { "gi", desc = "Go To Last Insert" },
          { "gv", desc = "Last Visual Selection" },
          { "gb", desc = "Comment Toggle Block" },
          { "gc", desc = "Comment Toggle Line" },
          { "gbc", desc = "Comment Toggle Current Block" },
          { "gcA", desc = "Comment Insert End Of Line" },
          { "gcc", desc = "Comment Toggle Current Line" },
          { "gco", desc = "Comment Insert Below" },
          { "gcO", desc = "Comment Insert Above" },
        },
        {
          mode = { "v" },
          { "gb", desc = "Comment Toggle Block" },
          { "gc", desc = "Comment Toggle Line" },
        },
        {
          mode = { "n", "v" },
          { "<leader>b", group = "Buffer" },
          { "<leader>f", group = "Find/File" },
          { "<leader>w", group = "Window" },
          { "<leader>s", group = "Session" },
          { "z", hidden = true },
          { "[", hidden = true },
          { "]", hidden = true },
          { "<c-w>", hidden = true },
          { "gx", desc = "Open FilePath or URL Under Cursor" },
          { "g~", desc = "Toggle Case" },
        },
      },
    },
  },
}
