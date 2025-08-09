# 🚀 Neovim Configuration

A modern, feature-rich Neovim configuration optimized for development with Rust, Go, TypeScript, and more. This configuration provides a VS Code-like experience with powerful LSP integration, intelligent autocomplete, and enhanced developer productivity tools.

## ✨ Features

### 🎨 **UI & Theme**
- **OneDark Pro theme** - Beautiful, eye-friendly color scheme
- **Modern UI elements** - Bordered windows, custom icons, and clean aesthetics
- **Enhanced diagnostics** - Clear error/warning indicators with contextual information

### 🧠 **Intelligent Code Completion**
- **Multi-source completion** - LSP, snippets, buffer text, file paths
- **Smart Tab navigation** - Context-aware Tab/Shift-Tab for completion and snippets
- **Ghost text preview** - See completions before accepting them
- **VS Code-like icons** - Visual indicators for different completion types
- **Auto-pairs** - Automatic bracket, quote, and tag closing
- **Command-line completion** - Enhanced `:` command and `/` search completion

### 🔧 **Language Server Protocol (LSP)**
- **Auto-installation** - Automatic LSP server management with Mason
- **Enhanced capabilities** - Rich completion data, documentation, and diagnostics
- **Multiple language support** - Rust, Go, TypeScript/JavaScript, Python, Lua, JSON
- **Consistent keybindings** - Same shortcuts across all languages
- **Inlay hints** - Type information displayed inline (Rust)

### 🦀 **Rust Development**
- **rustaceanvim integration** - Advanced Rust tooling beyond basic LSP
- **Cargo integration** - Run, test, and build directly from editor
- **Clippy integration** - Real-time linting with Rust's official linter
- **Enhanced debugging** - DAP support for Rust debugging
- **Smart imports** - Automatic import suggestions and management

### 🐹 **Go Development**
- **gopls integration** - Official Go language server
- **Fuzzy matching** - Intelligent completion suggestions
- **Unimported completions** - Suggest packages not yet imported
- **Go tools integration** - Format, test, and build support

### 📁 **File Management**
- **Telescope integration** - Fuzzy file finder and live grep
- **File explorer** - Built-in file tree navigation
- **Git integration** - GitLens-like functionality with gitsigns and fugitive

### 🔍 **Diagnostics & Debugging**
- **Error Lens** - Inline error and warning display
- **Trouble integration** - Centralized error/warning panel
- **LSP lines** - Enhanced diagnostic display
- **Real-time feedback** - Instant error detection and suggestions

## 📦 Installation

### Prerequisites
- **Neovim 0.9+** - Latest stable version recommended
- **Git** - For plugin management
- **Node.js** - For TypeScript/JavaScript LSP
- **Python** - For Python LSP
- **Go** - For Go development (optional)
- **Rust** - For Rust development (optional)

### Quick Setup

1. **Backup existing configuration** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this configuration**:
   ```bash
   git clone https://github.com/nerdophile/neovim-config ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```

4. **Plugin installation** - Lazy.nvim will automatically install all plugins on first launch

5. **LSP servers** - Will auto-install when you open relevant file types

## 🗂️ File Structure

```
~/.config/nvim/
├── init.lua                 # Main configuration entry point
├── lua/
│   ├── config/
│   │   ├── keymaps.lua     # All keybindings and shortcuts
│   │   └── autocmds.lua    # Auto-save and other auto-commands
│   └── plugins/
│       ├── theme.lua       # OneDark Pro theme configuration
│       ├── editor.lua      # File explorer, telescope, treesitter
│       ├── lsp.lua         # LSP + completion configuration
│       ├── diagnostics.lua # Error Lens (trouble, lsp_lines)
│       ├── git.lua         # GitLens (gitsigns, fugitive)
│       └── languages.lua   # Language-specific tools
└── README.md               # This file
```

## ⌨️ Keybindings

### 🔍 **File Navigation**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ff` | Find Files | Fuzzy file finder |
| `<leader>fg` | Live Grep | Search text across project |
| `<leader>fb` | Find Buffers | Switch between open buffers |
| `<leader>fh` | Find Help | Search Neovim help |
| `<leader>e` | Toggle Explorer | Open/close file tree |

### 💻 **LSP & Code Navigation**
| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to Definition | Jump to symbol definition |
| `gD` | Go to Declaration | Jump to symbol declaration |
| `gi` | Go to Implementation | Jump to implementation |
| `gr` | Go to References | Find all references |
| `K` | Hover Documentation | Show documentation popup |
| `<C-k>` | Signature Help | Show function signature |
| `<space>rn` | Rename Symbol | Rename symbol under cursor |
| `<space>ca` | Code Actions | Show available code actions |
| `<space>f` | Format Code | Format current buffer |
| `<space>D` | Type Definition | Go to type definition |

