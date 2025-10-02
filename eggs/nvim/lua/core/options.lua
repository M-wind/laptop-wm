local opt = vim.opt

-- 行号
opt.relativenumber = true
opt.number = true
-- opt.numberwidth = 1

-- opt.winborder = "rounded"

-- 缩进
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true

opt.smartindent = true

-- global statusline
opt.laststatus = 3
opt.showmode = false

-- 代码折叠
-- opt.foldmethod = "indent"
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.require(utils.fold'').formatexpr()"
vim.opt.foldtext = "v:lua.require('utils.fold').foldtext()"
opt.foldlevel = 99
opt.fillchars = {
  -- foldopen = "",
  -- foldclose = "",
  fold = " ",
  -- foldsep = " ",
  -- diff = "╱",
  eob = " ",
}

-- 防止包裹
opt.wrap = false

-- 光标行
opt.cursorline = true

-- 光标形状
opt.guicursor = "a:ver15-Cursor"
-- opt.guicursor = "a:ver15"

-- 禁用鼠标
-- opt.mouse = ""
-- 右键菜单替换
opt.mousemodel = "extend"

opt.breakindent = true

-- 系统剪贴板
opt.clipboard = "unnamedplus"
local function my_paste(reg)
  return function(lines)
    --[ 返回 “” 寄存器的内容，用来作为 p 操作符的粘贴物 ]
    local content = vim.fn.getreg('"')
    return vim.split(content, "\n")
  end
end
if os.getenv("SSH_TTY") ~= nil then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      --[ 小括号里面的内容可能是毫无意义的，但是保持原样可能看起来更好一点 ]
      ["+"] = my_paste("+"),
      ["*"] = my_paste("*"),
    },
  }
end

-- 默认新窗口右和下
opt.splitright = true
opt.splitbelow = true

-- 搜索
opt.ignorecase = true
opt.smartcase = true

-- 外观
opt.termguicolors = true
opt.signcolumn = "yes"

--
opt.backup = false
opt.swapfile = false
opt.fileencoding = "utf-8"
opt.undofile = true

-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- vim.cmd("aunmenu PopUp.-1-")
-- vim.cmd("aunmenu PopUp.How-to\\ disable\\ mouse")

-- vim.opt.aunmenu = "PopUp.-1-"
-- vim.cmd("amenu Nomal.Next :q!<cr>")

opt.smoothscroll = true
-- opt.shadafile = "NONE"

-- disable nvim intro
opt.shortmess:append("sI")

-- disable some default providers
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- add binaries installed by mason.nvim to path
-- local is_windows = vim.fn.has "win32" ~= 0
-- local sep = is_windows and "\\" or "/"
-- local delim = is_windows and ";" or ":"
-- vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH
