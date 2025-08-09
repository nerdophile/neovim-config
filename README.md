# 🚀 Advanced Neovim Configuration

A modern, feature-rich Neovim configuration combining the best of [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) with specialized tooling for Go and Rust development.

## ✨ Features

- 🎨 **OneDark Pro Theme** - Beautiful, modern colorscheme
- 🔍 **Telescope** - Fuzzy finder for files, text, and more
- 🌳 **File Explorer** - nvim-tree with intuitive navigation
- 🧠 **LSP Support** - Full Language Server Protocol integration with Mason
- 🔧 **Auto-completion** - Intelligent code completion with snippets
- 🎯 **Error Lens** - Inline diagnostics and error visualization
- 🔄 **Git Integration** - GitSigns and Fugitive for version control
- 🦀 **Rust Support** - Complete Rust development environment
- 🐹 **Go Support** - Full Go development toolchain
- 📋 **Which-Key** - Interactive keymap discovery
- 🎛️ **Dashboard** - Beautiful start screen
- 🔀 **Auto-formatting** - Format on save with conform.nvim
- 💾 **Auto-save** - Automatic file saving
- 📦 **Mason Integration** - Automatic LSP and tool installation

## 📁 File Structure

```
~/.config/nvim/
├── init.lua                    # Main configuration entry point
├── lua/
│   ├── config/
│   │   ├── keymaps.lua        # All keybindings
│   │   └── autocmds.lua       # Auto-save & other autocmds
│   └── plugins/
│       ├── theme.lua          # OneDark Pro theme
│       ├── editor.lua         # File explorer, telescope, treesitter, LSP, completion
│       ├── lsp.lua            # LSP configuration with Mason
│       ├── diagnostics.lua    # Error Lens (trouble, lsp_lines)
│       ├── git.lua            # GitLens (gitsigns, fugitive)
│       ├── languages.lua      # Rust & Go specific tools
│       ├── ui.lua             # UI enhancements (which-key, bufferline, etc.)
│       └── utils.lua          # Utility plugins (comment, autopairs, etc.)
```

## 🛠️ Prerequisites

### Required Dependencies

```bash
# Basic tools
git make unzip gcc

# Search tools
ripgrep fd-find

# Clipboard (Linux)
xclip  # or xsel

# Language servers will be auto-installed via Mason
# But you need the languages themselves:
go      # For Go development
rustc   # For Rust development
node    # For TypeScript/JavaScript
```

### Optional

- **Nerd Font** - For icons and glyphs (set `vim.g.have_nerd_font = true` in init.lua)
- **Emoji fonts** (Ubuntu): `sudo apt install fonts-noto-color-emoji`

## 🚀 Installation

1. **Backup existing config** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   mv ~/.local/share/nvim ~/.local/share/nvim.backup
   ```

2. **Clone this repository**:
   ```bash
   git clone https://github.com/nerdophile/neovim-config.git ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```

4. **Let Lazy.nvim install plugins** - This happens automatically on first launch

5. **Run health check**:
   ```
   :checkhealth
   ```

## ⌨️ Key Mappings

### Leader Key
- **Leader**: `<Space>`

### 🔍 Search & Navigation

| Key | Description |
|-----|-------------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search text) |
| `<leader>sf` | Search files |
| `<leader>sg` | Search by grep |
| `<leader>sh` | Search help tags |
| `<leader>sk` | Search keymaps |
| `<leader>sw` | Search current word |
| `<leader>sd` | Search diagnostics |
| `<leader>sr` | Search resume |
| `<leader>s.` | Search recent files |
| `<leader>sn` | Search Neovim config files |
| `<leader>s/` | Search in open files |
| `<leader>/` | Fuzzy search in current buffer |
| `<leader><leader>` | Find existing buffers |

### 📁 File Management

| Key | Description |
|-----|-------------|
| `<leader>e` | Toggle file explorer |
| `<leader>w` | Write (save) file |
| `<leader>q` | Quit |

### 🪟 Window Navigation

| Key | Description |
|-----|-------------|
| `<C-h>` | Move to left window |
| `<C-l>` | Move to right window |
| `<C-j>` | Move to lower window |
| `<C-k>` | Move to upper window |

### 📋 Buffer Management

