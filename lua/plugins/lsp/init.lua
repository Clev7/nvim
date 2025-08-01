return {
    enabled = true,
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },
    config = function()
        local conform = require("conform")
        local util = require("conform.util")

        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                rust = { "rustfmt", lsp_format = "fallback" },
                python = { "ruff_format" },
                java = { "google-java-format" },
                cpp = { "clang-format" },
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                typescriptreact = { "prettierd" },
                javascriptreact = { "prettierd" },
                markdown = { "grammarly" },
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
                }),

                -- Makes sure prettier only runs when it finds a .prettierrc
                require_cwd = true,
            },

            -- Comment this out if it gets too annoying
            -- format_on_save = {
            -- 	timeout_ms = 500,
            -- 	lsp_fallback = true,
            -- },
        })
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("fidget").setup({})
        local lspconfig = require("lspconfig")
        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "jdtls",
            },

            handlers = {
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
                ["lua_ls"] = function()
                    lspconfig["lua_ls"].setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = {
                                    version = "LuaJIT",
                                    path = vim.split(package.path, ";"),
                                },
                                diagnostics = {
                                    globals = { "vim" },
                                    disable = { "missing-fields" },
                                },
                                completion = {
                                    callSnippet = "Replace",
                                },
                                format = {
                                    enable = true,
                                    -- Put format options here
                                    -- The value needs to be a STRING!
                                    defaultConfig = {
                                        indent_style = "space",
                                        indent_size = "2",
                                    },
                                },

                                workspace = {
                                    -- includes Neovim runtime files
                                    library = vim.api.nvim_get_runtime_file("", true),

                                    -- disable prompts about third-party
                                    checkThirdParty = false,
                                },

                                telemetry = { enable = false },
                            },
                        },
                    })
                end,
            },
        })

        -- cmp config
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },

            completion = {
                -- I'm not sure why completeopt works and autocomplete doesn't
                -- autocomplete = { "InsertEnter", "TextChangedI"},
                completeopt = "menu,menuone,noselect"
            },

            mapping = cmp.mapping.preset.insert({
                ["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<Tab>"] = cmp.mapping.select_next_item(cmp_select),

                -- Confirms autcomplete selection
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                -- Autocompletes what you're typing
                ["<C-Space>"] = cmp.mapping.complete(),
            }),

            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
            }),
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end,
}