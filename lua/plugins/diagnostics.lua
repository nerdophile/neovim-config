-- lua/plugins/diagnostics.lua - Error Lens (trouble, lsp_lines)
-- ============================================================

return {
	-- Error Lens / Trouble
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},

	-- LSP Lines (inline diagnostics)
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()

			-- Configure diagnostics for real-time errors
			vim.diagnostic.config({
				virtual_text = false, -- Disable default virtual text since we use lsp_lines
				virtual_lines = true, -- Enable lsp_lines
				signs = true,
				underline = true,
				update_in_insert = true, -- KEY SETTING: Show diagnostics while typing
				severity_sort = true,
				float = {
					source = "always",
					border = "rounded",
					header = "",
					prefix = "",
				},
			})

			-- Configure diagnostic signs
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			-- Toggle keymaps
			vim.keymap.set("n", "<leader>l", function()
				require("lsp_lines").toggle()
			end, { desc = "Toggle LSP [L]ines" })
		end,
	},
}
