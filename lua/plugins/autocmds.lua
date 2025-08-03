-- ~/.config/nvim/lua/config/autocmds.lua
-- Auto-save configuration
local autosave_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })

vim.api.nvim_create_autocmd("InsertLeave", {
  group = autosave_group,
  pattern = "*",
  command = "silent! write",
})

vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI"}, {
  group = autosave_group,
  pattern = "*",
  command = "silent! write",
})

vim.api.nvim_create_autocmd("FocusLost", {
  group = autosave_group,
  pattern = "*",
  command = "silent! wall",
})

vim.api.nvim_create_autocmd("BufLeave", {
  group = autosave_group,
  pattern = "*",
  command = "silent! write",
})

-- Auto format Go files on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})
