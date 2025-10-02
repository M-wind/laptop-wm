local highlights = function(colors)
  return {
    Normal = { bg = vim.g.neovide and colors.bg or colors.none },
    NotifyBackground = { bg = "#000000" },
    NotifyINFOBorder = { fg = colors.green },
    NotifyINFOIcon = { fg = colors.green },
    NotifyINFOTitle = { fg = colors.green },
    WhichKeyFloat = { bg = colors.none },
    WhichKeyDesc = { fg = colors.green },
    WhichKeySeparator = { fg = colors.cyan },
    WhichKeyTitle = { fg = colors.blue },
    NormalFloat = { bg = colors.none },
    FloatBorder = { fg = colors.orange },
    CursorLine = { bg = colors.none },
    CursorLineNr = { bg = colors.none, fg = colors.purple or colors.violet },
    -- TabLineSel = { fg = colors.gray },
    NvimTreeWinSeparator = { fg = "#3b4048" },
    IndentLineCurrent = { fg = colors.green },
    DapInfo = { fg = colors.blue },
    DapStop = { fg = colors.green },
    DapError = { fg = colors.red },
    DapLog = { fg = colors.yellow },
    -- TelescopeResultsNormal = { fg = colors.green },
    -- TelescopeSelection = { link = "IncSearch" },
    TelescopeMatching = { fg = colors.green, italic = true },
    TelescopePromptBorder = { link = "FloatBorder" },

    -- BlinkCmpKindField = { fg = "#61afef" },
    BlinkCmpKindField = { fg = colors.blue },
    BlinkCmpKindFile = { link = "BlinkCmpKindField" },
    BlinkCmpKindVariable = { link = "BlinkCmpKindField" },
    BlinkCmpKindFolder = { link = "BlinkCmpKindField" },
    BlinkCmpKindNull = { link = "BlinkCmpKindField" },
    BlinkCmpKindArray = { link = "BlinkCmpKindField" },
    BlinkCmpKindPackage = { link = "BlinkCmpKindField" },
    -- BlinkCmpKindEnum = { fg = "#e5c07b" },
    BlinkCmpKindEnum = { fg = colors.yellow },
    BlinkCmpKindTypeParameter = { link = "BlinkCmpKindEnum" },
    BlinkCmpKindStruct = { link = "BlinkCmpKindEnum" },
    BlinkCmpKindInterface = { link = "BlinkCmpKindEnum" },
    BlinkCmpKindBoolean = { link = "BlinkCmpKindEnum" },
    BlinkCmpKindString = { link = "BlinkCmpKindEnum" },
    BlinkCmpKindNamespace = { link = "BlinkCmpKindEnum" },
    -- BlinkCmpKindConstant = { fg = "#98c379" },
    BlinkCmpKindConstant = { fg = colors.green },
    BlinkCmpKindMethod = { link = "BlinkCmpKindConstant" },
    BlinkCmpKindFunction = { link = "BlinkCmpKindConstant" },
    BlinkCmpKindSnippet = { link = "BlinkCmpKindConstant" },
    BlinkCmpKindCodeium = { link = "BlinkCmpKindConstant" },
    BlinkCmpKindCopilot = { link = "BlinkCmpKindConstant" },
    BlinkCmpKindNumber = { link = "BlinkCmpKindConstant" },
    -- BlinkCmpKindEnumMember = { fg = "#56b6c2" },
    BlinkCmpKindEnumMember = { fg = colors.cyan },
    BlinkCmpKindModule = { link = "BlinkCmpKindEnumMember" },
    BlinkCmpKindProperty = { link = "BlinkCmpKindEnumMember" },
    BlinkCmpKindSupermaven = { link = "BlinkCmpKindEnumMember" },
    BlinkCmpKindTabNine = { link = "BlinkCmpKindEnumMember" },
    BlinkCmpKindKey = { link = "BlinkCmpKindEnumMember" },
    -- BlinkCmpKindKeyword = { fg = "#c678dd" },
    BlinkCmpKindKeyword = { fg = colors.purple or colors.violet },
    BlinkCmpKindClass = { link = "BlinkCmpKindKeyword" },
    BlinkCmpKindConstructor = { link = "BlinkCmpKindKeyword" },
    BlinkCmpKindUnit = { link = "BlinkCmpKindKeyword" },
    BlinkCmpKindReference = { link = "BlinkCmpKindKeyword" },
    BlinkCmpKindEvent = { link = "BlinkCmpKindKeyword" },
    BlinkCmpKindOperator = { link = "BlinkCmpKindKeyword" },
    -- BlinkCmpKindValue = { fg = "#d19a66" },
    BlinkCmpKindValue = { fg = colors.orange },
    BlinkCmpKindColor = { link = "BlinkCmpKindValue" },
    BlinkCmpKindObject = { link = "BlinkCmpKindValue" },
    BlinkCmpKindDefault = { fg = "#1abc9c" },
    BlinkCmpKind = { link = "BlinkCmpKindDefault" },
    BlinkCmpKindText = { link = "BlinkCmpKindDefault" },

    -- BlinkCmpLabelMatch = { fg = "#61afef" },
    BlinkCmpLabelMatch = { fg = colors.blue },
    -- BlinkCmpScrollBarThumb = { bg = "#d19a66" },
    BlinkCmpScrollBarThumb = { bg = colors.orange },
    BlinkCmpMenu = { fg = colors.fg },
    BlinkCmpMenuBorder = { fg = colors.green },
    -- BlinkCmpMenuSelection = { bg = "#414858", fg = "#e5c07b" },
    BlinkCmpMenuSelection = { bg = "#414858" },
    BlinkCmpSource = { fg = "#5c6370" },
  }
