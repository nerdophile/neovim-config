-- ~/.config/nvim/lua/config/autocmds.lua
-- Helper function to check if buffer should be auto-saved
local function should_autosave()
  -- Don't auto-save if buffer is readonly
  if vim.bo.readonly then
    return false
  end
  
  -- Don't auto-save if buffer is not modifiable
  if not vim.bo.modifiable then
    return false
  end
  
  -- Don't auto-save if buffer has no name (like scratch buffers)
  if vim.fn.expand('%') == '' then
    return false
  end
  
  -- Don't auto-save special filetypes
  local excluded_filetypes = {
    'netrw',
    'NvimTree',
    'help',
    'qf',
    'fugitive',
    'gitcommit',
    'trouble',
    'telescope',
    'lazy',
    'mason',
    'lspinfo',
    'oil',
  }
  
  for _, ft in ipairs(excluded_filetypes) do
    if vim.bo.filetype == ft then
      return false
    end
  end
  
  -- Don't auto-save buffers that start with certain patterns
  local bufname = vim.fn.expand('%:p')
  local excluded_patterns = {
    '^fugitive://',
    '^oil://',
    '^term://',
  }
  
  for _, pattern in ipairs(excluded_patterns) do
    if bufname:match(pattern) then
      return false
    end
  end
  
  return true
end

-- Auto-save configuration with safety checks
local autosave_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })

vim.api.nvim_create_autocmd("InsertLeave", {
  group = autosave_group,
  pattern = "*",
  callback = function()
    if should_autosave() then
      vim.cmd("silent! write")
    end
  end,
})

vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI"}, {
  group = autosave_group,
  pattern = "*",
  callback = function()
    if should_autosave() then
      vim.cmd("silent! write")
    end
  end,
})

vim.api.nvim_create_autocmd("FocusLost", {
  group = autosave_group,
  pattern = "*",
  callback = function()
    if should_autosave() then
      vim.cmd("silent! wall")
    end
  end,
})

vim.api.nvim_create_autocmd("BufLeave", {
  group = autosave_group,
  pattern = "*",
  callback = function()
    if should_autosave() then
      vim.cmd("silent! write")
    end
  end,
})

-- Auto format Go files on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    -- Only format if it's a modifiable Go file
    if not vim.bo.modifiable or vim.bo.readonly then
      return
    end
    
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

return {}
