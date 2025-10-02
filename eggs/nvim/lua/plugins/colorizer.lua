local colorizer = {
  "norcalli/nvim-colorizer.lua",
  event = "User FilePost",
  config = function()
    require("colorizer").setup({
      "*",
    })
  end,
}

return { colorizer }
