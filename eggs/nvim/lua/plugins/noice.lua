local notify = {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  opts = { stages = "static", timeout = 3000 },
}

local nui = {
  "MunifTanjim/nui.nvim",
  lazy = true,
}

local noice = {
  "folke/noice.nvim",
  event = "VeryLazy",
  -- tag = "v4.4.7",
  keys = {
    { "<leader>n", "", desc = "+Noice" },
    {
      "<leader>nl",
      function()
        require("noice").cmd("last")
      end,
      desc = "Noice Last Message",
    },
    {
      "<leader>nh",
      -- function()
      --   require("noice").cmd("history")
      -- end,
      "<cmd>Noice telescope<cr>",
      desc = "Noice History",
    },
    {
      "<leader>na",
      function()
        require("noice").cmd("all")
      end,
      desc = "Noice All",
    },
    {
      "<leader>nd",
      function()
        require("noice").cmd("dismiss")
      end,
      desc = "Dismiss Asll",
    },
    -- { "<leader>nt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
    -- { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
    -- { "<c-d>", function() if not require("noice.lsp").scroll(-4) then return "<c-d>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
  },
  opts = {
    -- cmdline = {
    --   enabled = true,
    --   view = "cmdline_popup",
    --   opts = {
    --     position = "50%",
    --   },
    -- },
    commands = {
      history = { view = "popup" },
      all = { view = "popup" },
    },
    views = {
      messages = { view = "popup" },
      popup = { close = { keys = "<c-q>" } },
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      hover = {
        enabled = true,
        silent = true,
      },
    },
    presets = {
      bottom_search = false,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = true,
    },
  },
}

local dressing = {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    input = {
      mappings = {
        n = { ["<C-q>"] = "Close" },
        i = { ["<C-q>"] = "Close", ["<C-c>"] = false },
      },
    },
  },
}

return { notify, nui, noice, dressing }
-- return { nui, noice }
