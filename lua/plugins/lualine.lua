return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        theme = "vscode",
        sections = {
            lualine_c = {
                {
                    "filename",
                    path = 1,
                    symbols = {
                        modified = " ●", -- Text to show when the buffer is modified
                        alternate_file = "#", -- Text to show to identify the alternate file
                        directory = "", -- Text to show when the buffer is a directory
                    },
                },
            },
        },
    },
}
