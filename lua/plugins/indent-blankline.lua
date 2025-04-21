return {
	enabled=true,
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
	config = function()
		require("ibl").setup({
			indent = {
				char = "┊",
			},
			whitespace = {
				remove_blankline_trail = false,
			},
			scope = {
				enabled = true,
				-- Gives you that underline
				-- on the current scope
				show_start = false,
				show_end = false
			}
		})
	end,
}
