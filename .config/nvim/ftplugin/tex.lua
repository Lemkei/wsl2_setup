-- BASIC LaTeX EDITOR SETTINGS
vim.opt_local.wrap = true       -- Enable line wrapping for LaTeX documents
vim.opt_local.spell = true      -- Enable spell checking
vim.opt_local.spelllang = "en_us" -- Set spell check language to US English

-- VIMTEX PLUGIN CONFIGURATION
vim.g.tex_flavor = 'latex'      -- Default to LaTeX when editing .tex files
vim.g.vimtex_version_check = 0  -- Disable version check to prevent warnings

vim.g.vimtex_view_general_viewer = 'wslview' -- PDF viewer command (WSL specific)
vim.g.vimtex_view_method = 'general'   -- Use general viewer method
vim.g.vimtex_quickfix_mode = 0         -- Disable quickfix window auto-opening
vim.g.vimtex_compiler_method = 'latexmk' -- Use latexmk for compilation

-- LaTeX KEYBOARD SHORTCUTS - SYMBOL PAIRS
vim.keymap.set('i', '$$', '$$<Left>', { buffer = true }) -- Insert math mode and place cursor inside
vim.keymap.set('i', '()', '()<Left>', { buffer = true }) -- Insert parentheses and place cursor inside
vim.keymap.set('i', '[]', '[]<Left>', { buffer = true }) -- Insert brackets and place cursor inside
vim.keymap.set('i', '{}', '{}<Left>', { buffer = true }) -- Insert braces and place cursor inside

-- VIMTEX COMMAND MAPPINGS
vim.keymap.set('n', '<leader>ll', '<plug>(vimtex-compile)', { buffer = true }) -- Compile document
vim.keymap.set('n', '<leader>lv', '<plug>(vimtex-view)', { buffer = true })    -- View PDF
vim.keymap.set('n', '<leader>lc', '<plug>(vimtex-clean)', { buffer = true })   -- Clean auxiliary files
vim.keymap.set('n', '<leader>lt', '<plug>(vimtex-toc-open)', { buffer = true }) -- Open table of contents
vim.keymap.set('n', '<leader>le', '<plug>(vimtex-errors)', { buffer = true })  -- Show compilation errors
vim.keymap.set('n', '<leader>lk', '<plug>(vimtex-stop)', { buffer = true })    -- Stop compilation
vim.keymap.set('n', '<leader>lK', '<plug>(vimtex-stop-all)', { buffer = true }) -- Stop all compilations

-- LATEX ABBREVIATIONS
vim.cmd([[

  iabbrev <buffer> eq \begin{equation}<CR><CR>\end{equation}<Up>
  iabbrev <buffer> align \begin{align}<CR><CR>\end{align}<Up>
  
  iabbrev <buffer> fr \frac{}{}<Left><Left><Left>
  iabbrev <buffer> sq \sqrt{}<Left>
  iabbrev <buffer> sum \sum_{i=1}^{n}<Space>
  iabbrev <buffer> int \int_{a}^{b}<Space>
  iabbrev <buffer> lim \lim_{x \to \infty}<Space>
  iabbrev <buffer> inf \infty
  
  iabbrev <buffer> al \alpha
  iabbrev <buffer> be \beta
  iabbrev <buffer> ga \gamma
  iabbrev <buffer> de \delta
  iabbrev <buffer> eps \epsilon
  iabbrev <buffer> th \theta
  iabbrev <buffer> la \lambda
  iabbrev <buffer> mu \mu
  iabbrev <buffer> pi \pi
  iabbrev <buffer> sg \sigma
  iabbrev <buffer> om \omega

  iabbrev <buffer> Ga \Gamma
  iabbrev <buffer> De \Delta
  iabbrev <buffer> Th \Theta
  iabbrev <buffer> La \Lambda
  iabbrev <buffer> Pi \Pi
  iabbrev <buffer> Sg \Sigma
  iabbrev <buffer> Om \Omega
  
  iabbrev <buffer> util \text{max}_{{c_t}} \sum_{t=0}^{\infty} \beta^t u(c_t)
  iabbrev <buffer> bc \sum_{t=0}^{\infty} p_t c_t \leq \sum_{t=0}^{\infty} p_t y_t
  iabbrev <buffer> foc \frac{\partial L}{\partial x} = 0
  iabbrev <buffer> exp \mathbb{E}[<Space>]<Left><Left>
  iabbrev <buffer> var \text{Var}(<Space>)
  iabbrev <buffer> prob \mathbb{P}(<Space>)
  iabbrev <buffer> corr \text{Corr}(<Space>,<Space>)
  iabbrev <buffer> ds \frac{d<Space>}{d<Space>}<Left><Left><Left><Left><Left><Left>
  iabbrev <buffer> pd \frac{\partial<Space>}{\partial<Space>}<Left><Left><Left><Left><Left><Left><Left><Left><Left>
  iabbrev <buffer> mbf \mathbf{}<Left>

]])

-- CONFIRMATION MESSAGE
vim.cmd('echom "LaTeX filetype settings loaded"') -- Verify settings are applied