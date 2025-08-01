local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup("HighlightYank", {})
local custom_group = augroup("Custom", {})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			hlgroup = "IncSearch",
			timeout = 40,
		})
	end,
})

-- Removes trailing whitespace (ignoring errors)
autocmd({ "BufWritePre" }, {
	group = custom_group,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- Helps prevent adding newlines
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    vim.opt_local.eol = false
  end
})

autocmd("LspAttach", {
	group = custom_group,
	callback = function(ev)
		-- buffer local mappings.
		-- see `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf, silent = true }

		-- set keybinds
		opts.desc = "show lsp references"

		-- TODO: figure out what the difference is between all of these lmao

		-- show definition, references
		vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)

		opts.desc = "go to declaration"

		-- go to declaration
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

		opts.desc = "show lsp definitions"

		-- show lsp definitions
		vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)

		opts.desc = "show lsp implementations"

		-- show lsp implementations
		vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)

		opts.desc = "show lsp type definitions"

		-- show lsp type definitions
		vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", opts)

		opts.desc = "see available code actions"

		-- see available code actions, in visual mode will apply to selection
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

		opts.desc = "smart rename"

		-- smart rename
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

		opts.desc = "show buffer diagnostics"

		-- show  diagnostics for file
		vim.keymap.set("n", "<leader>d", "<cmd>Telescope diagnostics bufnr=0<cr>", opts)

		opts.desc = "show line diagnostics"

		-- show diagnostics for line
		vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

		opts.desc = "go to previous diagnostic"

		-- jump to previous diagnostic in buffer
		vim.keymap.set("n", "<C-[>", vim.diagnostic.goto_prev, opts)

		opts.desc = "go to next diagnostic"

		-- jump to next diagnostic in buffer
		vim.keymap.set("n", "<C-]>", vim.diagnostic.goto_next, opts)

		opts.desc = "show documentation for what is under cursor"

		-- show documentation for what is under cursor
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

		opts.desc = "restart lsp"

		-- mapping to restart lsp if necessary
		vim.keymap.set("n", "<leader>rs", ":lsprestart<cr>", opts)

		opts.desc = "format the current buffer"
		opts.silent = false

		vim.keymap.set("n", "<leader>fm", function()
			require("conform").format({ bufnr = 0 })
		end, opts)

		-- ThePrimeagen's Stuff
		-- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
		-- vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
		-- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
		-- vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
		-- vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
		-- vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
		-- vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
		-- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
		-- vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
		-- vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	end,
})