-- ~/.config/nvim/lua/plugins/diagnostics.lua (VS Code Error Lens style)
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
  -- Built-in virtual text diagnostics (inline like VS Code Error Lens)
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Configure diagnostics to show inline without extra spacing
      vim.diagnostic.config({
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- Format to make it look like VS Code Error Lens
          format = function(diagnostic)
            local icons = {
              [vim.diagnostic.severity.ERROR] = " ",
              [vim.diagnostic.severity.WARN] = " ",
              [vim.diagnostic.severity.INFO] = " ",
              [vim.diagnostic.severity.HINT] = " ",
            }
            local icon = icons[diagnostic.severity] or " "
            return string.format("%s %s", icon, diagnostic.message)
          end,
        },
        virtual_lines = false, -- Disable lsp_lines to prevent extra spacing
        underline = true,
        signs = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })
      
      -- Customize diagnostic signs in the sign column
      local signs = {
        Error = "",
        Warn = "",
        Hint = "",
        Info = "",
      }
      
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
      
      -- Customize diagnostic colors to look more like VS Code Error Lens
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { 
        fg = "#FF6B6B", 
        bg = "#2D1B1F", 
        italic = true 
      })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { 
        fg = "#FFB86C", 
        bg = "#2D271F", 
        italic = true 
      })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { 
        fg = "#8BE9FD", 
        bg = "#1F272D", 
        italic = true 
      })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { 
        fg = "#50FA7B", 
        bg = "#1F2D1F", 
        italic = true 
      })
    end,
  },
}
