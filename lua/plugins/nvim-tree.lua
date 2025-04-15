return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  defaults = {
    lazy = true
  },
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    -- Disables netrw
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        -- Honestly I genuinely have no clue whether to use this or not
        -- update_root = {
        --   enable = true,
        -- }
      },
      view = {
        width = 35,
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        root_folder_label = false,
        highlight_git = true,

        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            default = "󰈚",
            folder = {
              default = "",
              empty = "",
              empty_open = "",
              open = "",
              symlink = "",
            },
            git = { unmerged = "" },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })

    -- set keymaps
    -- for conciseness
    local keymap = vim.keymap

    keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true, noremap = true, desc = "Toggle file explorer" })
    keymap.set("n", "<leader>n", ":NvimTreeFocus<CR>", { silent = true, noremap = true, desc = "Focus file explorer" })

    -- toggle file explorer on current file
    keymap.set("n", "<leader>cf", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })

    -- refresh file explorer    -- refresh file explorer
    keymap.set("n", "<leader>r", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
  end
}
