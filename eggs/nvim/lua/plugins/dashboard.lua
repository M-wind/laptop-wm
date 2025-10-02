local logo = [[
  ____                     _                _
  |_  /          __ __ __  (_)    _ _     __| |
   / /     ___   \ V  V /  | |   | ' \   / _` |
  /___|   |___|   \_/\_/  _|_|_  |_||_|  \__,_|
_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|
"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'
]]

-- local logo = [[
--
--
--
--  ______ .-.  .-.,-..-. .-. ,'|"\
-- /___  / | |/\| ||(||  \| | | |\ \
--    / /) | /  \ |(_)|   | | | | \ \
--   / /(_)|  /\  || || |\  | | |  \ \
--  / /___ |(/  \ || || | |)| /(|`-' /
-- (_____/ (_)   \|`-'/(  (_)(__)`--'
--                   (__)
-- ]]

logo = string.rep("\n", 8) .. logo .. "\n\n"

return {
  {
    "nvimdev/dashboard-nvim",
    -- event = "VimEnter",
    lazy = true,
    opts = function()
      return {
        center = {
          { action = "Telescope fd", icon = " ", desc = "Find File", key = "f" },
          { action = "Telescope oldfiles", icon = " ", desc = "Recent File", key = "o" },
          {
            action = function()
              require("utils.livegrep").multi()
            end,
            icon = " ",
            desc = "Find Text",
            key = "r",
          },
          -- {
          --   action = function()
          --     require("session_manager").load_session()
          --   end,
          --   icon = "󱈅 ",
          --   desc = "Session",
          --   key = "s",
          -- },
          { action = "Telescope zoxide list", icon = "󰴠 ", desc = "Path List", key = "z" },
          -- { action = "ene", icon = " ", desc = "New File", key = "a" },
          { action = "qa", icon = " ", desc = "Quit", key = "q" },
        },
      }
    end,
    config = function(_, opts)
      local m = {}
      for key, item in ipairs(opts.center) do
        item.desc = item.desc .. string.rep(" ", 40 - #item.desc)
        item.key_format = "  %s"
        m[key] = item
      end
      require("dashboard").setup({
        theme = "doom",
        -- hide = { statusline = false },
        config = {
          header = vim.split(logo, "\n"),
          center = m,
          footer = {},
          vertical_center = false,
        },
      })
    end,
  },
}
