return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require('telescope.builtin')
        local map = vim.keymap.set

        local tree_cwd = require("nvim-tree.api").tree.get_root().path
        map('n', '<leader>pf', builtin.find_files({ cwd = tree_cwd }), {})
        map('n', '<C-p>', builtin.git_files({cwd = tree_cwd}), {})
        map('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > "), cwd = tree_cwd});
        end)
    end
}
