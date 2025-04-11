return {
    "navarasu/onedark.nvim",
    name="onedark",
    priority=1000,
    config = function()
        vim.cmd.colorscheme("onedark")

        -- This is for making the background set to your terminal.
        -- Doesn't really work for me yet, since I literally use
        -- an Ubuntu dark red background lol.
        --
        -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
}
