return {
    "simrat39/rust-tools.nvim",
    config = function ()
        local rt = require("rust-tools")

        rt.setup({
            server = {
                on_attach = function(_, bufnr)
                    -- Hover actions
                    vim.keymap.set("n", "<localleader><space>", rt.hover_actions.hover_actions, {
                        buffer=bufnr
                    })

                    vim.keymap.set("n", "<localleader>a", rt.code_action_group.code_action_group, {
                        buffer = bufnr
                    })
                end
            },
        })
    end
}