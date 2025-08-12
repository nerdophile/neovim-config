-- lua/plugins/languages.lua - Rust & Go specific tools
-- ====================================================

return {
	-- Go tools
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()

			-- Go keymaps
			vim.keymap.set("n", "<leader>gr", ":GoRun<CR>", { desc = "[G]o [R]un" })
			vim.keymap.set("n", "<leader>gt", ":GoTest<CR>", { desc = "[G]o [T]est" })
			vim.keymap.set("n", "<leader>gb", ":GoBuild<CR>", { desc = "[G]o [B]uild" })
			vim.keymap.set("n", "<leader>gi", ":GoInstall<CR>", { desc = "[G]o [I]nstall" })
			vim.keymap.set("n", "<leader>gf", ":GoFmt<CR>", { desc = "[G]o [F]ormat" })
			vim.keymap.set("n", "<leader>gd", ":GoDoc<CR>", { desc = "[G]o [D]oc" })
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},

	-- Rust tools
	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		lazy = false, -- This plugin is already lazy
		init = function()
			-- Configure rustaceanvim before it loads
			vim.g.rustaceanvim = {
				-- Plugin configuration
				tools = {
					inlay_hints = {
						auto = true,
						show_parameter_hints = true,
						parameter_hints_prefix = "<- ",
						other_hints_prefix = "=> ",
					},
				},
				-- LSP configuration
				server = {
					on_attach = function(client, bufnr)
						-- Enable completion triggered by <c-x><c-o>
						vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

						-- Buffer local mappings
						local opts = { noremap = true, silent = true, buffer = bufnr }

						-- LSP keybindings (these will override the ones in lsp.lua for Rust files)
						vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
						vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
						vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
						vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
						vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
						vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
						vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
						vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
						vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
						vim.keymap.set("n", "<leader>f", function()
							vim.lsp.buf.format({ async = true })
						end, opts)

						-- Rust-specific keymaps
						vim.keymap.set("n", "<leader>rr", function()
							vim.cmd.RustLsp("runnables")
						end, opts)
						vim.keymap.set("n", "<leader>rt", function()
							vim.cmd.RustLsp("testables")
						end, opts)
						vim.keymap.set("n", "<leader>rd", function()
							vim.cmd.RustLsp("debuggables")
						end, opts)
						vim.keymap.set("n", "<leader>rc", function()
							vim.cmd.RustLsp("openCargo")
						end, opts)
					end,
					-- CRITICAL: Add LSP capabilities for autocompletion
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
					default_settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
								loadOutDirsFromCheck = true,
								buildScripts = {
									enable = true,
								},
							},
							procMacro = {
								enable = true,
							},
							diagnostics = {
								enable = true,
								experimental = {
									enable = true,
								},
							},
							checkOnSave = {
								command = "clippy",
								extraArgs = { "--all", "--", "-W", "clippy::all" },
							},
							inlayHints = {
								bindingModeHints = {
									enable = false,
								},
								chainingHints = {
									enable = true,
								},
								closingBraceHints = {
									enable = true,
									minLines = 25,
								},
								closureReturnTypeHints = {
									enable = "never",
								},
								lifetimeElisionHints = {
									enable = "never",
									useParameterNames = false,
								},
								maxLength = 25,
								parameterHints = {
									enable = true,
								},
								reborrowHints = {
									enable = "never",
								},
								renderColons = true,
								typeHints = {
									enable = true,
									hideClosureInitialization = false,
									hideNamedConstructor = false,
								},
							},
							completion = {
								addCallParentheses = true,
								addCallArgumentSnippets = true,
								postfix = {
									enable = true,
								},
								autoimport = {
									enable = true,
								},
							},
						},
					},
				},
			}
		end,
	},
}