| Key | Description |
|-----|-------------|
| `<S-h>` | Previous buffer |
| `<S-l>` | Next buffer |
| `<leader>bp` | Buffer pick |
| `<leader>bc` | Buffer close pick |

### 🩺 Diagnostics & Errors

| Key | Description |
|-----|-------------|
| `<leader>xx` | Toggle trouble (diagnostics) |
| `<leader>xX` | Buffer diagnostics |
| `<leader>xL` | Location list |
| `<leader>xQ` | Quickfix list |
| `<leader>l` | Toggle LSP lines (inline diagnostics) |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>e` | Show diagnostic error messages |

### 🧠 LSP (Language Server)

| Key | Description |
|-----|-------------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `gD` | Go to declaration |
| `<leader>D` | Type definition |
| `<leader>ds` | Document symbols |
| `<leader>ws` | Workspace symbols |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `K` | Hover documentation |
| `<leader>f` | Format buffer |
| `<leader>th` | Toggle inlay hints |

### 🌿 Git Operations

| Key | Description |
|-----|-------------|
| `<leader>gs` | Git status |
| `<leader>gc` | Git commit |
| `<leader>gp` | Git push |
| `<leader>gl` | Git log |
| `<leader>hs` | Stage git hunk |
| `<leader>hr` | Reset git hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hR` | Reset buffer |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hd` | Diff against index |
| `<leader>hD` | Diff against last commit |
| `<leader>tb` | Toggle git blame line |
| `<leader>tD` | Toggle git show deleted |
| `]c` | Next git change |
| `[c` | Previous git change |

### 🐹 Go Development

| Key | Description |
|-----|-------------|
| `<leader>gr` | Go run |
| `<leader>gt` | Go test |
| `<leader>gb` | Go build |
| `<leader>gi` | Go install |
| `<leader>gf` | Go format |
| `<leader>gd` | Go documentation |

### 🦀 Rust Development

| Key | Description |
|-----|-------------|
| `<leader>rr` | Rust runnables |
| `<leader>rt` | Rust testables |
| `<leader>rd` | Rust debuggables |
| `<leader>rc` | Open Cargo.toml |

### 💻 Terminal

| Key | Description |
|-----|-------------|
| `<C-\>` | Toggle floating terminal |
| `<leader>tf` | Toggle floating terminal |
| `<leader>th` | Toggle horizontal terminal |
| `<leader>tv` | Toggle vertical terminal |
| `<Esc><Esc>` | Exit terminal mode |

### ✏️ Editing

| Key | Description |
|-----|-------------|
| `gc` | Comment/uncomment (visual or line) |
| `<Esc>` | Clear search highlight |

### 🎯 Text Objects & Surround (Mini.nvim)

| Key | Description |
|-----|-------------|
| `saiw)` | Surround add inner word with parentheses |
| `sd'` | Surround delete quotes |
| `sr)'` | Surround replace ) with ' |
| `va)` | Visually select around parentheses |
| `ci'` | Change inside quotes |

## 🔌 Plugins

### Core Plugins

| Plugin | Purpose |
|--------|---------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keymap hints |

### Theme & UI

