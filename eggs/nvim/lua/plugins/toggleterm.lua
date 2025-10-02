return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Open Terminal" },
    },
    opts = {
      size = 20,
      -- open_mappings = [[<c-/>]],
      hide_numbers = true,
      autochdir = false,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      -- direction = "float",
      direction = "horizontal",
      close_on_exit = true,
      shell = "~/app/tools/nu",
      float_opts = {
        border = "curved",
        winblend = 0,
      },
      highlights = {
        FloatBorder = {
          link = "FloatBorder",
        },
      },
    },
  },
}
