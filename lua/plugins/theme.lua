-- ~/.config/nvim/lua/plugins/theme.lua
return {
  -- OneDark Pro theme
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
        theme = "onedark", -- onedark, onelight, onedark_vivid, onedark_dark
        transparent = false,
        terminal_colors = true,
        code_style = {
          comments = "italic",
          keywords = "none",
          functions = "none",
          strings = "none",
          variables = "none"
        },
        plugins = {
          gitsigns = true,
          nvim_cmp = true,
          nvim_lsp = true,
          nvim_tree = true,
          telescope = true,
          treesitter = true,
          trouble = true,
        }
      })
      vim.cmd.colorscheme "onedark"
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "onedark" }
      })
    end,
  },
}
