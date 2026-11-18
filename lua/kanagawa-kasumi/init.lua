local M = {}

M.palette = {
  sumiInk = "#1A2026",
  sumiInk2 = "#20272E",
  fujiWhite = "#D9D1BA",
  fujiGray = "#9E9783",
  outline = "#313C47",
  kasumi = "#D9A78B",
  blue = "#7794A6",
  green = "#8BA37A",
  red = "#D96C6C",
  magenta = "#B87A8E",
  cyan = "#77A3A0",
  brightRed = "#E67E7E",
  brightGreen = "#9FBA8C",
  brightYellow = "#F2BEA0",
  brightBlue = "#8AB2C9",
  brightWhite = "#EBE4CC",
}

M.config = {
  transparent = false,
  terminalColors = true,
  overrides = {},
}

local function highlights()
  local p = M.palette
  local bg = M.config.transparent and "none" or p.sumiInk
  local bg_alt = M.config.transparent and "none" or p.sumiInk2

  return {
    -- UI
    Normal = { fg = p.fujiWhite, bg = bg },
    NormalFloat = { fg = p.fujiWhite, bg = bg_alt },
    NormalNC = { fg = p.fujiWhite, bg = bg },
    Cursor = { fg = p.sumiInk, bg = p.fujiWhite },
    CursorLine = { bg = bg_alt },
    CursorColumn = { bg = bg_alt },
    CursorLineNr = { fg = p.kasumi, bg = bg_alt, bold = true },
    LineNr = { fg = p.fujiGray, bg = bg },
    SignColumn = { bg = bg },
    ColorColumn = { bg = bg_alt },
    Folded = { fg = p.blue, bg = bg_alt },
    FoldColumn = { fg = p.blue, bg = bg },
    WinSeparator = { fg = p.outline, bg = bg },
    VertSplit = { fg = p.outline, bg = bg },
    StatusLine = { fg = p.fujiWhite, bg = bg_alt },
    StatusLineNC = { fg = p.fujiGray, bg = bg_alt },
    TabLine = { fg = p.fujiGray, bg = bg_alt },
    TabLineFill = { fg = bg, bg = bg_alt },
    TabLineSel = { fg = p.sumiInk, bg = p.kasumi, bold = true },
    Visual = { fg = p.sumiInk, bg = p.fujiWhite },
    Search = { fg = p.sumiInk, bg = p.kasumi },
    IncSearch = { fg = p.sumiInk, bg = p.brightYellow, bold = true },
    CurSearch = { fg = p.sumiInk, bg = p.brightYellow, bold = true },
    MatchParen = { fg = p.kasumi, bg = bg_alt, bold = true },
    Pmenu = { fg = p.fujiWhite, bg = bg_alt },
    PmenuSel = { fg = p.sumiInk, bg = p.kasumi, bold = true },
    PmenuSbar = { bg = p.outline },
    PmenuThumb = { bg = p.fujiGray },
    WildMenu = { fg = p.sumiInk, bg = p.kasumi },
    Directory = { fg = p.blue, bg = bg, bold = true },
    Title = { fg = p.kasumi, bg = bg, bold = true },
    Question = { fg = p.green, bg = bg },
    MoreMsg = { fg = p.green, bg = bg },
    WarningMsg = { fg = p.brightYellow, bg = bg },
    ErrorMsg = { fg = p.red, bg = bg, bold = true },
    ModeMsg = { fg = p.kasumi, bg = bg, bold = true },
    NonText = { fg = p.outline, bg = bg },
    SpecialKey = { fg = p.outline, bg = bg },
    Whitespace = { fg = p.outline, bg = bg },
    Conceal = { fg = p.fujiGray, bg = bg },

    -- Syntax
    Comment = { fg = p.blue, italic = true },
    Constant = { fg = p.kasumi },
    String = { fg = p.green },
    Character = { fg = p.green },
    Number = { fg = p.kasumi },
    Boolean = { fg = p.kasumi, bold = true },
    Identifier = { fg = p.blue },
    Function = { fg = p.brightBlue },
    Statement = { fg = p.magenta },
    Conditional = { fg = p.magenta },
    Repeat = { fg = p.magenta },
    Operator = { fg = p.cyan },
    Keyword = { fg = p.magenta },
    Exception = { fg = p.red },
    PreProc = { fg = p.kasumi },
    Include = { fg = p.kasumi },
    Define = { fg = p.kasumi },
    Type = { fg = p.green },
    Structure = { fg = p.green },
    StorageClass = { fg = p.green },
    Special = { fg = p.cyan },
    Delimiter = { fg = p.fujiGray },
    Todo = { fg = p.sumiInk, bg = p.brightYellow, bold = true },
    Underlined = { fg = p.blue, underline = true },

    -- Diagnostics, version control, and spelling
    DiagnosticError = { fg = p.red },
    DiagnosticWarn = { fg = p.brightYellow },
    DiagnosticInfo = { fg = p.blue },
    DiagnosticHint = { fg = p.green },
    DiagnosticUnderlineError = { undercurl = true, sp = p.red },
    DiagnosticUnderlineWarn = { undercurl = true, sp = p.brightYellow },
    DiffAdd = { fg = p.green, bg = bg_alt },
    DiffChange = { fg = p.blue, bg = bg_alt },
    DiffDelete = { fg = p.red, bg = bg_alt },
    DiffText = { fg = p.kasumi, bg = bg_alt, bold = true },
    SpellBad = { undercurl = true, sp = p.red },
    SpellCap = { undercurl = true, sp = p.blue },
    SpellLocal = { undercurl = true, sp = p.green },
    SpellRare = { undercurl = true, sp = p.magenta },
  }
end

local function set_terminal_colors()
  local p = M.palette
  local terminal = {
    p.sumiInk2, p.red, p.green, p.kasumi, p.blue, p.magenta, p.cyan, p.fujiWhite,
    p.outline, p.brightRed, p.brightGreen, p.brightYellow, p.brightBlue, p.magenta,
    p.cyan, p.brightWhite,
  }

  for index, color in ipairs(terminal) do
    vim.g["terminal_color_" .. index - 1] = color
  end
end

function M.setup(config)
  M.config = vim.tbl_deep_extend("force", M.config, config or {})
end

function M.load()
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end

  vim.o.background = "dark"
  vim.o.termguicolors = true
  vim.g.colors_name = "kanagawa-kasumi"

  for group, spec in pairs(highlights()) do
    vim.api.nvim_set_hl(0, group, spec)
  end

  for group, spec in pairs(M.config.overrides) do
    vim.api.nvim_set_hl(0, group, spec)
  end

  if M.config.terminalColors then
    set_terminal_colors()
  end
end

return M
