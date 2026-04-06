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
        {
            "L3MON4D3/LuaSnip",
            -- follow latest release.
            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            build = "make install_jsregexp"
        },
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        { "roobert/tailwindcss-colorizer-cmp.nvim", opts = { color_square_width = 3 } },
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
                javascript = { "prettierd", "eslint_d"}, -- js
                typescript = { "prettierd", "eslint_d"}, -- ts
                typescriptreact = { "prettierd", "eslint_d"}, -- tsx
                javascriptreact = { "prettierd", "eslint_d"}, -- jsx
                json = { "prettierd" },
                markdown = { "grammarly" }, -- md
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

                -- makes sure prettier only runs when it finds a .prettierrc
                require_cwd = true,
            },

            -- comment this out if it gets too annoying
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

        vim.diagnostic.config({
            virtual_text = {
                prefix = '■ ', -- Could be '●', '▎', 'x', '■', , 
            },
        })


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
                ["cssls"] = function ()
                    -- It's differently spelled from lua_ls
                    lspconfig["cssls"].setup({
                        settings = {
                            css = {
                                validate = true,
                                lint = {
                                    unknownAtRules = "ignore"
                                }
                            }
                        }
                    })
                end,
            },
        })

        -- cmp config
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local tw_colorizer = require("tailwindcss-colorizer-cmp").formatter
        local luasnip = require('luasnip')
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            completion = {
                -- I'm not sure why completeopt works and autocomplete doesn't
                -- autocomplete = { "InsertEnter", "TextChangedI"},
                completeopt = "menu,menuone,noselect",
            },

            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },

            mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                -- Confirms autcomplete selection
                ["<CR>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        if luasnip.expandable() then
                            luasnip.expand()
                        else
                            cmp.confirm({
                                select = true,
                            })
                        end
                    else
                        fallback()
                    end
                end),
                -- Autocompletes what you're typing
                ["<C-Space>"] = cmp.mapping.complete(),
            }),

            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
            }),

            formatting = {
                fields = { "kind", "abbr", "menu"},
                format = function(entry, vim_item)
                    -- From ChatGPT

                    vim_item = tw_colorizer(entry, vim_item)

                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        buffer = "[BUF]",
                        path = "[PATH]",
                        luasnip = "[SNIP]"
                    })[entry.source.name]

                    return vim_item
                end
            }
        })

        -- TODO: Compare with old vim.diagnostic.config
        --[[ vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        }) ]]
    end,
}
