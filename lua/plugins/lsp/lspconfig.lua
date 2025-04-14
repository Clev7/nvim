return {
  "neovim/nvim-lspconfig",
  enabled = true,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim",                   opts = {} },
    { "lukas-reineke/lsp-format.nvim" }
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    -- For autocompletion
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local lsp_format = require('lsp-format')

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    lsp_format.setup {

      --- ADD FORMATTING OPTIONS HERE
      formatting_options = {

      }
    }

    -- for conciseness
    local keymap = vim.keymap

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"

        -- show definition, references
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"

        -- go to declaration
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"

        -- show lsp definitions
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"

        -- show lsp implementations
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"

        -- show lsp type definitions
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "See available code actions"

        -- see available code actions, in visual mode will apply to selection
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"

        -- smart rename
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"

        -- show  diagnostics for file
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"

        -- show diagnostics for line
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"

        -- jump to previous diagnostic in buffer
        keymap.set("n", "<C-[>", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"

        -- jump to next diagnostic in buffer
        keymap.set("n", "<C-]>", vim.diagnostic.goto_next, opts)

        opts.desc = "Show documentation for what is under cursor"

        -- show documentation for what is under cursor
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"

        -- mapping to restart lsp if necessary
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

        opts.desc = "Format the current buffer"
        opts.silent = false

        vim.keymap.set("n", "<leader>fm", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end,
    })

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

    for type, icon in pairs(signs) do
      local h1 = "DiagnosticSign" .. type
      vim.fn.sign_define(h1, { text = icon, texthl = h1, numhl = "" })
    end

    mason_lspconfig.setup_handlers({
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr) lsp_format.on_attach(client, bufnr) end,
        })
      end,
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr) lsp_format.on_attach(client, bufnr) end,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
                disable = { "missing-fields" }
              },
              completion = {
                callSnippet = "Replace"
              }
            }
          }
        })
      end,
    })
  end
}
