local lsp = {
  "neovim/nvim-lspconfig",
  event = "User FilePost",
  opts = function()
    local icons = require("utils.icons").diagnostics
    return {
      servers = {
        -- npm install -g typescript typescript-language-server
        -- ts_ls = require("ft.typescript").lsp,
        -- npm install -g @vtsls/language-server
        vtsls = require("ft.typescript").lsp,
        tailwindcss = {},
        nushell = {},
        jsonls = {},
        -- ["rust_analyzer"] = require("ft.rust").lsp,
      },
      diagnostics = {
        underline = true,
        update_in_insert = false,
        -- virtual_text = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          current_line = true,
        },
        -- virtual_lines = true,
        -- virtual_lines = { current_line = true },
        severity_sort = true,
        float = {
          header = "",
          prefix = "",
          source = "always",
          border = "rounded",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.Error,
            [vim.diagnostic.severity.WARN] = icons.Warn,
            [vim.diagnostic.severity.HINT] = icons.Hint,
            [vim.diagnostic.severity.INFO] = icons.Info,
          },
        },
      },
    }
  end,
  config = function(_, opts)
    require("lspconfig.ui.windows").default_options.border = "rounded"
    -- diagnostics
    vim.diagnostic.config(opts.diagnostics)
    -- -- sings
    -- for name, icon in pairs(opts.signs) do
    --   vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
    -- end
    -- keymaps
    require("utils.lsp").on_attach(function(_, buf)
      vim.keymap.set({ "n", "v" }, "<leader>d", "", { desc = "+Diagnostics" })
      vim.keymap.set("n", "<leader>dc", vim.diagnostic.open_float, { desc = "Current Diagnostic" })
      vim.keymap.set("n", "<leader>dh", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
      vim.keymap.set("n", "<leader>dl", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
      vim.keymap.set({ "n", "v" }, "<leader>c", vim.lsp.buf.code_action, { desc = "Code Action" })
      vim.keymap.set(
        "n",
        "<leader>da",
        "<cmd>Telescope diagnostics bufnr=0<cr>",
        { desc = "All Diagnostic With Current Page" }
      )
      -- vim.keymap.set("n", "<leader>da", function()
      --   Snacks.picker.diagnostics_buffer()
      -- end, { desc = "All Diagnostic With Current Page" })
      vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "GoTo Definition", buffer = buf })
      vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "GoTo References", buffer = buf })
      -- vim.keymap.set("n", "gd", function()
      --   Snacks.picker.lsp_definitions()
      -- end, { desc = "GoTo Definition", buffer = buf })
      -- vim.keymap.set("n", "gr", function()
      --   Snacks.picker.lsp_references()
      -- end, { desc = "GoTo References", buffer = buf })
      -- vim.keymap.set(
      --   "n",
      --   "gI",
      --   "<cmd>Telescope lsp_implementations<cr>",
      --   { desc = "GoTo Implementation", buffer = buf }
      -- )
      -- vim.keymap.set(
      --   "n",
      --   "gt",
      --   "<cmd>Telescope lsp_type_definitions<cr>",
      --   { desc = "Goto Type Definition", buffer = buf }
      -- )
      -- vim.keymap.set("n", "gi", "<cmd>Telescope lsp_incoming_calls<cr>", { desc = "Lsp Incoming Calls", buffer = buf })
      -- vim.keymap.set("n", "go", "<cmd>Telescope lsp_outgoing_calls<cr>", { desc = "Lsp Outgoing Calls", buffer = buf })
      vim.keymap.set(
        "n",
        "gs",
        "<cmd>Telescope lsp_document_symbols<cr>",
        { desc = "Lsp Current Symbols", buffer = buf }
      )
      vim.keymap.set(
        "n",
        "gS",
        "<cmd>Telescope lsp_workspace_symbols<cr>",
        { desc = "Lsp Current Workspace Symbols", buffer = buf }
      )
      -- vim.keymap.set("n", "gs", function()
      --   Snacks.picker.lsp_symbols()
      -- end, { desc = "Lsp Current Symbols", buffer = buf })
      -- vim.keymap.set("n", "gS", function()
      --   Snacks.picker.lsp_workspace_symbols()
      -- end, { desc = "Lsp Current Workspace Symbols", buffer = buf })

      -- vim.keymap.set("n", "ga", function()
      --   vim.lsp.buf.code_action({ apply = true, context = { only = { "source.addMissingImports.ts" } } })
      -- end, { desc = "Add Missing Imports" })
      --
      -- vim.keymap.set("n", "gf", function()
      --   vim.lsp.buf.code_action({ apply = true, context = { only = { "source.fixAll.ts" } } })
      -- end, { desc = "Fix All Diagnostics" })
      --
      -- vim.keymap.set("n", "gm", function()
      --   vim.lsp.buf.code_action({ apply = true, context = { only = { "source.removeUnused.ts" } } })
      -- end, { desc = "Remove Unused Imports" })
      --
      -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "GoTo Declaration", buffer = buf })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover", buffer = buf })
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "LSP Rename", buffer = buf })
    end)

    require("utils.lsp").setup()
    -- inlay hints
    require("utils.lsp").on_supports_method("textDocument/inlayHint", function(_, buf)
      vim.keymap.set("n", "<leader>i", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, { desc = "Toggle Inlay Hit", buffer = buf })
    end)

    -- codeLens
    if vim.lsp.codelens then
      require("utils.lsp").on_supports_method("textDocument/codeLens", function(_, buffer)
        vim.lsp.codelens.refresh()
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
          buffer = buffer,
          callback = vim.lsp.codelens.refresh,
        })
      end)
    end

    -- capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
    capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
    for server, set in pairs(opts.servers) do
      local server_opts = vim.tbl_deep_extend("force", {
        capabilities = capabilities,
      }, set or {})
      -- require("lspconfig")[server].setup(server_opts)
      vim.lsp.config(server, server_opts)
      vim.lsp.enable(server)
    end
  end,
}

return { lsp }
