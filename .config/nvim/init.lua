-- EDITOR APPEARANCE
vim.opt.number 		= true    -- Show line numbers on the left side
vim.opt.relativenumber 	= true    -- Show relative line numbers (easier for vertical movements)
vim.opt.termguicolors 	= true    -- Enable 24-bit RGB colors for better theme support

-- TEXT EDITING BEHAVIOR
vim.opt.tabstop = 4             -- Width of a tab character displayed as 4 spaces
vim.opt.shiftwidth = 4          -- Number of spaces for each indentation level
vim.opt.expandtab = true        -- Convert tabs to spaces when inserted
vim.opt.smartindent = true      -- Auto-indent new lines based on language syntax

-- INTERACTION SETTINGS
vim.opt.mouse = 'a'             -- Enable mouse support in all modes
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard for yanking/pasting

-- FILETYPE HANDLING
vim.cmd('filetype plugin indent on') -- Enable filetype detection, plugins, and indentation

-- KEY MAPPING CONFIGURATION
vim.g.mapleader = ' '           -- Set spacebar as the leader key for custom commands

-- WINDOW NAVIGATION SHORTCUTS
vim.keymap.set('n', '<C-h>', '<C-w>h') -- Move to left window with Ctrl+h
vim.keymap.set('n', '<C-j>', '<C-w>j') -- Move to window below with Ctrl+j
vim.keymap.set('n', '<C-k>', '<C-w>k') -- Move to window above with Ctrl+k
vim.keymap.set('n', '<C-l>', '<C-w>l') -- Move to right window with Ctrl+l
vim.keymap.set('n', '<leader>e', ':Explore<CR>') -- Open file explorer with <space>e

-- STATUS LINE CONFIGURATION
vim.opt.statusline = '%f %y %m %r %=%l,%c %P' -- Format: filename, filetype, modified flag, cursor position

-- PLUGIN MANAGEMENT - PACKER AUTO-INSTALLATION
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  -- Clone packer if not installed
  vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]] -- Load the newly installed plugin
end

-- PLUGIN DEFINITIONS
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'  -- Plugin manager manages itself
  use {'lervag/vimtex', tag = 'v2.15'} -- LaTeX plugin with version pinning
  use 'neovim/nvim-lspconfig'
  use 'davidhalter/jedi-vim'  
end)

-- TEMPLATE SYSTEM IN INIT.LUA
vim.cmd([[
  " Create template autocmd at global level
  augroup latex_template_global
    autocmd!
    autocmd BufNewFile *.tex 0read /home/lemkei/.config/nvim/templates/latex.template | normal! G
  augroup END
]])

-- SET CLIPBOARD PROVIDER
vim.g.clipboard = {
  name = 'win32yank',
  copy = {
    ['+'] = 'win32yank.exe -i --crlf',
    ['*'] = 'win32yank.exe -i --crlf',
  },
  paste = {
    ['+'] = 'win32yank.exe -o --lf',
    ['*'] = 'win32yank.exe -o --lf',
  },
  cache_enabled = 0,
}

-- R
if pcall(require, 'lspconfig') then
  require('lspconfig').r_language_server.setup{}
end