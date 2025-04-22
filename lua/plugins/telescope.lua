return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")
		local map = vim.keymap.set

		--[[ There's a bunch of really nice features in telescope,
		including git integration stuff and a bunch of good fuzzy
		finding variations. Could be a good time investment. ]]
		map("n", "<leader>pf", function()
			builtin.find_files()
		end, { desc = "(Find Files) Open fuzzy finder, disallowing hidden files" })

		map("n", "<leader>fa", function()
			builtin.find_files({ hidden = true, no_ignore = true })
		end, { desc = "(Find All) Open fuzzy finder, allowing hidden files and files/folders in .gitignore" })
		map("n", "<C-p>", builtin.git_files, { desc = "(Find Git) Open git files in the current project" })
		map("n", "<leader>ps", builtin.live_grep, { desc = "Live Grep" })
		map("n", "<leader>fo", builtin.oldfiles, { desc = "(Find Old) Looks for files in your history" })
	end,
}
