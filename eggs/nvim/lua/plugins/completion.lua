-- local cmp = {
--   "hrsh7th/nvim-cmp",
--   version = false,
--   event = "InsertEnter",
--   dependencies = {
--     "hrsh7th/cmp-nvim-lsp",
--     "hrsh7th/cmp-buffer",
--     "hrsh7th/cmp-path",
--     "hrsh7th/cmp-calc",
--     {
--       "garymjr/nvim-snippets",
--       opts = { friendly_snippets = true },
--       dependencies = { "rafamadriz/friendly-snippets" },
--     },
--   },
--   config = function()
--     local cmp = require("cmp")
--     cmp.setup({
--       snippet = {
--         expand = function(args)
--           require("utils.cmp").expand(args.body)
--         end,
--       },
--       mapping = cmp.mapping.preset.insert({
--         ["<C-f>"] = cmp.mapping.scroll_docs(-4),
--         ["<C-d>"] = cmp.mapping.scroll_docs(4),
--         ["<C-e>"] = cmp.mapping.abort(),
--         ["<CR>"] = cmp.mapping.confirm({ select = true }),
--         ["<Tab>"] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             cmp.select_next_item()
--           elseif vim.snippet.active({ direction = 1 }) then
--             vim.snippet.jump(1)
--           else
--             fallback()
--           end
--         end, { "i", "s" }),
--         ["<S-Tab>"] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             cmp.select_prev_item()
--           elseif vim.snippet.active({ direction = -1 }) then
--             vim.snippet.jump(-1)
--           else
--             fallback()
--           end
--         end, { "i", "s" }),
--       }),
--       sources = cmp.config.sources({
--         { name = "nvim_lsp" },
--         { name = "snippets" },
--         { name = "path" },
--         { name = "calc" },
--       }, {
--         { name = "buffer" },
--       }),
--       window = {
--         completion = {
--           winhighlight = "Noraml:NormalFloat,CursorLine:IncSearch",
--           border = "rounded",
--         },
--         documentation = {
--           border = "rounded",
--         },
--       },
--       formatting = {
--         fields = { "kind", "abbr", "menu" },
--         format = function(_, item)
--           item.name = item.kind
--           item.kind = require("utils.icons").cmp[item.kind] or ""
--           item.menu = "    (" .. (item.name or "") .. ")"
--           -- item.menu = "    " .. (item.name or "")
--           item = require("utils.tailwindcsscolors").cmp_tailwind_color(item)
--           return item
--         end,
--       },
--     })
--   end,
-- }

local blink = {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  event = "InsertEnter",
  version = "*",
  opts = {
    enabled = function()
      return not vim.tbl_contains({ "nofile", "prompt" }, vim.bo.buftype)
    end,
    keymap = {
      preset = "none",
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<C-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<C-e>"] = { "hide" },
      -- ["<C-w>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-d>"] = { "scroll_documentation_up", "fallback" },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    -- fuzzy = { implementation = "prefer_rust_with_warning" },
    fuzzy = { implementation = "rust" },
    cmdline = { enabled = false },
    completion = {
      keyword = { range = "full" },
      list = { selection = { preselect = true, auto_insert = true } },
      menu = {
        border = "rounded",
        -- winhighlight = "Noraml:NormalFloat,CursorLine:IncSearch",
        draw = {
          align_to = "label",
          columns = { { "kind_icon" }, { "label", "kind", gap = 1 } },
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                -- return require("utils.icons").cmp[ctx.kind] or ""
                local tailwindColor = require("utils.theme").tailwindColor
                if ctx.kind == "Color" then
                  tailwindColor[ctx.kind_hl] = ctx.item.documentation
                end
                return require("utils.icons").cmp[ctx.kind]
              end,
            },
            kind = {
              ellipsis = false,
              text = function(ctx)
                -- local kind = require("utils.icons").cmp[ctx.kind] and ctx.kind or "Tips"
                -- return "(" .. kind .. ")"
                return "(" .. ctx.kind .. ")"
              end,
              highlight = "BlinkCmpSource",
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 300,
        window = { border = "rounded" },
      },
    },
    signature = { enabled = false, window = { border = "rounded" } },
  },
}

return { blink }
