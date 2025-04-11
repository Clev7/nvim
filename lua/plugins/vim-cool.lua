-- Used for removing highlights when you're done searching
return {
    'romainl/vim-cool',
    config = function()
        vim.o.hlsearch = true
    end,
}
