Folder structure

~/.config/nvim/
├── init.lua                    # Main config
├── lua/
│   ├── config/
│   │   ├── keymaps.lua        # All keybindings
│   │   └── autocmds.lua       # Auto-save & other autocmds
│   └── plugins/
│       ├── theme.lua          # OneDark Pro theme
│       ├── editor.lua         # File explorer, telescope, treesitter
│       ├── lsp.lua           # LSP configuration
│       ├── diagnostics.lua   # Error Lens (trouble, lsp_lines)
│       ├── git.lua           # GitLens (gitsigns, fugitive)
│       └── languages.lua     # Rust & Go specific tools



This working version includes:

    ✅ OneDark Pro theme
    ✅ Go support with gopls and go.nvim tools
    ✅ Rust support with rustaceanvim
    ✅ Error Lens functionality (trouble + lsp_lines)
    ✅ GitLens functionality (gitsigns + fugitive)
    ✅ Fixed tsserver → ts_ls
    ✅ All keybindings included

Once this is working, we can then move to the modular structure if you want. But for now, this single-file approach will get everything working properly!
Key Features:

    <leader>ff - Find files
    <leader>fg - Live grep
    <leader>e - Toggle file explorer
    <leader>xx - Toggle trouble (errors)
    <leader>l - Toggle inline diagnostics
    <leader>gr - Go run
    <leader>gt - Go test
    <leader>rr - Rust runnables