| Plugin | Purpose |
|--------|---------|
| [onedarkpro.nvim](https://github.com/olimorris/onedarkpro.nvim) | OneDark Pro colorscheme |
| [mini.nvim](https://github.com/echasnovski/mini.nvim) | Statusline, text objects, surround |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Buffer tabs |
| [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim) | Start screen |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides |

### LSP & Development

| Plugin | Purpose |
|--------|---------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configuration |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP/tool installer |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Code formatting |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting |

### Diagnostics & Errors

| Plugin | Purpose |
|--------|---------|
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics list |
| [lsp_lines.nvim](https://git.sr.ht/~whynothugo/lsp_lines.nvim) | Inline diagnostics |

### Git Integration

| Plugin | Purpose |
|--------|---------|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git decorations |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git commands |

### Language-Specific

| Plugin | Purpose |
|--------|---------|
| [go.nvim](https://github.com/ray-x/go.nvim) | Go development tools |
| [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) | Rust development tools |

### Utilities

| Plugin | Purpose |
|--------|---------|
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Commenting |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlight TODOs |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto bracket pairing |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Terminal integration |
| [vim-sleuth](https://github.com/tpope/vim-sleuth) | Auto-detect indentation |

## 🎛️ Configuration

### Vim Options

- **Line numbers**: Enabled with relative numbers
- **Mouse support**: Enabled
- **Clipboard**: Synced with system clipboard
- **Smart case search**: Case-insensitive unless uppercase used
- **Auto-save**: Files automatically saved on insert leave
- **Undo history**: Persistent across sessions
- **Split behavior**: New splits open right and below
- **Scrolloff**: 10 lines above/below cursor
- **Update time**: 250ms for faster feedback

### Language Servers

The following language servers are automatically installed and configured:

- **Go**: `gopls`
- **Rust**: `rust_analyzer`
- **TypeScript/JavaScript**: `ts_ls`
- **Lua**: `lua_ls`

### Auto-formatting

Format-on-save is enabled for:
- **Lua**: stylua
- **Go**: gofmt + goimports
- **Rust**: rustfmt

## 🚦 Getting Started

### First Launch

1. Open Neovim: `nvim`
2. Lazy.nvim will automatically install all plugins
3. Wait for installation to complete
4. Restart Neovim
5. Run `:checkhealth` to verify everything is working

### Dashboard

The dashboard appears on startup with quick actions:
- **f**: Find files
- **n**: New file
- **r**: Recent files
- **g**: Find text
- **c**: Open config
- **q**: Quit

### Quick Start Workflow

1. **Open project**: `nvim .` or use dashboard
2. **Find files**: `<leader>ff`
3. **Search text**: `<leader>fg`
4. **Toggle explorer**: `<leader>e`
5. **View errors**: `<leader>xx`
6. **Git status**: `<leader>gs`

## 🔧 Customization

### Adding New Plugins

Add plugins to the appropriate file in `lua/plugins/`:

```lua
-- In lua/plugins/editor.lua (for example)
return {
  -- Your existing plugins...
  
  -- New plugin
  {
    'author/plugin-name',
    config = function()
      require('plugin-name').setup({
        -- configuration
      })
    end,
  },
}
```

### Modifying Keymaps

Edit `lua/config/keymaps.lua` to add or modify keybindings:

```lua
vim.keymap.set('n', '<leader>my', ':MyCommand<CR>', { desc = 'My custom command' })
```

### Changing Theme

Edit `lua/plugins/theme.lua` to use a different colorscheme:

```lua
return {
  {
    'new-theme/colorscheme',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'new-theme'
    end,
  },
}
```

## 🐛 Troubleshooting

### Common Issues

1. **Plugins not loading**: Run `:Lazy sync` to update plugins
2. **LSP not working**: Run `:Mason` to check language server installation
3. **Treesitter errors**: Run `:TSUpdate` to update parsers
4. **Formatting not working**: Check `:ConformInfo` for formatter status

### Health Checks

```vim
:checkhealth                 " Overall health
:checkhealth telescope       " Telescope-specific
:checkhealth nvim-treesitter " Treesitter-specific
:checkhealth mason           " Mason-specific
```

### Useful Commands

```vim
:Lazy                        " Plugin manager
:Mason                       " LSP/tool installer  
:Telescope                   " Fuzzy finder
:Trouble                     " Diagnostics
:Git                         " Git commands
:GoRun                       " Run Go code
:RustLsp runnables          " Rust runnables
```

## 🎨 Theme Customization

The OneDark Pro theme can be customized in `lua/plugins/theme.lua`. Available variants:
- `onedark` (default)
- `onelight`
- `onedark_vivid`
- `onedark_dark`

## 📚 Learning Resources

- **Neovim Documentation**: `:help` or `:Telescope help_tags`
- **Plugin Documentation**: Visit individual plugin repositories
- **Lua Guide**: `:help lua-guide`
- **LSP Guide**: `:help lsp`
- **Treesitter Guide**: `:help treesitter`

## 🤝 Contributing

Feel free to fork this repository and customize it for your needs. If you have improvements or bug fixes, pull requests are welcome!

## 📄 License

This configuration is based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and is provided as-is for educational and personal use.

---

**Happy Coding!** 🚀

> Press `<leader>sk` in Neovim to search through all available keymaps interactively!
