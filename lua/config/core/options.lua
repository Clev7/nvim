local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- default spaces stuff. Use .editorconfig to change it per project
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

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

opt.cursorline = true

opt.termguicolors = true

-- have at least 8 lines underneath you when you scroll down
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.colorcolumn = "100"
vim.opt.clipboard = "unnamed,unnamedplus"
