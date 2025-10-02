local basePath = "http://192.168.1.1:5244"
local route, root = "/dav/%E9%98%BF%E9%87%8C%E4%BA%91%E7%9B%98/", "/dav/%E9%98%BF%E9%87%8C%E4%BA%91%E7%9B%98/"

local uname, password = "Z_wind", "123456"

local baseStyle = "\\rDefault\\bord0.8"
local currentId, pageNumber, currentList, currentPage, more, pageCount = 1, 15, {}, 1, 0, 1
local mouse = "➤"
local x, y, size, gap, size_s, size_l = 35, 45, 24, 8, 18, 40
local pointColor, selectedColor = "\\1c&H00CCFF&", "\\1c&H85AE2B&"
local folderColor = "\\1c&HEFAF61&"

local function FileType(name)
  local s_name = string.reverse(name)
  local type = "folder"
  if string.sub(s_name, 1, 1) ~= "/" then
    local s, _ = string.find(s_name, ".", 1, true)
    if s == nil then
      type = "other"
    else
      local t = string.lower(string.sub(name, #name - s + 2))
      if string.match("(mkv|mtv|mp4|flac|mp3|ape)", t) then
        type = "play"
      elseif string.match("(jpeg|webp|jpg|png|ico)", t) then
        type = "pic"
      elseif string.match("(ass|srt|idx)", t) then
        type = "cc"
      else
        type = "other"
      end
    end
  end
  return type
end

local function getHref(tempxml, ref, i)
  local tag1 = "<D:href>"
  local tag2 = "</D:href>"
  -- local tag3 = "<D:displayname>"
  -- local tag4 = "</D:displayname>"
  local _, b, c = string.find(tempxml, tag1 .. "(.-)" .. tag2)
  -- local _, _, d = string.find(tempxml, tag3 .. "(.-)" .. tag4)
  local replaceS = string.gsub(ref, "%%(%x%x)", function(h)
    return string.char(tonumber(h, 16))
  end)
  route = replaceS
  while b ~= nil do
    -- local _, _, dc = string.find(string.reverse(c), "/(.-)/")
    -- dc = string.gsub(string.reverse(dc), '%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end)
    local dc = string.gsub(c, "%%(%x%x)", function(h)
      return string.char(tonumber(h, 16))
    end)
    dc = string.sub(dc, #replaceS + 1)
    if dc ~= "" then
      local type = FileType(dc)
      if type == "play" or type == "cc" or type == "folder" then
        table.insert(currentList, i, { id = i, displayname = dc, href = c, type = type })
        i = i + 1
      end
    end
    _, b, c = string.find(tempxml, tag1 .. "(.-)" .. tag2, b)
    -- _, _, d = string.find(tempxml, tag3 .. "(.-)" .. tag4, b)
  end
end

local function list(ref)
  currentList = {}
  local result = mp.command_native({
    name = "subprocess",
    playback_only = false,
    capture_stdout = true,
    args = {
      "curl",
      "-u",
      uname .. ":" .. password,
      "-X",
      "PROPFIND",
      basePath .. ref,
      "-H",
      "Depth: 1",
    },
  })
  if result.status ~= 0 then
    return
  end
  local i = 1
  local url = string.reverse(ref)
  local _, _, c = string.find(url, "/(.-)/")
  url = string.sub(url, 1 + #c + 1)
  url = string.reverse(url)
  -- route = url == "" and "Root" or string.gsub(url, '%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end)

  if ref ~= root then
    table.insert(currentList, i, { id = i, displayname = "󰁭󰁭󰁭", href = url, type = "pointer" })
    i = i + 1
  end

  getHref(result.stdout, ref, i)
  -- if ref ~= href then
  --     table.insert(currentList, #currentList + 1, { id = #currentList + 1, displayname = "...", href = href, type = "folder" })
  -- end
  pageCount = math.ceil(#currentList / pageNumber)
  currentId, currentPage, more = 1, 1, 0
  if pageCount > 1 then
    more = #currentList - pageNumber * currentPage
  end
end

local osd = mp.create_osd_overlay("ass-events")
local assdraw = require("mp.assdraw")
local ass = assdraw.ass_new()

local function text(x, y, style, h, text)
  ass.text = ""
  ass:new_event()
  ass:pos(x + 1, y - 1)
  ass:append("{" .. style .. "\\fs" .. h .. "}" .. text)
  return ass.text
end

local textStyle = function(point)
  local style = baseStyle
  if currentId == point then
    style = baseStyle .. selectedColor
  else
    local type = currentList[point].type
    if type == "folder" then
      style = style .. folderColor
    elseif type == "pointer" then
      style = style .. pointColor
    end
  end
  return style
end

local router = function(router)
  -- local route = string.gsub(router, root, '')
  local rootDecode = string.gsub(root, "%%(%x%x)", function(h)
    return string.char(tonumber(h, 16))
  end)
  local route1 = string.sub(router, #rootDecode + 1)
  route1 = "Root" .. "/" .. route1
  return text(x, y, baseStyle .. pointColor, size_l, route1)
end
local line =
  text(x, y + size_l - gap, baseStyle .. pointColor, size_l, "--------------------------------------------------------")

local function show()
  y = 45
  local txt = router(route) .. "\n" .. line .. "\n"
  y = y + size_l * 2 - gap
  local start, end_ = 1 + (currentPage - 1) * pageNumber, currentPage * pageNumber
  if currentPage * pageNumber > #currentList or #currentList < pageNumber then
    end_ = #currentList
  end
  -- if currentList[1]['type'] == 'back' then
  --     start = start + 1
  --     txt = txt .. text(x + size + gap, y, baseStyle .. pointColor, size, currentList[1]['displayname']) .. "\n"
  --     y = y + size + gap
  -- end
  local j, yy = 0, 0
  for i = start, end_ do
    yy = y + (size + gap) * j
    if currentId == currentList[i]["id"] then
      local mouseStyle = text(x, yy, baseStyle .. pointColor, size, mouse)
      txt = txt .. mouseStyle .. "  "
    end
    txt = txt .. text(x + size + gap, yy, textStyle(currentList[i]["id"]), size, currentList[i]["displayname"]) .. "\n"
    j = j + 1
  end
  if more > 0 then
    txt = txt .. text(x, yy + size + gap, baseStyle .. pointColor, size_s, more .. " items remaining...")
  end
  osd.id = 1000
  osd.data = txt
  osd.z = 1000
  osd:update()
end

local function moveup()
  currentId = currentId - 1
  if currentId < 1 + (currentPage - 1) * pageNumber then
    currentId = currentPage * pageNumber
  end
  if currentId > #currentList then
    currentId = #currentList
  end
  show()
end

local function movedown()
  currentId = currentId + 1
  if currentId > currentPage * pageNumber then
    currentId = 1 + (currentPage - 1) * pageNumber
  end
  if currentId > #currentList then
    currentId = 1 + (currentPage - 1) * pageNumber
  end
  show()
end

local function left()
  if pageCount == 1 then
    return
  end
  local position = currentPage * pageNumber - currentId
  currentPage = currentPage - 1
  if currentPage < 1 then
    currentPage = pageCount
  end
  currentId = currentPage * pageNumber - position
  if currentId > #currentList then
    currentId = #currentList
  end
  more = #currentList - pageNumber * currentPage
  show()
end

local function right()
  if pageCount == 1 then
    return
  end
  local position = currentPage * pageNumber - currentId
  currentPage = currentPage + 1
  if currentPage > pageCount then
    currentPage = 1
  end
  currentId = currentPage * pageNumber - position
  if currentId > #currentList then
    currentId = #currentList
  end
  more = #currentList - pageNumber * currentPage
  show()
end

local function getUrl(href)
  local path = string.sub(href, 5)
  -- local url = basePath .. "/api/fs/get?path=" .. path
  -- local result = utils.subprocess({
  --     args = { 'powershell', 'Invoke-RestMethod -Uri ' .. url .. ' | ConvertTo-json' },
  --     cancellable = false
  -- })
  -- if result.status ~= 0 then return end
  -- result = utils.parse_json(result.stdout)
  -- return basePath .. "/d" .. path .. "?sign=" .. result.data.sign
  return basePath .. "/d" .. path
end

local function remove_key_bingding()
  mp.remove_key_binding("MoveUp")
  mp.remove_key_binding("MoveDown")
  mp.remove_key_binding("Left")
  mp.remove_key_binding("Right")
  mp.remove_key_binding("Enter")
end

local display = true

local function remove()
  osd.id = 1000
  osd:remove()
  display = true
  remove_key_bingding()
end

local function enter()
  local type = currentList[currentId]["type"]
  if type == "folder" or type == "pointer" then
    list(currentList[currentId]["href"])
    show()
  elseif type == "play" then
    local url = getUrl(currentList[currentId]["href"])
    mp.commandv("loadfile", url, "replace")
    remove()
  elseif type == "cc" then
    local url = getUrl(currentList[currentId]["href"])
    local title = currentList[currentId]["displayname"]
    mp.commandv("sub-add", url, "select", string.sub(title, 1, #title - 4))
    remove()
  end
end

local function add_forced_key_binding()
  mp.add_forced_key_binding("UP", "MoveUp", moveup, "repeatable")
  mp.add_forced_key_binding("DOWN", "MoveDown", movedown, "repeatable")
  mp.add_forced_key_binding("LEFT", "Left", left, "repeatable")
  mp.add_forced_key_binding("RIGHT", "Right", right, "repeatable")
  mp.add_forced_key_binding("ENTER", "Enter", enter, "repeatable")
  mp.add_forced_key_binding("k", "MoveUp", moveup, "repeatable")
  mp.add_forced_key_binding("j", "MoveDown", movedown, "repeatable")
  mp.add_forced_key_binding("h", "Left", left, "repeatable")
  mp.add_forced_key_binding("l", "Right", right, "repeatable")
  mp.add_forced_key_binding("o", "Enter", enter, "repeatable")
end

local function open()
  if #currentList == 0 then
    list(root)
  end
  if display then
    show()
    display = false
    add_forced_key_binding()
  else
    remove()
    display = true
  end
end

mp.add_key_binding("ctrl+shift+f", open)
