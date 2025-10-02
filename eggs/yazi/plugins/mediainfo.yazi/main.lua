local M = {}

local general_entry = { "Title", "Album", "Performer", "Recorded_Date", "Duration" }
local video_entry = { "Format", "Width", "Height", "BitRate", "FrameRate", "StreamSize" }
local audio_entry = { "Format", "Language", "BitRate", "Channels", "SamplingRate", "StreamSize" }
local text_entry = { "Format", "Title", "Language", "Forced", "Default" }
local image_entry = { "Format", "Width", "Height" }

local len = function(key)
  for i = 14, #key, -1 do
    key = key .. " "
  end
  return key
end

local num_lines = 0
local num_skip = 0
local job_skip = 0

local insert = function(lines, ele)
  if num_skip >= job_skip then
    table.insert(lines, ele)
    num_lines = num_lines + 1
  else
    num_skip = num_skip + 1
  end
end

local basic = function(v, lines, type)
  for _, k in pairs(type) do
    local value = v[k]
    if value ~= nil then
      local key = len(" " .. k)
      insert(lines, ui.Line({ ui.Span(key):fg("green"), ui.Span(value) }))
    end
  end
end

local general = function(v, lines)
  insert(lines, ui.Span("General"):fg("blue"))
  basic(v, lines, general_entry)
  local create_time = v["File_Created_Date_Local"] or v["File_Created_Date"]
  local modify_time = v["File_Modified_Date_Local"] or v["File_Modified_Date"]
  if create_time ~= nil then
    insert(lines, ui.Line({ ui.Span(len(" CreateTime")):fg("green"), ui.Span(create_time) }))
  end
  if modify_time ~= nil then
    insert(lines, ui.Line({ ui.Span(len(" ModifiedTime")):fg("green"), ui.Span(modify_time) }))
  end
end

local video = function(v, lines)
  insert(lines, ui.Span(""))
  insert(lines, ui.Span("Video"):fg("blue"))
  basic(v, lines, video_entry)
end

local audio = function(v, lines)
  insert(lines, ui.Span(""))
  insert(lines, ui.Span("Audio"):fg("blue"))
  basic(v, lines, audio_entry)
end

local text = function(v, lines)
  insert(lines, ui.Span(""))
  insert(lines, ui.Span("Text"):fg("blue"))
  basic(v, lines, text_entry)
end

local image = function(v, lines)
  insert(lines, ui.Span(""))
  insert(lines, ui.Span("Image"):fg("blue"))
  basic(v, lines, image_entry)
end

function M:peek(job)
  local image_height = 0
  local cache = ya.file_cache({ file = job.file, skip = 0 })
  if fs.cha(cache) then
    image_height = ya.image_show(cache, job.area).h
  end
  local media_cache = cache .. "_mediainfo"
  local cha = fs.cha(Url(media_cache))
  local json = require("json2")
  -- local json = dofile("/home/zwind/app/yazi/plugins/mediainfo.yazi/json.lua")
  local output
  if not cha then
    local child = Command("mediainfo")
      :arg({ "--Output=JSON", tostring(job.file.url) })
      :stdout(Command.PIPED)
      :stderr(Command.PIPED)
      :spawn()
    if child == nil then
      return
    end
    output = child:wait_with_output()
    fs.write(Url(media_cache), output.stdout)
  else
    local file = io.open(media_cache, "r")
    output = {}
    output.stdout = file:read("*all")
    file:close()
  end
  if output == nil then
    return
  end
  local info = json.decode(output.stdout)
  local tracks = info.media.track
  local lines = {}
  job_skip = job.skip
  local limit = job.area.h - image_height
  for _, v in pairs(tracks) do
    local type = v["@type"]
    if type == "General" then
      general(v, lines)
    end
    if type == "Video" then
      video(v, lines)
    end
    if type == "Audio" then
      audio(v, lines)
    end
    if type == "Text" then
      text(v, lines)
    end
    if type == "Image" then
      image(v, lines)
    end
    if num_lines >= limit then
      break
    end
  end
  if job.skip > 0 and num_lines < limit then
    ya.mgr_emit("peek", { math.max(0, job.skip - (limit - num_lines)), only_if = job.file.url })
    return
  end
  ya.preview_widgets(job, {
    ui.Text(lines)
      :area(ui.Rect({
        x = job.area.x,
        y = job.area.y + image_height,
        w = job.area.w,
        h = job.area.h - image_height,
      }))
      :wrap(ui.Text.WRAP_NO),
  })
end

function M:seek(job)
  local h = cx.active.current.hovered
  if h and h.url == job.file.url then
    local step = job.units > 0 and 1 or -1
    ya.mgr_emit("peek", {
      math.max(0, cx.active.preview.skip + step),
      only_if = job.file.url,
    })
  end
end

function M:preload(job)
  local cache = ya.file_cache({ file = job.file, skip = 0 })
  local cha = fs.cha(cache)
  if cha then
    return true
  end
  local status, _ = Command("exiftool"):arg({
    "-b",
    "-CoverArt",
    "-Picture",
    tostring(job.file.url),
    "-W",
    tostring(cache),
  }):status()
  return true
end

return M
