return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        local bufferline = require("bufferline")

        local opts = {
            noremap = true,
            silent = true,
        }

        for i = 1, 9 do
            vim.keymap.set("n", "<leader>" .. i, function()
                bufferline.go_to(i, true)
            end, opts)
        end

        vim.keymap.set("n", "<leader>0", function()
            bufferline.go_to(-1, true)
        end, opts)

        bufferline.setup({
            options = {
                numbers = 'ordinal'
            },
        })
    end,
}
