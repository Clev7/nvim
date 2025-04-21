local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- default spaces stuff. Use .editorconfig to change it per project
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smarttab = true

opt.smartindent = true
opt.wrap = false

opt.swapfile = false
opt.backup = false
-- theprimeagen's set.lua stuff
opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
opt.undofile = true

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- Highlights the line your cursor is on
-- opt.cursorline = true

opt.termguicolors = true

-- have at least 8 lines underneath you when you scroll down
opt.scrolloff = 8
opt.updatetime = 50
opt.colorcolumn = "100"
opt.clipboard = "unnamed,unnamedplus"
opt.isfname:append("@-@")
opt.signcolumn = "yes"

