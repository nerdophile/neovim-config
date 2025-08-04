-- ~/.config/nvim/lua/plugins/editor.lua
return {

  -- Telescope (fuzzy finder)
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
      })
    end,
  },

  -- Treesitter (syntax highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { 
          "lua", "javascript", "typescript", "python", 
          "html", "css", "json", "rust", "go" 
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
