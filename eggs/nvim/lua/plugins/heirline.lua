local colors = require("utils.theme").colors

local modes = {
  ["n"] = { name = "NORMAL", hl = { bg = colors.violet, fg = colors.black } },
  ["no"] = { name = "O-PENDING", hl = { bg = colors.cyan, fg = colors.black } },
  ["nov"] = { name = "O-PENDING", hl = { bg = colors.cyan, fg = colors.black } },
  ["noV"] = { name = "O-PENDING", hl = { bg = colors.cyan, fg = colors.black } },
  ["no\22"] = { name = "O-PENDING", hl = { bg = colors.cyan, fg = colors.black } },
  ["niI"] = { name = "NORMAL", hl = { bg = colors.violet, fg = colors.black } },
  ["niR"] = { name = "NORMAL", hl = { bg = colors.violet, fg = colors.black } },
  ["niV"] = { name = "NORMAL", hl = { bg = colors.violet, fg = colors.black } },
  ["nt"] = { name = "NORMAL", hl = { bg = colors.violet, fg = colors.black } },
  ["ntT"] = { name = "NORMAL", hl = { bg = colors.violet, fg = colors.black } },
  ["v"] = { name = "VISUAL", hl = { bg = colors.blue, fg = colors.black } },
  ["vs"] = { name = "VISUAL", hl = { bg = colors.blue, fg = colors.black } },
  ["V"] = { name = "V-LINE", hl = { bg = colors.blue, fg = colors.black } },
  ["Vs"] = { name = "V-LINE", hl = { bg = colors.blue, fg = colors.black } },
  ["\22"] = { name = "V-BLOCK", hl = { bg = colors.blue, fg = colors.black } },
  ["\22s"] = { name = "V-BLOCK", hl = { bg = colors.blue, fg = colors.black } },
  ["s"] = { name = "SELECT", hl = { bg = colors.red, fg = colors.black } },
  ["S"] = { name = "S-LINE", hl = { bg = colors.red, fg = colors.black } },
  ["\19"] = { name = "S-BLOCK", hl = { bg = colors.red, fg = colors.black } },
  ["i"] = { name = "INSERT", hl = { bg = colors.green, fg = colors.black } },
  ["ic"] = { name = "INSERT", hl = { bg = colors.green, fg = colors.black } },
  ["ix"] = { name = "INSERT", hl = { bg = colors.green, fg = colors.black } },
  ["c"] = { name = "COMMAND", hl = { bg = colors.green, fg = colors.black } },
  ["R"] = { name = "REPLACE", hl = { bg = colors.yellow, fg = colors.black } },
  ["Rc"] = { name = "REPLACE", hl = { bg = colors.yellow, fg = colors.black } },
  ["Rx"] = { name = "REPLACE", hl = { bg = colors.yellow, fg = colors.black } },
  ["Rv"] = { name = "V-REPLACE", hl = { bg = colors.yellow, fg = colors.black } },
  ["Rvc"] = { name = "V-REPLACE", hl = { bg = colors.yellow, fg = colors.black } },
  ["Rvx"] = { name = "V-REPLACE", hl = { bg = colors.yellow, fg = colors.black } },
  ["cv"] = { name = "EX", hl = { bg = colors.orange, fg = colors.black } },
  ["ce"] = { name = "EX", hl = { bg = colors.orange, fg = colors.black } },
  ["r"] = { name = "REPLACE", hl = { bg = colors.orange, fg = colors.black } },
  ["rm"] = { name = "MORE", hl = { bg = colors.orange, fg = colors.black } },
  ["r?"] = { name = "CONFIRM", hl = { bg = colors.orange, fg = colors.black } },
  ["!"] = { name = "SHELL", hl = { bg = colors.orange, fg = colors.black } },
  ["t"] = { name = "TERMINAL", hl = { bg = colors.orange, fg = colors.black } },
}

