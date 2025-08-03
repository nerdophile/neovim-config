-- ~/.config/nvim/lua/plugins/diagnostics.lua (Error Lens equivalent)
return {
  -- Trouble (diagnostics viewer)
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        signs = {
          error = "",
          warning = "",
          hint = "",
          information = "",
          other = "",
        },
        use_diagnostic_signs = true,
      })
    end,
  },

  -- LSP Lines (inline diagnostics like VS Code Error Lens)
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
      
      vim.diagnostic.config({
        virtual_text = false, -- Disable default virtual text
        virtual_lines = true, -- Enable lsp_lines
      })
    end,
  },
}
