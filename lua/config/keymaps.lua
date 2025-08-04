-- ~/.config/nvim/lua/config/keymaps.lua
-- Telescope keymaps
vim.schedule(function()
  local ok, builtin = pcall(require, "telescope.builtin")
  if ok then
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help" })
  end
end)

-- File explorer
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

-- Trouble (Error Lens)
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle trouble" })
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace diagnostics" })
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document diagnostics" })

-- Toggle diagnostic lines
vim.keymap.set("n", "<leader>l", function()
  local config = vim.diagnostic.config() or {}
  if config.virtual_text then
    vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
  else
    vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
  end
end, { desc = "Toggle line diagnostics" })

-- Basic shortcuts
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
