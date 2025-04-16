return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")
		local map = vim.keymap.set

		map("n", "<leader>pf", builtin.find_files, { desc = "Open fuzzy finder" })
		map("n", "<C-p>", builtin.git_files, { desc = "Open git files in the current project" })
		map("n", "<leader>ps", builtin.live_grep, { desc = "Live Grep" })
	end,
}
