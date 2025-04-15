-- For copying through ssh

return {
    'ojroques/nvim-osc52',
    enable = false,
    config = function()
        local osc52 = require("osc52")

        vim.keymap.set('n', '<leader>y', function()
            osc52.copy_operator()
        end, { expr = true })

        vim.keymap.set('v', '<leader>y', function()
            osc52.copy_visual()
        end)
    end
}
