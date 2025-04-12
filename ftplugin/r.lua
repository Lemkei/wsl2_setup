-- BASIC R EDITOR SETTINGS
vim.opt_local.expandtab = true -- Use spaces instead of tabs
vim.opt_local.shiftwidth = 2 -- R standard is 2 spaces per indent
vim.opt_local.tabstop = 2 -- Display tabs as 2 spaces
vim.opt_local.commentstring = "# %s" -- Set comment style for R

-- R KEYBOARD SHORTCUTS
vim.keymap.set('n', '<leader>rr', ':!Rscript %<CR>', { buffer = true }) -- Run entire script
vim.keymap.set('v', '<leader>rr', ":'<,'>!R --slave -e 'source(\"stdin\")'<CR>", { buffer = true }) -- Run selection
vim.keymap.set('i', '<-', '<- ', { buffer = true }) -- Auto-space after assignment operator
vim.keymap.set('i', '()', '()<Left>', { buffer = true }) -- Insert parentheses and place cursor inside
vim.keymap.set('i', '[]', '[]<Left>', { buffer = true }) -- Insert brackets and place cursor inside

-- R CODE NAVIGATION
-- Enable tag-based navigation for R functions
vim.opt_local.iskeyword:append('.') -- Treat dots as part of words for R variables
vim.opt_local.iskeyword:append('_') -- Treat underscores as part of words

-- ENABLE BASIC COMPLETION
vim.opt_local.omnifunc = 'syntaxcomplete#Complete' -- Enable omni-completion
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', { buffer = true }) -- Trigger completion with Ctrl+Space

-- DEFINE COMMON R SNIPPETS
vim.cmd([[
iabbrev <buffer> fun function() {<CR>}<Up><End><Left><Left>
iabbrev <buffer> df data.frame()<Left>
iabbrev <buffer> gg ggplot() + <Left><Left><Left>
iabbrev <buffer> lib library()<Left>
iabbrev <buffer> req require()<Left>
iabbrev <buffer> imp import()<Left>
iabbrev <buffer> head head(, 10)<Left><Left><Left><Left>
]])

-- CONFIRMATION MESSAGE
vim.cmd('echom "R filetype settings loaded"') -- Verify settings are applied
