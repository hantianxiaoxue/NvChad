local map = vim.keymap.set

map("n", "vv", "^v$", { desc = "Select current line" })
map("n", "<A-i>", "<C-i>", { desc = "Focus to prev" })
map("n", "<A-o>", "<C-o>", { desc = "Focus to next" })
map("n", "<leader>y", '"ayiw', { desc = "Copy current word" })
map("n", "<leader>p", 'viw"ap', { desc = "Paste current word" })
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

map("n", "q", ":q<cr>", { desc = "Move Beginning of line" })
map("v", "H", "<Home>", { desc = "Move Left" })
map("v", "L", "<End>", { desc = "Move Right" })
map("n", "H", "<Home>", { desc = "Move Down" })
map("n", "L", "<End>", { desc = "Move Up" })

map("n", "<Space>w", "<cmd>noh<CR>", { desc = "General Clear highlights" })

map("n", "<A-h>", "<C-w>h", { desc = "Switch Window left" })
map("n", "<A-l>", "<C-w>l", { desc = "Switch Window right" })
map("n", "<A-j>", "<C-w>j", { desc = "Switch Window down" })
map("n", "<A-k>", "<C-w>k", { desc = "Switch Window up" })
map({ "n", "i", "v" }, "<A-w>", "<C-w>w", { desc = "Switch Window" })
map({ "n", "i", "v" }, "<A-Enter>", "<cmd>bn<cr>", { desc = "To next buffer" })

map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "File Save" })
map({ "v", "i" }, "<C-c>", '"+y', { desc = "Copy" })
map({ "n", "i", "v" }, "<C-v>", '"+p', { desc = "Paste" })
map({ "i", "v" }, "<C-x>", '"+d', { desc = "Cute" })
map({ "n", "i", "v" }, "<C-a>", "<Esc>ggVG", { desc = "Select all" })

--------------
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle Line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Toggle Relative number" })

map("n", "<A-F>", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format Files" })

-- global lsp mappings
map("n", "<leader>lf", vim.diagnostic.open_float, { desc = "Lsp floating diagnostics" })
map("n", "<leader>d", vim.diagnostic.goto_prev, { desc = "Lsp prev diagnostic" })
map("n", "<leader>f", vim.diagnostic.goto_next, { desc = "Lsp next diagnostic" })
-- map("n", "<leader>d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Lsp prev diagnostic" })
-- map("n", "<leader>f", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Lsp next diagnostic" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Lsp diagnostic loclist" })

-- tabufline
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "Buffer New" })

map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "Buffer Goto next" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "Buffer Goto prev" })

map("n", "<leader>w", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Buffer Close" })

-- Comment
map("n", "<A-/>", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Comment Toggle" })

map(
  "v",
  "<A-/>",
  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { desc = "Comment Toggle" }
)

-- nvimtree
map("n", "<A-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree Toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Nvimtree Focus window" })

-- telescope
map("n", "<A-p>", "<cmd>Telescope find_files<cr>", { desc = "Telescope Find files" })
-- map("n", "<leader>t", "<cmd>Telescope terms<CR>", { desc = "Telescope Pick hidden term" })

map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Telescope Live grep" })
-- map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope Find buffers" })
-- map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope Help page" })
-- map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "Telescope Find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope Find oldfiles" })
-- map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Telescope Find in current buffer" })
-- map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "Telescope Git commits" })
-- map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Telescope Git status" })
map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "Telescope Nvchad themes" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "Telescope Find all files" }
)

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Terminal Escape terminal mode" })

-- new float terminals
map({ "n", "t" }, "<F2>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Terminal Floating term" })

-- map({"i","n"}, "<F3>", function()
--   local win = vim.api.nvim_get_current_win()
--   vim.api.nvim_win_close(win, true)
-- end, { desc = "Terminal Close term in terminal mode" })

-- map("n", "<leader>h", function()
--   require("nvchad.term").new { pos = "sp" }
-- end, { desc = "Terminal New horizontal term" })

-- map("n", "<leader>v", function()
--   require("nvchad.term").new { pos = "vsp" }
-- end, { desc = "Terminal New vertical window" })

-- -- toggleable
-- map({ "n", "t" }, "<A-v>", function()
--   require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
-- end, { desc = "Terminal Toggleable vertical term" })

-- map({ "n", "t" }, "<A-h>", function()
--   require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
-- end, { desc = "Terminal New horizontal term" })

map("n", "<Space>", "")
map("n", "<Space>c", "<cmd>cd %:p:h<CR>:pwd<CR>", { desc = "CWD to current" })
map("n", "<A-=>", "<cmd>resize+2<CR>", { desc = "Increase window size" })
map("n", "<A-->", "<cmd>resize-2<CR>", { desc = "Decrease window size" })
map("n", "<A-+>", "<cmd>vertical resize+2<CR>", { desc = "Increase vertical window size" })
map("n", "<A-_>", "<cmd>vertical resize-2<CR>", { desc = "Decrease vertical window size" })
