-- Used for removing highlights when you're done searching
return {
    'romainl/vim-cool',
    config = function()
        vim.opt.hlsearch = true
    end,
}
