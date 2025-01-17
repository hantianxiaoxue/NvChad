return {

  {
    "NvChad/base46",
    branch = "v2.5",
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "NvChad/ui",
    branch = "v2.5",
    lazy = false,
    config = function()
      require "nvchad"
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = "User FilePost",
    opts = { user_default_options = { names = false } },
    config = function(_, opts)
      require("colorizer").setup(opts)

      -- execute colorizer as soon as possible
      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      return { override = require "nvchad.icons.devicons" }
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "devicons")
      require("nvim-web-devicons").setup(opts)
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = {
      indent = { char = "│", highlight = "IblChar" },
      scope = { char = "│", highlight = "IblScopeChar" },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blankline")

      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup(opts)

      dofile(vim.g.base46_cache .. "blankline")
    end,
  },

  -- file managing , picker etc
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = require "nvchad.configs.nvimtree",
    config = function(_, opts)
      local function on_attach(bufnr)
        local function ots(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        local api = require "nvim-tree.api"
        local function change_parent()
          api.tree.change_root_to_parent()
          vim.api.nvim_command "cd %:p:h"
          vim.api.nvim_command "pwd"
        end
        local function change_current()
          api.tree.change_root_to_node()
          vim.api.nvim_command "cd %:p:h"
          vim.api.nvim_command "pwd"
        end
        -- api.config.mappings.default_on_attach(bufnr)
        -- vim.keymap.set("n", "<Space>c", "<cmd>cd %:p:h<CR>:pwd<CR>", ots "CWD to current node")
        vim.keymap.set("n", "<A-[>", change_parent, ots "Up")
        vim.keymap.set("n", "<A-]>", change_current, ots "Root to current node")
        vim.keymap.set("n", "X", api.tree.collapse_all, ots "Collapse")
        vim.keymap.set("n", "g?", api.tree.toggle_help, ots "Help")
        vim.keymap.set("n", "gh", api.tree.toggle_help, ots "Help")

        vim.keymap.set("n", "<C-k>", api.node.show_info_popup, ots "Info")
        vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, ots "Close Directory")
        vim.keymap.set("n", "<CR>", api.node.open.edit, ots "Open")
        vim.keymap.set("n", "o", api.node.open.preview, ots "Open Preview")
        vim.keymap.set("n", "vo", api.node.open.vertical, ots "Open: Vertical Split")
        vim.keymap.set("n", "ho", api.node.open.horizontal, ots "Open: Horizontal Split")
        vim.keymap.set("n", ".", api.node.run.cmd, ots "Run Command")
        vim.keymap.set("n", "a", api.fs.create, ots "Create File Or Directory")
        vim.keymap.set("n", "bd", api.marks.bulk.delete, ots "Delete Bookmarked")
        vim.keymap.set("n", "bm", api.marks.bulk.move, ots "Move Bookmarked")
        vim.keymap.set("n", "m", api.marks.toggle, ots "Toggle Bookmark")
        vim.keymap.set("n", "M", api.tree.toggle_no_bookmark_filter, ots "Toggle Filter: No Bookmark")
        vim.keymap.set("n", "c", api.fs.copy.node, ots "Copy")
        vim.keymap.set("n", "d", api.fs.remove, ots "Delete")
        vim.keymap.set("n", "e", api.fs.rename_basename, ots "Rename: Basename")
        vim.keymap.set("n", "gy", api.fs.copy.absolute_path, ots "Copy Absolute Path")
        vim.keymap.set("n", "ge", api.fs.copy.basename, ots "Copy Basename")
        vim.keymap.set("n", "J", api.node.navigate.sibling.last, ots "Last Sibling")
        vim.keymap.set("n", "K", api.node.navigate.sibling.first, ots "First Sibling")
        vim.keymap.set("n", "p", api.fs.paste, ots "Paste")
        vim.keymap.set("n", "P", api.node.navigate.parent, ots "Parent Directory")
        vim.keymap.set("n", "q", api.tree.close, ots "Close")
        vim.keymap.set("n", "r", api.fs.rename, ots "Rename")
        vim.keymap.set("n", "R", api.tree.reload, ots "Refresh")
        vim.keymap.set("n", "s", api.node.run.system, ots "Run System")
        vim.keymap.set("n", "u", api.fs.rename_full, ots "Rename: Full Path")
        vim.keymap.set("n", "x", api.fs.cut, ots "Cut")
        vim.keymap.set("n", "y", api.fs.copy.filename, ots "Copy Name")
        vim.keymap.set("n", "Y", api.fs.copy.relative_path, ots "Copy Relative Path")
        vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, ots "Open")
        vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, ots "CD")
      end
      opts.on_attach = on_attach

      dofile(vim.g.base46_cache .. "nvimtree")
      require("nvim-tree").setup(opts)
    end,
  },
}
