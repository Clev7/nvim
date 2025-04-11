return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "vimdoc", -- for vim-help
            "c",
            "cpp",
            "lua",
            "javascript",
            "typescript",
            "rust",
            "java",
            "go",
        },

        sync_install = false,

        auto_install = true,

        ignore_install = {},

        highlight = {
            enable = true,

            additional_vim_regex_highlighting = false,
        },

        modules = {}
    }
}
