local map = vim.keymap.set

-- Clear keybinds
vim.keymap.del("n", "<C-W>d")
vim.keymap.del("n", "<C-W><C-D>")

map("n", "Q", "<nop>")

map("i", "jk", "<esc>", { noremap = true })
map("n", "<C-w>", "<cmd>confirm q<CR>", { desc = "quit the current window" })
map("n", "<C-q>", "<cmd>confirm qa<CR>", { desc = "quit all windows" })
map("n", "<leader>w", "<cmd>bp<bar>sp<bar>bn<bar>bd<cr>", {
    desc = "Exits the current buffer (with confirmation if you didn't save)",
    -- buffer = true,
    silent = true,
    noremap = true,
})


-- Allows you to move around between windows
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map({ "n", "i" }, "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

-- map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
-- map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })

map("n", "<TAB>", "<cmd>bnext<CR>", { desc = "go to the next buffer" })
map("n", "<S-TAB>", "<cmd>b#<CR>", { desc = "go to the previous buffer" })

map("n", "<leader>fm", function()
    require("conform").format({ lsp_fallback = true })
end, { desc = "general format file" })

-- Move the current selection up down
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Move stuff underneath you up
map("n", "J", "mzJ`z")

-- Allow you to stay centered while you page up and down
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Keep your search terms in the middle
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("x", "zp", '"_dP')

-- Dumping binds
-- Figure this out later :/
map({ "n", "v" }, "zd", '"_d')
map({ "n", "v" }, "zc", '"_c')

-- Credit: theprimeagen
-- These might be worth considering
-- If you want to decouple the system
-- clipboard from the neovim clipboard
--[[ map("n", "<leader>y", "\"+y")
map("v", "<leader>y", "\"+y")

map("n", "<leader>Y", "\"+Y")

map("n", "<leader>d", "\"_d")
map("v", "<leader>d", "\"_d") ]]
