-- Python settings
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4

-- Run script with <leader>pr
vim.keymap.set('n', '<leader>pr', ':!python %<CR>', { buffer = true })

-- Basic Python snippets
vim.cmd([[
iabbrev <buffer> def def():<CR><Tab>pass<Up><End><Left><Left>
iabbrev <buffer> ifm if __name__ == "__main__":<CR><Tab>
]])