return {
  {
    "nvim-telescope/telescope.nvim",
    version = false,
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope fd<cr>", desc = "Files" },
      -- {
      --   "<leader>fr",
      --   "<cmd>Telescope live_grep<cr>",
      --   desc = "Files Content",
      -- },
      {
        "<leader>fr",
        function()
          require("utils.livegrep").multi()
        end,
        desc = "Files Content",
      },
      { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      {
        "<leader>fg",
        "<cmd>Telescope git_files<cr>",
        desc = "Git Files",
      },
      {
        "<leader>fc",
        "<cmd>Telescope git_commits<cr>",
        desc = "Git Commits",
      },
      {
        "<leader>fs",
        "<cmd>Telescope git_status<cr>",
        desc = "Git Status",
      },
      {
        "<leader>fo",
        "<cmd>Telescope oldfiles<cr>",
        desc = "Recent Files",
      },
      {
        "<leader>fe",
        "<cmd>Telescope symbols<cr>",
        desc = "Emoji",
      },
      { "<leader>fl", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy search Current Buffer" },
      {
        "<leader>fh",
        "<cmd>Telescope help_tags<cr>",
        desc = "Help Tags",
      },
      -- { "<leader>fq", "<cmd>Telescope quickfix<cr>",                                 desc = "Quickfix" },
      {
        "<leader>fz",
        "<cmd>Telescope zoxide list<cr>",
        desc = "Zoxide List",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "jvgrootveld/telescope-zoxide",
      "nvim-telescope/telescope-symbols.nvim",
      -- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local actions = require("telescope.actions")
      local lsp_cursor_config = function(width, height, preview_width, preview_cutoff)
        return {
          layout_strategy = "cursor",
          sorting_strategy = "ascending",
          layout_config = {
            width = width or 0.45,
            height = height or 0.35,
            preview_width = preview_width or 0.6,
            preview_cutoff = preview_cutoff or 0,
          },
        }
      end
      local select_one_or_multi = function(prompt_bufnr)
        local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
        local multi = picker:get_multi_selection()
        if vim.tbl_isempty(multi) then
          actions.select_default(prompt_bufnr)
          return
        end
        actions.close(prompt_bufnr)
        for _, entry in pairs(multi) do
          local filename = entry.path or entry.filename
          local row = entry.lnum or 1
          local col = entry.col or 1
          if filename then
            vim.cmd(string.format("silent! edit %s", filename))
            pcall(vim.api.nvim_win_set_cursor, 0, { row, col })
          end
        end
      end

      require("telescope").setup({
        extensions = {
          zoxide = {
            prompt_title = "[ Zoxide List ]",
            list_command = "zoxide query -ls",
            mappings = {
              default = {
                action = function(selection)
                  vim.cmd.cd(selection.path)
                end,
              },
            },
          },
          -- fzf = {
          --   fuzzy = true,
          --   override_generic_sorter = true,
          --   override_file_sorter = true,
          --   case_mode = "smart_case",
          -- },
        },
        pickers = {
          fd = { push_tagstack_on_edit = true },
          live_grep = { push_tagstack_on_edit = true },
          lsp_references = lsp_cursor_config(),
          lsp_incoming_calls = lsp_cursor_config(),
          lsp_outgoing_calls = lsp_cursor_config(),
          lsp_implementations = lsp_cursor_config(),
          lsp_type_definitions = lsp_cursor_config(),
          diagnostics = {
            layout_strategy = "center",
            layout_config = { height = 0.4, width = 0.6, preview_cutoff = 9999 },
          },
          lsp_document_symbols = {
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = { height = 0.45, width = 0.6, prompt_position = "top", preview_width = 0.6 },
          },
          lsp_workspace_symbols = {
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = { height = 0.45, width = 0.7, prompt_position = "top", preview_width = 0.6 },
          },
          symbols = lsp_cursor_config(0.3),
          -- fd = { theme = "ivy" },
          -- live_grep = { theme = "ivy" },
        },
        defaults = {
          path_display = {
            "filename_first",
          },
          -- file_previewer = require("telescope.previewers").cat.new,
          dynamic_preview_title = true,
          layout_strategy = "vertical",
          layout_config = {
            vertical = {
              preview_height = 0.55,
              prompt_position = "bottom",
            },
          },
          selection_caret = " ",
          mappings = {
            i = {
              ["<C-n>"] = false,
              ["<C-p>"] = false,
              ["<C-u>"] = false,
              ["<C-d>"] = actions.preview_scrolling_up,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-h>"] = actions.preview_scrolling_left,
              ["<C-l>"] = actions.preview_scrolling_right,
              ["<M-f>"] = false,
              ["<M-k>"] = false,
              ["<M-h>"] = actions.results_scrolling_left,
              ["<M-l>"] = actions.results_scrolling_right,
              ["<C-C>"] = false,
              ["<C-X>"] = false,
              ["<C-V>"] = false,
              ["<C-R>"] = false,
              ["<C-T>"] = false,
              ["<C-q>"] = actions.close,
              ["<M-q>"] = false,
              -- ["<C-s>"] = actions.send_to_qflist + actions.open_qflist,
              ["<C-s>"] = false,
              -- ["<Tab>"] = actions.move_selection_next,
              -- ["<S-Tab>"] = actions.move_selection_previous
              ["<S-Tab>"] = false,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
              ["<C-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
              ["<C-J>"] = actions.move_selection_next,
              ["<C-K>"] = actions.move_selection_previous,
              ["<Cr>"] = select_one_or_multi,
            },
            n = {
              ["<C-n>"] = false,
              ["<C-p>"] = false,
              ["H"] = false,
              ["M"] = false,
              ["L"] = false,
              ["gg"] = false,
              ["G"] = false,
              ["t"] = actions.move_to_top,
              ["m"] = actions.move_to_middle,
              ["b"] = actions.move_to_bottom,
              ["<C-u>"] = false,
              ["<C-d>"] = actions.preview_scrolling_up,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-h>"] = actions.preview_scrolling_left,
              ["<C-l>"] = actions.preview_scrolling_right,
              ["<M-f>"] = false,
              ["<M-k>"] = false,
              ["<M-h>"] = actions.results_scrolling_left,
              ["<M-l>"] = actions.results_scrolling_right,
              ["<C-c>"] = false,
              ["<C-q>"] = actions.close,
              ["<M-q>"] = false,
              -- ["<C-s>"] = actions.send_to_qflist + actions.open_qflist,
              ["<C-s>"] = false,
              ["<C-X>"] = false,
              ["<C-V>"] = false,
              ["<C-T>"] = false,
              ["<S-Tab>"] = false,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
              ["<C-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
              ["<Cr>"] = select_one_or_multi,
            },
          },
        },
      })
      require("telescope").load_extension("zoxide")
      -- require("telescope").load_extension("fzf")
    end,
  },
}