local buffer_offset = {
  condition = function(self)
    local win = vim.api.nvim_tabpage_list_wins(0)[1]
    local bufnr = vim.api.nvim_win_get_buf(win)
    self.winid = win
    if vim.bo[bufnr].filetype == "NvimTree" then
      self.title = "File Explorer"
      return true
    end
  end,
  provider = function(self)
    local title = self.title
    local width = vim.api.nvim_win_get_width(self.winid)
    local pad = math.ceil((width - #title) / 2)
    return string.rep(" ", pad) .. title .. string.rep(" ", pad)
  end,
  hl = { fg = colors.green },
}

local buffer_filename = {
  init = function(self)
    local filename = vim.api.nvim_buf_get_name(self.bufnr)
    filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.filename = filename
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  {
    provider = function(self)
      return self.icon and (" " .. self.icon)
    end,
    hl = function(self)
      local highlight = { fg = self.icon_color, sp = colors.white }
      if self.is_active then
        highlight.underline = true
      end
      return highlight
    end,
  },
  {
    provider = function(self)
      return " " .. self.filename .. " "
    end,
    hl = function(self)
      if self.is_active then
        return { fg = colors.white, underline = true }
      else
        return { fg = colors.comment }
      end
    end,
    minwid = function(self)
      return self.bufnr
    end,
    on_click = {
      callback = function(_, minwid)
        vim.api.nvim_win_set_buf(0, minwid)
      end,
      minwid = function(self)
        return self.bufnr
      end,
      name = "buffer_current",
    },
  },
}

local buffer_closebutton = {
  init = function(self)
    self.is_modified = vim.bo[self.bufnr].modified
  end,
  provider = function(self)
    -- return self.is_modified and "󰧟 " or (self.is_active and " " or "")
    return self.is_modified and "󰧟 " or " "
  end,
  hl = function(self)
    local highlight = self.is_modified and { fg = colors.green } or { fg = colors.white }
    if self.is_active then
      highlight.underline = true
    else
      highlight = { fg = colors.comment }
    end
    return highlight
  end,
  on_click = {
    callback = function(_, minwid)
      if not vim.bo[minwid].modified then
        -- vim.cmd("Bdelete")
        vim.cmd(("silent! %s %d"):format("Bdelete", minwid))
      end
    end,
    minwid = function(self)
      return self.bufnr
    end,
    name = "buffer_close",
  },
}

local tabpage = {
  provider = function(self)
    return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
  end,
  hl = function(self)
    if self.is_active then
      return { fg = colors.black, bg = colors.green }
    else
      return { fg = colors.comment, bg = colors.black }
    end
  end,
}

local tabpageclose = {
  provider = "%999X  %X",
  hl = { fg = colors.white, bg = colors.red },
}

return {
  {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "moll/vim-bbye",
    },
    config = function()
      local utils = require("heirline.utils")
      local utils_h = require("utils.heirline")
      local conditions = require("heirline.conditions")
      local diagnostic_icon = require("utils.icons").diagnostics
      local buffer_block = utils.surround({ "", " " }, "none", { buffer_filename, buffer_closebutton })
      require("heirline").setup({
        tabline = {
          buffer_offset,
          utils.make_buflist(
            buffer_block,
            { provider = " ", hl = { fg = colors.white } },
            { provider = " ", hl = { fg = colors.white } },
            function()
              return utils_h.buflist_cache
            end,
            false
          ),
          {
            condition = function()
              return #vim.api.nvim_list_tabpages() > 1
            end,
            { provider = "%=" },
            utils.make_tablist(tabpage),
            tabpageclose,
          },
        },
        statusline = {
          -- condition = function ()
          --     local bufnr = vim.api.nvim_get_current_buf()
          --     return vim.bo[bufnr].filetype ~= "NvimTree"
          -- end,
          {
            init = function(self)
              self.mode = vim.api.nvim_get_mode()["mode"]
              -- self.mode = vim.fn.mode(1)
            end,
            provider = function(self)
              return " " .. modes[self.mode]["name"] .. " "
            end,
            hl = function(self)
              return modes[self.mode]["hl"]
            end,
            update = {
              "ModeChanged",
              pattern = "*:*",
              callback = vim.schedule_wrap(function()
                vim.cmd("redrawstatus")
              end),
            },
          },
          {
            init = function(self)
              self.filename = vim.api.nvim_buf_get_name(0)
            end,
            provider = function(self)
              local filename = ""
              local pwd = vim.fn.getcwd()
              if vim.bo.filetype == "NvimTree" then
                -- filename = vim.fn.fnamemodify(self.filename, ":h")
                filename = pwd
              else
                -- filename = vim.fn.fnamemodify(self.filename, ":t")
                filename = self.filename
                local _, index = string.find(self.filename, pwd, 1, true)
                if index ~= nil then
                  filename = string.sub(self.filename, index + 2)
                end
                if filename == "" then
                  filename = "[No Name]"
                end
              end
              return " " .. filename .. " "
            end,
            hl = { bg = colors.black, fg = colors.white },
            {
              condition = function()
                return vim.bo.modified
              end,
              provider = "[+] ",
              hl = { fg = colors.green },
            },
          },
          {
            condition = conditions.is_git_repo,
            init = function(self)
              self.status_dict = vim.b.gitsigns_status_dict
              self.has_changes = self.status_dict.added ~= 0
                or self.status_dict.removed ~= 0
                or self.status_dict.changed ~= 0
            end,
            provider = function(self)
              return "  " .. self.status_dict.head .. " "
            end,
            hl = { bg = colors.grey, fg = colors.blue },
            {
              provider = function(self)
                local count = self.status_dict.added or 0
                return count > 0 and ("+" .. count)
              end,
              hl = { fg = colors.green },
            },
            {
              provider = function(self)
                local count = self.status_dict.removed or 0
                return count > 0 and ("-" .. count)
              end,
              hl = { fg = colors.red },
            },
            {
              provider = function(self)
                local count = self.status_dict.changed or 0
                return count > 0 and ("~" .. count)
              end,
              hl = { fg = colors.orange },
            },
          },
          {
            condition = conditions.has_diagnostics,
            static = {
              error_icon = diagnostic_icon.Error,
              warn_icon = diagnostic_icon.Warn,
              info_icon = diagnostic_icon.Info,
              hint_icon = diagnostic_icon.Hint,
            },
            init = function(self)
              self.error = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
              self.warn = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
              self.hint = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
              self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
            end,
            provider = " ",
            hl = { bg = colors.grey },
            {
              provider = function(self)
                return self.info > 0 and (self.info_icon .. " " .. self.info .. " ")
              end,
              hl = { fg = colors.green },
            },
            {
              provider = function(self)
                return self.hint > 0 and (self.hint_icon .. " " .. self.hint .. " ")
              end,
              hl = { fg = colors.cyan },
            },
            {
              provider = function(self)
                return self.warn > 0 and (self.warn_icon .. " " .. self.warn .. " ")
              end,
              hl = { fg = colors.yellow },
            },
            {
              provider = function(self)
                return self.error > 0 and (self.error_icon .. " " .. self.error .. " ")
              end,
              hl = { fg = colors.red },
            },
          },
          { provider = "%=" },
          {
            provider = function()
              return " " .. vim.o.fileencoding:upper() .. " "
            end,
            hl = { bg = colors.grey, fg = colors.white },
          },
          {
            provider = function()
              return " Tab " .. vim.o.shiftwidth .. " "
            end,
            hl = { bg = colors.black, fg = colors.white },
          },
          {
            provider = function()
              local line = vim.fn.line(".")
              local col = vim.fn.charcol(".")
              return " " .. string.format("%3d:%-2d", line, col) .. " "
            end,
            hl = { bg = colors.violet, fg = colors.black },
          },
        },
        -- statuscolumn = {
        --   init = function(self)
        --     self.bufnr = vim.api.nvim_get_current_buf()
        --   end,
        --   lib.component.foldcolumn(),
        --   lib.component.numbercolumn(),
        --   lib.component.signcolumn(),
        -- },
      })
    end,
  },
}