### ✅ **Completion & Snippets**
| Key | Action | Description |
|-----|--------|-------------|
| `Tab` | Next Completion | Select next completion item |
| `Shift+Tab` | Previous Completion | Select previous completion item |
| `<C-Space>` | Trigger Completion | Manually trigger completion |
| `<C-e>` | Close Completion | Close completion menu |
| `Enter` | Accept Completion | Accept selected completion |
| `<C-f>` | Scroll Docs Down | Scroll completion documentation |
| `<C-b>` | Scroll Docs Up | Scroll completion documentation |

### 🐛 **Diagnostics & Errors**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>xx` | Toggle Trouble | Open/close error panel |
| `<leader>xw` | Workspace Diagnostics | Show all workspace errors |
| `<leader>xd` | Document Diagnostics | Show current file errors |
| `<leader>xq` | Quickfix List | Show quickfix errors |
| `<leader>xl` | Location List | Show location list |
| `<leader>l` | Toggle LSP Lines | Toggle inline diagnostics |

### 🦀 **Rust Specific**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>rr` | Rust Runnables | Show available Rust runnables |
| `<leader>rt` | Cargo Test | Run Rust tests |
| `<leader>rc` | Cargo Check | Check Rust code |
| `<leader>rb` | Cargo Build | Build Rust project |

### 🐹 **Go Specific**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>gr` | Go Run | Run Go program |
| `<leader>gt` | Go Test | Run Go tests |
| `<leader>gb` | Go Build | Build Go program |

### 🔧 **Git Integration**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>gs` | Git Status | Show git status |
| `<leader>gc` | Git Commit | Git commit interface |
| `<leader>gp` | Git Push | Push changes |
| `<leader>gl` | Git Log | Show git log |
| `]c` | Next Git Hunk | Jump to next change |
| `[c` | Previous Git Hunk | Jump to previous change |

## 🔧 Configuration Details

### 📝 **Completion Sources**
The completion system uses multiple sources prioritized as follows:
1. **LSP** - Language server completions (highest priority)
2. **Snippets** - Code snippets from LuaSnip
3. **Neovim Lua API** - For config development
4. **Buffer** - Text from current buffer
5. **Path** - File system paths

### 🎯 **LSP Servers**
Automatically installed and configured:
- **rust-analyzer** - Rust (via rustaceanvim)
- **gopls** - Go
- **ts_ls** - TypeScript/JavaScript
- **lua_ls** - Lua
- **pyright** - Python
- **jsonls** - JSON

### 🎨 **Completion Features**
- **Ghost text** - Preview completions as you type
- **Documentation** - Contextual help in completion popup
- **Icons** - Visual indicators for completion types
- **Smart filtering** - Context-aware completion suggestions
- **Snippet expansion** - Tab-expandable code templates

## 🛠️ Customization

### Adding New Languages
To add support for a new language:

1. **Add LSP server** to `lua/plugins/lsp.lua`:
   ```lua
   lspconfig.your_language_server.setup({
     on_attach = on_attach,
     capabilities = capabilities,
     -- language-specific settings
   })
   ```

2. **Add to Mason** ensure_installed list:
   ```lua
   ensure_installed = {
     'your_language_server',
     -- ... other servers
   }
   ```

### Modifying Keybindings
Edit `lua/config/keymaps.lua` to customize shortcuts:
```lua
vim.keymap.set('n', '<your_key>', '<your_action>', { desc = 'Your description' })
```

### Theme Customization
Modify `lua/plugins/theme.lua` to change colors or switch themes.

## 🚨 Troubleshooting

### Common Issues

**LSP server not starting:**
- Run `:Mason` to check server installation status
- Use `:LspInfo` to see active language servers
- Check `:LspLog` for error messages

**Completion not working:**
- Ensure LSP server is running (`:LspInfo`)
- Check if file type is recognized (`:set filetype?`)
- Verify completion sources (`:CmpStatus`)

**Keybindings not working:**
- Check for conflicts with `:map <key>`
- Ensure leader key is set (default is `<space>`)

**Performance issues:**
- Disable unnecessary LSP features in language server settings
- Reduce completion sources if too many active

### Getting Help
- `:help` - Neovim built-in help
- `:Lazy` - Plugin manager interface
- `:Mason` - LSP server manager
- `:checkhealth` - System health check

## 🙏 Credits

This configuration builds upon the excellent work of:
- [LazyVim](https://github.com/LazyVim/LazyVim) - Plugin management inspiration
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Completion engine
- [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) - Advanced Rust integration
- The entire Neovim community for their amazing plugins and contributions

---

**Happy coding!** 🎉
