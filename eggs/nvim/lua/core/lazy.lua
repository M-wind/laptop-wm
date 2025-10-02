local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- local Event = require("lazy.core.handler.event")
-- Event.mappings.LazyFile = { id = "LazyFile", event = { "BufReadPost", "BufNewFile", "BufWritePre" } }
-- Event.mappings["User LazyFile"] = Event.mappings.LazyFile

local view_config = require("lazy.view.config")
view_config.keys.close = "<C-q>"

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  -- install = { colorscheme = { "onedarkpro" } },
  checker = { enabled = false },
  ui = {
    border = "rounded",
  },
  rocks = {
    enabled = false,
    hererocks = false,
  },
  custom_keys = {
    ["<localleader>l"] = false,
    ["<localleader>i"] = false,
    ["<localleader>t"] = false,
    ["q"] = false,
    ["<c-q>"] = "cancel",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "matchit",
        "matchparen",
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "rplugin",
        "shada",
        "osc52",
        "spellfile",
        "editorconfig",
        "man",
      },
    },
  },
})
