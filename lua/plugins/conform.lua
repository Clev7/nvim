return {
    'stevearc/conform.nvim',
    config = function()
        local conform = require("conform")
        local util = require("conform.util")

        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                go = { "gofmt" },
                rust = { "rustfmt", lsp_format = "fallback" },
                python = { "ruff_format" },
                java = { "google-java-format" },
                cpp = { "clang-format" },
                javascript = { "prettierd" },
                typescript = { "prettierd" }
            },

            formatters = {
                cwd = util.root_file({
                    -- https://prettier.io/docs/en/configuration.html
                    ".prettierrc",
                    ".prettierrc.json",
                    ".prettierrc.yml",
                    ".prettierrc.yaml",
                    ".prettierrc.json5",
                    ".prettierrc.js",
                    ".prettierrc.cjs",
                    ".prettierrc.mjs",
                    ".prettierrc.toml",
                    "prettier.config.js",
                    "prettier.config.cjs",
                    "prettier.config.mjs",
                    -- "package.json",
                })
            }
        })
    end
}
