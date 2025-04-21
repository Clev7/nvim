return {
    'kevinhwang91/nvim-ufo',
    enabled = true,
    dependencies = {
        'kevinhwang91/promise-async',
        {
            "luukvbaal/statuscol.nvim",
            config = function ()
                local builtin = require("statuscol.builtin")
                require("statuscol").setup({
                    relculright = true,
                    segments = {
                        { text = { builtin.foldfunc }, click = "v:lua.ScFa"},
                        { text = { "%s" }, click = "v:lua.ScSa" },
                        { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" }
                    }
                })
            end
        }
    },
    config = function ()

        local ufo = require('ufo')

        -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
        vim.keymap.set('n', 'zR', ufo.openAllFolds)
        vim.keymap.set('n', 'zM', ufo.closeAllFolds)

        -- Use za for toggling a fold

        -- '0' is not bad
        -- TODO: Figure out how to use this
        vim.opt.foldcolumn = "1"
        -- Using ufo provider need a large value, feel free to decrease the value
        vim.opt.foldlevel = 99
        vim.opt.foldlevelstart = 99
        vim.opt.foldenable = true
        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

        -- Option 3: treesitter as a main provider instead
        -- (Note: the `nvim-treesitter` plugin is *not* needed.)
        -- ufo uses the same query files for folding (queries/<lang>/folds.scm)
        -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
        ufo.setup({
            provider_selector = function(bufnr, filetype, buftype)
                return {'treesitter', 'indent'}
            end,

            open_fold_hl_timeout = 150,
        })

    end
}
