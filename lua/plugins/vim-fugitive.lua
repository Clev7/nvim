return {
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set("n", "<leader>gs", "<cmd>Git status<cr>", { desc = "Git status" });
        vim.keymap.set("n", "<leader>gp", "<cmd>Git push<cr>", { desc = "Git push" });
    end
}
