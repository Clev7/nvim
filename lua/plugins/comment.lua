-- Inspired by josean-dev/dev-environment-files

return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
        local comment = require("Comment")
        local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")
        -- enable comment
        comment.setup({
            pre_hook = ts_context_commentstring.create_pre_hook(),

            toggler = {
                line = '<leader>/',
                block = '<C-_>'
            },

            opleader = {
            line = '<leader>/',
            block = '<C-_>'
            },

            mappings = {
                basic = true,
            }
        })
    end
}
