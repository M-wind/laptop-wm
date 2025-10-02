local function on_attach(bufnr)
  local api = require("nvim-tree.api")
  local function opts(desc)
    return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  local keymap = vim.keymap.set

  keymap("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
  keymap("n", "<CR>", api.node.open.edit, opts("Open"))
  keymap("n", "l", api.node.open.edit, opts("Open"))
  keymap("n", "L", api.node.open.edit, opts("Open"))
  keymap("n", "a", api.fs.create, opts("Create File or Directory"))
  keymap("n", "c", api.fs.copy.node, opts("Copy"))
  keymap("n", "d", api.fs.remove, opts("Delete"))
  keymap("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
  keymap("n", "r", api.fs.rename, opts("Rename"))
  keymap("n", "R", api.fs.rename_full, opts("Rename: Full Path"))
  keymap("n", "x", api.fs.cut, opts("Cut"))
  keymap("n", "y", api.fs.copy.filename, opts("Copy Name"))
  keymap("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
  keymap("n", "C", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
  keymap("n", "p", api.fs.paste, opts("Paste"))
  keymap("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
  keymap("n", "f", api.live_filter.start, opts("Live Filter: Start"))
  keymap("n", "F", api.live_filter.clear, opts("Live Filter: Clear"))
  keymap("n", "W", api.tree.collapse_all, opts("Collapse"))
  keymap("n", "E", api.tree.expand_all, opts("Expand All"))
  keymap("n", "H", api.tree.toggle_enable_filters, opts("Toggle Hidden"))
  keymap("n", "s", api.tree.search_node, opts("Search"))
  keymap("n", "?", api.tree.toggle_help, opts("Help"))
  keymap("n", "+", "<cmd>NvimTreeResize +10<cr>", opts("Size +10"))
  keymap("n", "_", "<cmd>NvimTreeResize -10<cr>", opts("Size -10"))
  keymap("n", "z", api.tree.resize, opts("Size Default"))
end

local nvim_tree = {
  "nvim-tree/nvim-tree.lua",
  version = false,
  cmd = "NvimTreeToggle",
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "File Explorer" },
  },
  config = function()
    require("nvim-tree").setup({
      on_attach = on_attach,
      -- disable_netrw = true,
      -- hijack_netrw = false,
      sync_root_with_cwd = true,
      update_focused_file = { enable = false },
      view = {
        width = 25,
        -- signcolumn = "no",
        cursorline = false,
        -- float = {
        --     enable = true,
        --     quit_on_focus_loss = false,
        -- },
      },
      renderer = {
        root_folder_label = false,
        special_files = {},
        highlight_opened_files = "name",
        icons = {
          diagnostics_placement = "after",
          show = {
            folder_arrow = false,
          },
        },
      },
      git = {
        enable = false,
      },
      diagnostics = {
        enable = true,
        icons = {
          hint = "",
        },
      },
      filters = {
        dotfiles = true,
      },
    })
  end,
}

return { nvim_tree }
