return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && yarn install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
	ft = { "markdown" },
	config = function()
		local group = vim.api.nvim_create_augroup("MarkdownPreview", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			pattern = "markdown",
			callback = function()
				vim.keymap.set(
					"n",
					"<localleader>r",
					"<Plug>MarkdownPreviewToggle",
					{ buffer = true, silent = true }
				)
			end,
		})
	end,
}