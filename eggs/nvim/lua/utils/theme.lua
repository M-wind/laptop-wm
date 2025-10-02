local M = {}

local themes = {
  { idx = 1, text = "1: Everforest", value = "everforest" },
  { idx = 2, text = "2: Onedarkpro", value = "onedark" },
  { idx = 3, text = "3: Catppuccin", value = "catppuccin" },
  { idx = 4, text = "4: Solarized Osaka", value = "solarized-osaka" },
  { idx = 5, text = "5: Dracula", value = "dracula" },
  { idx = 6, text = "6: Tokyodark", value = "tokyodark" },
  -- { idx = 7, text = "7: Tokyonight Day", value = "tokyonight-day" },
  { idx = 7, text = "7: Vscode", value = "vscode" },
  { idx = 8, text = "8: Tokyonight Moon", value = "tokyonight-moon" },
  { idx = 9, text = "9: Bamboo", value = "bamboo" },
}

M.colors = {
  blue = "#80a0ff",
  cyan = "#79dac8",
  black = "#080808",
  white = "#c6c6c6",
  red = "#e06c75",
  violet = "#d183e8",
  grey = "#303030",
  green = "#98c379",
  orange = "#d19a66",
  yellow = "#e5c07b",
  comment = "#7f848e",
  none = "NONE",
  bg = "#181818"
}

M.tailwindColor = {}

M.change = function()
  -- local has_picker, picker = pcall(require, "snacks.picker")
  -- if not has_picker then
  --   Snacks.notify.error("Can't Find Snacks Picker.")
  --   return
  -- end
  -- picker.pick({
  --   title = " Themes",
  --   items = themes,
  --   layout = {
  --     preview = false,
  --     layout = {
  --       backdrop = false,
  --       width = 35,
  --       height = #themes + 2,
  --       box = "vertical",
  --       border = "rounded",
  --       title = "{title}",
  --       title_pos = "center",
  --       { win = "input", height = 1, border = "bottom" },
  --       { win = "list", border = "none" },
  --     },
  --   },
  --   sort = { "idx" },
  --   format = "text",
  --   confirm = function(pick, item)
  --     if vim.g.colors_name == item.value then
  --       Snacks.notify.error("Already The Theme.")
  --       return
  --     end
  --     vim.cmd("colorscheme " .. item.value)
  --     for k, v in pairs(M.tailwindColor) do
  --       vim.api.nvim_set_hl(0, k, { fg = v })
  --     end
  --     pick:close()
  --   end,
  -- })
  local finders = require("telescope.finders")
  local pickers = require("telescope.pickers")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local sorter = require("telescope.sorters").get_fzy_sorter()

  local create_mapping = function(prompt_bufnr, mapping_config)
    return function()
      local selection = action_state.get_selected_entry()
      if mapping_config.before_action ~= nil then
        mapping_config.before_action(selection)
      end

      -- Close Telescope window
      actions._close(prompt_bufnr, mapping_config.keepinsert or false)

      mapping_config.action(selection)

      if mapping_config.after_action ~= nil then
        mapping_config.after_action(selection)
      end
    end
  end

  local entry_maker = function(entry)
    return { ordinal = entry.text, display = entry.text, value = entry.value }
  end

  pickers
    .new({
      sorting_strategy = "ascending",
      layout_strategy = "center",

      layout_config = { height = #themes + 4, width = 35 },
    }, {
      prompt_title = " Themes",
      finder = finders.new_table({
        results = themes,
        entry_maker = entry_maker,
      }),
      sorter = sorter,
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(create_mapping(prompt_bufnr, {
          action = function(selection)
            if vim.g.colors_name == selection.value then
              vim.notify("Already The Theme.")
              return
            end
            vim.cmd("colorscheme " .. selection.value)
            for k, v in pairs(M.tailwindColor) do
              vim.api.nvim_set_hl(0, k, { fg = v })
            end
            if vim.g.neovide then
              -- neovide 背景颜色  hyprland 应用透明和模糊
              -- vim.api.nvim_set_hl(0, "Normal", { bg = M.colors.bg })
              -- 清除颜色 防止 浮动窗口有背景模糊
              vim.cmd("hi clear Normal")
            end
          end,
        }))
        return true
      end,
    })
    :find()
end

return M