end

local onedarkpro = {
  "olimorris/onedarkpro.nvim",
  lazy = true,
  config = function()
    local colors = require("onedarkpro.helpers").get_colors()
    colors.bg = "#181818"
    local hl = highlights(colors)
    hl.DashboardHeader = { fg = colors.cyan }
    hl.DashboardShortCut = { fg = colors.green }
    hl.DashboardIcon = { fg = colors.blue }
    hl.DashboardKey = { fg = colors.orange }
    hl.DashboardDesc = { fg = colors.green }
    hl.NvimTreeOpenedHL = { fg = colors.green }
    hl.NvimTreeRootFolder = { fg = colors.blue }
    hl.NvimTreeFolderIcon = { fg = colors.blue }
    hl.NvimTreeEmptyFolderName = { fg = colors.gray }
    hl.NvimTreeOpenedFolderName = { fg = colors.blue }
    hl.NvimTreeNormal = { fg = colors.gray }
    require("onedarkpro").setup({
      styles = {
        keywords = "italic",
        comments = "italic",
      },
      highlights = hl,
      -- filetypes = {
      --     all = false,
      -- },
      plugins = {
        all = false,
        -- dashboard = true,
        indentline = true,
        -- neo_tree = true,
        -- nvim_tree = true,
        nvim_notify = true,
        which_key = true,
        treesitter = true,
        -- nvim_cmp = true,
        -- mason = true,
        nvim_lsp = true,
        -- trouble = true,
        telescope = true,
        gitsigns = true,
        flash_nvim = true,
      },
      options = {
        transparency = true,
      },
    })
  end,
}

local solarized_osaka = {
  "craftzdog/solarized-osaka.nvim",
  lazy = true,
  config = function()
    require("solarized-osaka").setup({
      transparent = true,
      terminal_colors = true,
      hide_inactive_statusline = true,
      sidebars = {},
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, colors)
        local highlights = highlights(colors)
        for k, v in pairs(highlights) do
          hl[k] = v
        end
        hl.StatusLine = { bg = colors.none }
        hl.TabLineFill = { bg = colors.none }
        hl.IndentLine = { fg = "#3b4048" }
        hl.NvimTreeOpenedHL = { link = "Special" }
        vim.o.background = "dark"
      end,
    })
  end,
}

local tokyonight = {
  "folke/tokyonight.nvim",
  lazy = true,
  config = function()
    require("tokyonight").setup({
      style = "moon",
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, colors)
        local highlights = highlights(colors)
        for k, v in pairs(highlights) do
          hl[k] = v
        end
        hl.StatusLine = { bg = colors.none }
        hl.TabLineFill = { bg = colors.none }
        hl.IndentLine = { fg = "#3b4048" }
        hl.LineNr = { fg = "#3b4261" }
        hl.LineNrAbove = { link = "LineNr" }
        hl.LineNrBelow = { link = "LineNr" }
        vim.o.background = "dark"
      end,
    })
  end,
}

local everforest = {
  "neanias/everforest-nvim",
  version = false,
  lazy = true,
  config = function()
    require("everforest").setup({
      transparent_background_level = 2,
      italics = true,
      on_highlights = function(hl, colors)
        colors.bg = colors.bg0
        colors.cyan = colors.aqua
        local highlights = highlights(colors)
        for k, v in pairs(highlights) do
          hl[k] = v
        end
        hl.IndentLine = { fg = "#3b4048" }
        hl.DashboardHeader = { fg = colors.cyan }
        hl.DashboardShortCut = { fg = colors.green }
        hl.DashboardIcon = { fg = colors.blue }
        hl.DashboardKey = { fg = colors.orange }
        hl.DashboardDesc = { fg = colors.green }
        hl.NvimTreeNormal = { link = "Grey" }
      end,
    })
  end,
}

local catppuccin = {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = true,
  config = function()
    local colors = require("catppuccin.palettes").get_palette("frappe")
    colors.orange = colors.peach
    colors.cyan = colors.teal
    colors.purple = colors.mauve
    colors.none = "NONE"
    colors.bg = colors.base
    local hl = highlights(colors)
    hl.IndentLine = { fg = "#3b4048" }
    hl.LineNr = { fg = "#45475a" }
    hl.DashboardHeader = { fg = colors.cyan }
    require("catppuccin").setup({
      flavour = "frappe",
      transparent_background = true,
      float = { transparent = true, solid = true },
      term_colors = true,
      color_overrides = { all = colors },
      custom_highlights = hl,
      integrations = {
        mini = { enabled = false },
      },
    })
  end,
}

local dracula = {
  "Mofiqul/dracula.nvim",
  lazy = true,
  config = function()
    require("dracula").setup({
      transparent_bg = true,
      overrides = function(colors)
        colors.none = "NONE"
        colors.blue = "#80a0ff"
        local hl = highlights(colors)
        hl.StatusLine = { bg = colors.none }
        hl.TabLineFill = { bg = colors.none }
        hl.IndentLine = { fg = "#3b4048" }
        hl.TelescopeNormal = { fg = colors.fg }
        hl.BlinkCmpLabel = { fg = colors.white }
        hl.BlinkCmpLabelDeprecated = { fg = colors.white }
        hl.BlinkCmpKind = { fg = colors.white }
        return hl
      end,
    })
  end,
}

local tokyodark = {
  "tiagovla/tokyodark.nvim",
  lazy = true,
  config = function()
    require("tokyodark").setup({
      transparent_background = true,
      custom_highlights = function(_, colors)
        local hl = highlights(colors)
        hl.StatusLine = { bg = colors.none }
        hl.TabLineFill = { bg = colors.none }
        hl.IndentLine = { fg = "#3b4048" }
        hl.NvimTreeNormal = { fg = colors.fg }
        hl.DashboardHeader = { fg = colors.cyan }
        hl.DashboardShortCut = { fg = colors.green }
        hl.DashboardIcon = { fg = colors.blue }
        hl.DashboardKey = { fg = colors.orange }
        hl.DashboardDesc = { fg = colors.green }
        return hl
      end,
    })
  end,
}

local bamboo = {
  "ribru17/bamboo.nvim",
  lazy = true,
  config = function()
    local colors = require("bamboo.palette").vulgaris
    colors.none = "NONE"
    colors.bg = colors.bg0
    local hl = highlights(colors)
    hl.StatusLine = { bg = colors.none }
    hl.TabLineFill = { bg = colors.none }
    hl.IndentLine = { fg = "#3b4048" }
    hl["@Comment"] = { link = "Comment" }
    require("bamboo").setup({
      style = "vulgaris",
      transparent = true,
      highlights = hl,
    })
  end,
}

local vscode = {
  "Mofiqul/vscode.nvim",
  lazy = true,
  config = function()
    local colors = require("vscode.colors").get_colors()
    colors.blue = colors.vscBlue
    colors.green = colors.vscGreen
    colors.orange = colors.vscOrange
    colors.violet = colors.vscViolet
    colors.red = colors.vscRed
    colors.yellow = colors.vscYellow
    colors.cyan = colors.vscBLueGreen
    colors.bg = colors.vscBack
    colors.none = colors.vscNone
    local hl = highlights(colors)
    hl.StatusLine = { bg = colors.none }
    hl.TabLineFill = { bg = colors.none }
    hl.IndentLine = { fg = "#3b4048" }
    hl.NvimTreeNormal = { fg = colors.none }
    require("vscode").setup({
      style = "dark",
      transparent = true,
      group_overrides = hl,
    })
  end,
}

return { onedarkpro, solarized_osaka, tokyonight, everforest, catppuccin, dracula, tokyodark, bamboo, vscode }
