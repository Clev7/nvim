return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    ft = { "markdown" },
    opts = {
        file_types = { "markdown" },
        hover = {
            enabled = true,
        },
    },
    keys = {
        {
            "<localleader>rm",
            "<cmd>RenderMarkdown toggle<CR>",
            ft = "markdown",
            desc = "Toggle markdown rendering",
        },
    },
}
