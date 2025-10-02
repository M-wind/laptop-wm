function trim(s)
   return (s:gsub("^%s*(%S+)%s*", "%1"))
end

function openURL()

   subprocess = {
      name = "subprocess",
      -- args = { "powershell", "-Command", "Get-Clipboard", "-Raw" },
      args = { "wl-paste" },
      playback_only = false,
      capture_stdout = true,
      capture_stderr = true
   }

   -- mp.osd_message("正在加载剪贴板中的URL...")

   r = mp.command_native(subprocess)

   --failed getting clipboard data for some reason
   if r.status < 0 then
      mp.osd_message("获取剪贴板数据失败！")
      print("Error(string): " .. r.error_string)
      print("Error(stderr): " .. r.stderr)
   end

   url = r.stdout

   if not url then
      return
   end

   --trim whitespace from string decode
   url = string.gsub(trim(url), '%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end)

   if not url then
      mp.osd_message("剪贴板为空")
      return
   end

   --immediately resume playback after loading URL
   if mp.get_property_bool("core-idle") then
      if not mp.get_property_bool("idle-active") then
         mp.command("keypress space")
      end
   end

   --try opening url
   --will fail if url is not valid
   mp.osd_message(url)
   mp.commandv("loadfile", url, "replace")
end

mp.add_key_binding("ctrl+v", openURL)
