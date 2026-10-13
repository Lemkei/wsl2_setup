-- Frieren Steel Blue — matches WezTerm theme
vim.cmd('highlight clear')
vim.g.colors_name = 'frieren'

local c = {
  bg       = '#253040',
  bg_dark  = '#1E2838',
  bg_light = '#2A3548',
  fg       = '#CDD6F4',
  fg_dim   = '#BAC2DE',
  fg_dark  = '#7A88A7',
  steel    = '#3B4560',
  steel_l  = '#3B4D6B',
  pink     = '#CF7B98',
  pink_b   = '#DE90AB',
  rose     = '#BC4F68',
  rose_b   = '#E16C87',
  green    = '#A6E3A1',
  green_b  = '#BCDD61',
  teal     = '#6EBFC0',
  teal_b   = '#87E9EA',
  blue     = '#7A9DD6',
  blue_b   = '#A3C0F7',
  sky      = '#89B4FA',
  lavender = '#B7C9EF',
  select   = '#3B4560',
  none     = 'NONE',
}

local hi = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Editor
hi('Normal',       { fg = c.fg, bg = c.bg })
hi('NormalFloat',  { fg = c.fg, bg = c.bg_dark })
hi('FloatBorder',  { fg = c.steel_l, bg = c.bg_dark })
hi('Cursor',       { fg = c.bg, bg = c.fg })
hi('CursorLine',   { bg = c.bg_light })
hi('CursorLineNr', { fg = c.sky, bold = true })
hi('LineNr',       { fg = c.steel })
hi('SignColumn',   { bg = c.bg })
hi('ColorColumn',  { bg = c.bg_light })
hi('Visual',       { bg = c.select })
hi('Search',       { fg = c.bg, bg = c.teal })
hi('IncSearch',    { fg = c.bg, bg = c.pink })
hi('MatchParen',   { fg = c.teal_b, bold = true, underline = true })

-- Statusline
hi('StatusLine',   { fg = c.fg, bg = c.bg_dark })
hi('StatusLineNC', { fg = c.fg_dark, bg = c.bg_dark })

-- Pmenu
hi('Pmenu',        { fg = c.fg, bg = c.bg_dark })
hi('PmenuSel',     { fg = c.bg, bg = c.blue })
hi('PmenuSbar',    { bg = c.steel })
hi('PmenuThumb',   { bg = c.blue })

-- Splits / tabs
hi('VertSplit',    { fg = c.steel })
hi('WinSeparator', { fg = c.steel })
hi('TabLine',      { fg = c.fg_dark, bg = c.bg_dark })
hi('TabLineFill',  { bg = c.bg_dark })
hi('TabLineSel',   { fg = c.fg, bg = c.blue, bold = true })

-- Diff
hi('DiffAdd',    { bg = '#1E3A2A' })
hi('DiffChange', { bg = '#2A2E3E' })
hi('DiffDelete', { fg = c.rose, bg = '#2E1E28' })
hi('DiffText',   { bg = '#3A3E5E' })

-- Diagnostics
hi('DiagnosticError', { fg = c.rose })
hi('DiagnosticWarn',  { fg = c.teal })
hi('DiagnosticInfo',  { fg = c.blue })
hi('DiagnosticHint',  { fg = c.lavender })

-- Syntax
hi('Comment',     { fg = c.fg_dark, italic = true })
hi('Constant',    { fg = c.teal })
hi('String',      { fg = c.green })
hi('Character',   { fg = c.green })
hi('Number',      { fg = c.teal_b })
hi('Boolean',     { fg = c.teal })
hi('Float',       { fg = c.teal_b })
hi('Identifier',  { fg = c.fg })
hi('Function',    { fg = c.blue, bold = true })
hi('Statement',   { fg = c.pink })
hi('Conditional', { fg = c.pink })
hi('Repeat',      { fg = c.pink })
hi('Label',       { fg = c.pink })
hi('Operator',    { fg = c.fg_dim })
hi('Keyword',     { fg = c.pink, italic = true })
hi('Exception',   { fg = c.rose })
hi('PreProc',     { fg = c.sky })
hi('Include',     { fg = c.sky })
hi('Define',      { fg = c.sky })
hi('Macro',       { fg = c.sky })
hi('Type',        { fg = c.blue_b })
hi('StorageClass', { fg = c.pink })
hi('Structure',   { fg = c.blue_b })
hi('Typedef',     { fg = c.blue_b })
hi('Special',     { fg = c.lavender })
hi('SpecialChar', { fg = c.teal })
hi('Tag',         { fg = c.pink })
hi('Delimiter',   { fg = c.fg_dim })
hi('Debug',       { fg = c.rose })
hi('Underlined',  { underline = true })
hi('Error',       { fg = c.rose, bold = true })
hi('Todo',        { fg = c.teal_b, bold = true })

-- Telescope
hi('TelescopeNormal',       { fg = c.fg, bg = c.bg_dark })
hi('TelescopeBorder',       { fg = c.steel_l, bg = c.bg_dark })
hi('TelescopePromptNormal', { fg = c.fg, bg = c.bg_light })
hi('TelescopePromptBorder', { fg = c.bg_light, bg = c.bg_light })
hi('TelescopePromptTitle',  { fg = c.bg, bg = c.pink })
hi('TelescopeResultsTitle', { fg = c.bg, bg = c.blue })
hi('TelescopePreviewTitle', { fg = c.bg, bg = c.green })
hi('TelescopeSelection',    { bg = c.steel })
hi('TelescopeMatching',     { fg = c.teal_b, bold = true })

-- Netrw
hi('Directory',  { fg = c.blue, bold = true })
hi('Title',      { fg = c.pink, bold = true })

-- Folding
hi('Folded',     { fg = c.fg_dark, bg = c.bg_light })
hi('FoldColumn', { fg = c.steel, bg = c.bg })
