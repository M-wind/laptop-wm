local utils = require("mp.utils")

local exec = function(width, height)
  utils.subprocess_detached({
    args = { "hyprctl", "dispatch", "resizeactive", "exact", width, height },
  })
end

local center = function()
  utils.subprocess_detached({
    args = { "hyprctl", "dispatch", "centerwindow" },
  })
end

local scale = function(scale)
  local screen_width, screen_height = mp.get_property_native("display-width"), mp.get_property_native("display-height")
  local exact_width, exact_height = mp.get_property_native("width"), mp.get_property_native("height")
  if exact_width == nil or exact_height == nil then
    -- exact_width = mp.get_property_native("osd-width")
    -- exact_height = mp.get_property_native("osd-height")
    exact_width = 1280
    exact_height = 720
  end
  local play_width = mp.get_property_native("osd-width")
  local n_width = math.ceil(exact_width * scale)
  local n_height = math.ceil(exact_height * scale)
  local width_l = n_width > screen_width
  local height_l = n_height > screen_height
  if width_l and not height_l then
    n_height = math.ceil(n_height * screen_width / n_width)
    n_width = screen_width
  elseif not width_l and height_l then
    n_width = math.ceil(n_width * screen_height / n_height)
    n_height = screen_height
  elseif width_l and height_l then
    n_width = screen_width
    n_height = screen_height
  end
  if play_width == n_width then
    return
  end
  exec(n_width, n_height)
  center()
end

mp.add_key_binding(nil, "window-scale-0.5", function()
  scale(0.5)
end, { repeatable = false })

mp.add_key_binding(nil, "window-scale-1.0", function()
  scale(1.0)
end, { repeatable = false })

mp.add_key_binding(nil, "window-scale-1.5", function()
  scale(1.5)
end, { repeatable = false })

mp.add_key_binding(nil, "window-scale-2.0", function()
  scale(2.0)
end, { repeatable = false })
