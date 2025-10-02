require("core.options")
require("core.keymaps")
require("core.lazy")

-- {% if theme.color_name != "wallpaper" %}
-- {# replace_quoted(theme.color_name) #}
require("solarized-osaka").load()
-- # {% else %}
--<yolk> require("solarized-osaka").load()
-- {% end %}
require("core.autocmds")

if vim.g.neovide then
  vim.keymap.set({ "n", "x", "v" }, "<C-S-V>", '"+p', { desc = "Paste system clipboard" })
  vim.keymap.set({ "i", "c" }, "<C-S-V>", "<C-R>+", { desc = "Paste system clipboard" })
  vim.g.neovide_refresh_rate = 60
  -- vim.g.neovide_cursor_animation_length = 0.04
  -- vim.g.neovide_cursor_trail_size = 0.7
  vim.g.neovide_cursor_animate_in_insert_mode = false
  -- vim.g.neovide_cursor_vfx_mode = "sonicboom"
  -- vim.g.neovide_floating_blur_amount_x = 0.0
  -- vim.g.neovide_floating_blur_amount_y = 0.0
  vim.g.neovide_floating_shadow = false
  -- vim.g.neovide_floating_z_height = 0
  -- vim.g.neovide_light_angle_degrees = 0
  -- vim.g.neovide_light_radius = 0
  -- vim.g.neovide_floating_corner_radius = 0
  -- 缩放
  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.25)
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.25)
  end)
  require("dashboard")
  -- neovide 背景颜色  hyprland 应用透明和模糊
  -- {% if theme.color_name != "wallpaper" %}
  -- {# replace_color(theme.colors.background) #}
  vim.api.nvim_set_hl(0, "Normal", { bg = "#001419" })
  -- {% end %}
  -- 清除颜色 防止 浮动窗口有背景模糊
  vim.cmd("hi clear Normal")
end

-- neovim 0.11
vim.keymap.del("n", "grn")
vim.keymap.del({ "n", "x" }, "gra")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grt")
vim.keymap.del("n", "gO")

-- local stdout = vim.uv.new_pipe(false)
-- vim.uv.spawn("rg", {
--   args = { "-e", "end", "-g", "**/*" },
--   cwd = "/home/zwind/.config/nvim",
--   stdio = { nil, stdout, nil },
-- })
-- vim.uv.read_start(stdout, function(_, s)
--   print(s)
-- end)
