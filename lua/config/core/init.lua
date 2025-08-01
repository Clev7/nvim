require("config.core.mappings")
require("config.core.options")
require("config.core.autocmds")

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
-- local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
--
-- for type, icon in pairs(signs) do
--   local h1 = "DiagnosticSign" .. type
--   vim.fn.sign_define(h1, { text = icon, texthl = h1, numhl = "" })
-- end