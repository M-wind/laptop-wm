local comment = {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  config = function()
    require("Comment").setup()
    local ft = require("Comment.ft")
    ft.dosini = "# %s"
    ft.tsx = { "//%s", "{/* %s */}" }
    ft.conf = "# %s"
  end,
}

local tscomment = {
  "folke/ts-comments.nvim",
  opts = {},
  event = "VeryLazy",
  enabled = vim.fn.has("nvim-0.10.0") == 1,
}

return {
  comment,
  -- tscomment,
}
