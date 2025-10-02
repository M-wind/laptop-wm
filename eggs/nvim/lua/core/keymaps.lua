local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map({ "n", "v" }, "c", '"_c', { desc = "Delete & Insert" })
map({ "n", "v" }, "C", '"_C', { desc = "Delete After Cursor & Insert" })
map({ "n", "v" }, "cc", '"_cc', { desc = "Delete Line & Insert" })
map({ "n", "v" }, "d", '"_d', { desc = "Delete" })
map({ "n", "v" }, "D", '"_D', { desc = "Delete After Cursor" })
map({ "n", "v" }, "dd", '"_dd', { desc = "Delete Line" })

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
-- map("n", "<leader>a", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>t", function()
  require("utils.theme").change()
end, { desc = "Change Theme" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Search Result Jump
map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map({ "n", "x", "o" }, "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })
-- Go Back
map("n", "gn", "<C-t>", { desc = "Go Back" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize +2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize -2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- Terminal Mappings
-- map("t", "<esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
-- map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
-- map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
-- map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
-- map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })
map("t", "<C-\\>", "<cmd>close<cr>", { desc = "Hide Terminal" })

--buffer
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
-- map("n", "<S-d>", "<cmd>Bdelete<cr>", { desc = "Close Current Buffer" })
map("n", "<leader>bd", "<cmd>Bdelete<cr>", { desc = "Close Current Buffer" })
-- map("n", "<leader>bl", "<cmd>bnext<cr>", { desc = "Next Buffer" })
-- map("n", "<leader>bh", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
map("n", "<leader>bo", require("utils.heirline").Close_Buf_Except_Current, { desc = "Close Other Buffers" })
map("n", "<leader>b]", require("utils.heirline").Close_Buf_Right, { desc = "Close Right Buffers" })
map("n", "<leader>b[", require("utils.heirline").Close_Buf_Left, { desc = "Close Left Buffers" })
map("n", "<leader>ba", require("utils.heirline").Close_Buf_All, { desc = "Close All Buffers" })

-- tabs
-- map("n", "<leader><tab>]", "<cmd>tablast<cr>", { desc = "Last Tab" })
-- map("n", "<leader><tab>[", "<cmd>tabfirst<cr>", { desc = "First Tab" })
-- map("n", "<leader><tab>n", "<cmd>tabnew<cr>", { desc = "New Tab" })
-- map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other Window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window" })
map("n", "<leader>w-", "<C-W>s", { desc = "Split Window Below" })
map("n", "<leader>w=", "<C-W>v", { desc = "Split Window Right" })

-- scroll
map("n", "<C-f>", "<C-d>", { desc = "Scroll Down" })
map("n", "<C-d>", "<C-u>", { desc = "Scroll Up" })

-- highlights under cursor
-- map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
-- map("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- cancle highlight
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- quit
map({ "n", "v", "x", "o" }, "<leader>q", "<cmd>qa<cr>", { desc = "Quit All" })

-- Resume Cursor Position
map("n", "<leader>j", function()
  local mark = vim.api.nvim_buf_get_mark(0, '"')
  local lcount = vim.api.nvim_buf_line_count(0)
  if mark[1] > 0 and mark[1] <= lcount then
    vim.api.nvim_win_set_cursor(0, mark)
  end
end, { desc = "Re Cur Pos" })
