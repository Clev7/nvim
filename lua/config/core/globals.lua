vim.g.rustaceanvim = {
    -- Plugin configuration

    tools = {},
    -- LSP configuration
    server = {
        on_attach = function(client, bufnr)
            -- you can also put keymaps in here
            vim.keymap.set("n", "<leader>ca", function()
                vim.cmd.RustLsp("codeAction")
            end, { silent = true, buffer = bufnr })

            vim.keymap.set("n", "K", function ()
                vim.cmd.RustLsp({'hover', 'actions'})
            end,
            { silent = true, buffer = bufnr})
        end,
        default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {},
        },
    },

    -- DAP configuration
    dap = {},
}