local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = "VeryLazy",
  -- event = { "BufReadPost", "BufNewFile" },
  config = function()
    -- require("nvim-treesitter.install").compilers = { "gcc" }
    require("nvim-treesitter.configs").setup({
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        -- "c",
        "diff",
        "html",
        "javascript",
        -- "jsdoc",
        "json",
        "jsonc",
        -- "lua",
        -- "luadoc",
        -- "luap",
        -- "markdown",
        -- "markdown_inline",
        -- "printf",
        -- "query",
        "regex",
        -- "textproto",
        "rust",
        "toml",
        "kdl",
        "tsx",
        "typescript",
        -- "vim",
        -- "vimdoc",
        -- "xml",
        "yuck",
        "yaml",
        "nu",
        "hyprlang",
      },
    })
  end,
  -- vim.treesitter.language.register('hyprlang', '*.conf')
  vim.filetype.add({
    pattern = { [".*%.conf"] = "hyprlang" },
    pattern = { [".*%.rhai"] = "rust" },
    pattern = { [".*%.txt"] = "hyprlang" },
  }),
}

local ts_autotag = {
  "windwp/nvim-ts-autotag",
  event = "User FilePost",
  config = function()
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = false,
        enable_close_on_slash = false,
      },
    })
  end,
}

return { treesitter, ts_autotag }
