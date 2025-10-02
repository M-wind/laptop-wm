local autocmd = vim.api.nvim_create_autocmd

-- user event that loads after UIEnter + only if file buf is there
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("file-post", { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true
    end

    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
      vim.api.nvim_del_augroup_by_name("file-post")

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})

        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end)
    end
  end,
})

autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("Heirline", { clear = true }),
  callback = function()
    require("heirline.utils").on_colorscheme({
      opts = {
        colors = require("utils.theme").colors,
      },
    })
  end,
})

-- Highlight on yank
autocmd("TextYankPost", {
  desc = "Highlight when copying",
  group = vim.api.nvim_create_augroup("highlight-copy", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
