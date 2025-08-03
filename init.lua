-- ~/.config/nvim/init.lua
vim.g.mapleader = " "

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Disable swap files since we have auto-save
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Lazy plugin manager bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins from lua/plugins/ directory
require("lazy").setup("plugins")

-- Load additional configurations
require("config.keymaps")
require("config.autocmds")
