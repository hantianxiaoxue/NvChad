local map = vim.keymap.set

map("n", "vv", "^v$h", { desc = "Select current line" })
map({ "n", "v" }, "j", "gj", { desc = "Move down" })
map({ "n", "v" }, "k", "gk", { desc = "Move up" })
map("n", "<A-o>", "<C-o>", { desc = "Focus to prev" })
map("n", "<A-i>", "<C-i>", { desc = "Focus to next" })
map("n", "<leader>y", '"ayiw', { desc = "Copy current word" })
map("n", "<leader>p", 'viw"ap', { desc = "Paste current word" })
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- map("n", "q", ":q<cr>", { desc = "Quit" })
map("n", "<A-q>", ":q!<cr>", { desc = "Move Beginning of line" })
map("v", "H", "<Home>", { desc = "Move Left" })
map("v", "L", "<End>", { desc = "Move Right" })
map("n", "H", "<Home>", { desc = "Move Down" })
map("n", "L", "<End>", { desc = "Move Up" })

-- map("n", "<Space>w", "<cmd>noh<CR>", { desc = "General Clear highlights" })
map({ "n", "v" }, "<Space>w", "<cmd>Telescope grep_string<CR>", { desc = "Telescope live grep" })

if (vim.env.TERM_PROGRAM or "") ~= "WezTerm" then
  -- move
  map({ "n", "v" }, "<A-h>", "<C-w>h", { desc = "Switch Window left" })
  map({ "n", "v" }, "<A-l>", "<C-w>l", { desc = "Switch Window right" })
  map({ "n", "v" }, "<A-j>", "<C-w>j", { desc = "Switch Window down" })
  map({ "n", "v" }, "<A-k>", "<C-w>k", { desc = "Switch Window up" })
end
-- resize
map({ "n", "t" }, "<A-=>", "<cmd>resize+2<CR>", { desc = "Increase window size" })
map({ "n", "t" }, "<A-->", "<cmd>resize-2<CR>", { desc = "Decrease window size" })
map({ "n", "t" }, "<A-+>", "<cmd>vertical resize+2<CR>", { desc = "Increase vertical window size" })
map({ "n", "t" }, "<A-_>", "<cmd>vertical resize-2<CR>", { desc = "Decrease vertical window size" })

map({ "n", "v" }, "<A-w>", "<C-w>w", { desc = "Switch Window" })
map({ "n", "v" }, "<A-Enter>", "<cmd>bp<cr>", { desc = "To next buffer" })

map("t", "<A-h>", "<C-\\><C-N><C-w>h", { desc = "Switch Window left" })
map("t", "<A-l>", "<C-\\><C-N><C-w>l", { desc = "Switch Window right" })
map("t", "<A-j>", "<C-\\><C-N><C-w>j", { desc = "Switch Window down" })
map("t", "<A-k>", "<C-\\><C-N><C-w>k", { desc = "Switch Window up" })
map("t", "<A-w>", "<C-\\><C-N><C-w>w", { desc = "Switch Window" })

map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "File Save" })
map("v", "<C-c>", '"+y', { desc = "Copy" })
map("i", "<C-c>", '<Esc>"+y', { desc = "Copy" })
map({ "n", "v" }, "<C-v>", '"+p', { desc = "Paste" })
map("i", "<C-v>", '<Esc>"+p', { desc = "Paste" })
map("v", "<C-x>", '"+d', { desc = "Cute" })
map("i", "<C-x>", '<Esc>"+d', { desc = "Cute" })
map({ "n", "i", "v" }, "<C-a>", "<Esc>ggVG", { desc = "Select all" })
map({ "n", "i", "v" }, "<C-z>", "<Esc>u", { desc = "Undo" })

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
-- map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Lsp diagnostic loclist" })
map("n", "<leader>q", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Lsp diagnostic loclist" })

-- tabufline
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "Buffer New" })

map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "Buffer Goto next" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "Buffer Goto prev" })

-- close split window first,then tab,then nvim-tree
map("n", "<leader>w", function()
  local full_h = vim.fn.winheight(0) + vim.o.cmdheight + 2 == vim.o.lines
  local tw = Treewidth()
  local full_w = vim.fn.winwidth(0) + tw == vim.o.columns
  if not (full_h and full_w) then
    vim.cmd "close"
  else
    require("nvchad.tabufline").close_buffer()
  end
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

function Treewidth()
  -- if only one window return 0
  if vim.fn.winwidth(0) == vim.o.columns then
    return 0
  end
  local tabpages = vim.api.nvim_list_tabpages()
  for _, tabpage in ipairs(tabpages) do
    local winlist = vim.api.nvim_tabpage_list_wins(tabpage)
    -- for each window, check its bufer
    for _, win in ipairs(winlist) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.bo[buf].ft == "NvimTree" then
        return vim.api.nvim_win_get_width(win) + 1
      end
    end
  end
  return 0

  --[[ local w = vim.fn.winwidth(0)
  if vim.fn.expand "%" ~= "NvimTree_1" then
    w = vim.fn.winwidth(1)
  end
  return vim.fn.winwidth(0) ~= vim.o.columns and w + 1 or 0 ]]
end
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
map("n", "<Space>f", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
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

map({ "n", "t" }, "<leader>t", function()
  if vim.fn.expand "%" == "NvimTree_1" then
    vim.api.nvim_feedkeys(vim.api.nvim_eval '"\\<C-w>w"', "x", true)
  end
  require("nvchad.term").toggle { pos = "sp", id = "runner" }
end, { desc = "Terminal New horizontal term" })

map({ "t" }, "<F3>", function()
  local keys = vim.api.nvim_replace_termcodes("exit<CR>", false, false, true)
  vim.api.nvim_feedkeys(keys, "m", true)
end, { desc = "Terminal close" })

map("n", "<Space>", "")
map("n", "q", "")
map("n", "<Space>c", "<cmd>cd %:p:h<CR>:pwd<CR>", { desc = "CWD to current folder" })
map("n", "<leader>g", "<cmd>G next_hunk<CR>", { desc = "Git next hunk" })

map({ "n", "t" }, "<C-p>", "<cmd>lua require('base46').toggle_transparency()<CR>", { desc = "Toggle transparency" })
map({ "n", "i" }, "<A-s>", "<cmd>w<CR><Esc>", { desc = "Save" })
map("n", "<leader>l", "")

-- toggle lsp diagnostic msg
--[[ map("n", "<A-M>", function()
  -- local old = vim.g["lsphandler"]
  -- if not old then
  --   old = vim.lsp.handlers["textDocument/publishDiagnostics"]
  --   vim.g["lsphandler"] = old
  -- end
  local status = vim.g["lspmsg"] or 0
  if status == 0 then
    -- vim.diagnostic.enable()
    vim.g["lspmsg"] = 1
    vim.diagnostic.config {
      virtual_text = true,
    }
  else
    -- vim.diagnostic.disable()
    vim.g["lspmsg"] = 0
    vim.diagnostic.config {
      virtual_text = false,
    }
  end
end, { desc = "Toggle diagnostic" }) ]]

map("n", "gm", function()
  vim.diagnostic.open_float(nil, { focus = false })
end, { desc = "Float diagnostic msg" })
map("n", "<A-u>", "<cmd>Telescope undo<CR>")
