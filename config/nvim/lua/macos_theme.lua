local M = {}

function M.apply(name)
  local light = name == "ivory"
  local p = light and {
    bg = "#FAF7F0", panel = "#F0EDE6", fg = "#292A2D", muted = "#706D67",
    line = "#EDE9E0", border = "#CBC6BB", blue = "#005EC4", purple = "#8044A0",
    green = "#317147", red = "#B5313B", orange = "#945615", cyan = "#216B7A",
    selection = "#CCDFF5", search = "#F1D593", add = "#E0EDDF", delete = "#F6DEDC",
  } or {
    bg = "#242426", panel = "#1D1D1F", fg = "#E8E8ED", muted = "#A0A0A8",
    line = "#303034", border = "#4B4B52", blue = "#78B7FF", purple = "#D3A0E8",
    green = "#99CCA0", red = "#FF9299", orange = "#E8B780", cyan = "#8ACDD4",
    selection = "#354E70", search = "#66502D", add = "#293F32", delete = "#4B2E33",
  }
  vim.opt.background = light and "light" or "dark"
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
  vim.g.colors_name = name
  local function hi(group, fg, bg, extra)
    vim.api.nvim_set_hl(0, group, vim.tbl_extend("force", { fg = fg, bg = bg }, extra or {}))
  end
  local function link(group, target) vim.api.nvim_set_hl(0, group, { link = target }) end
  hi("Normal", p.fg, p.bg)
  hi("NormalNC", p.fg, p.bg)
  hi("NormalFloat", p.fg, p.panel)
  hi("FloatBorder", p.border, p.panel)
  hi("FloatTitle", p.blue, p.panel, { bold = true })
  hi("SignColumn", p.muted, p.bg)
  hi("LineNr", p.muted, p.bg)
  hi("CursorLineNr", p.blue, p.line, { bold = true })
  hi("CursorLine", nil, p.line)
  hi("CursorColumn", nil, p.line)
  hi("ColorColumn", nil, p.line)
  hi("Visual", nil, p.selection)
  hi("Search", p.fg, p.search)
  hi("IncSearch", p.panel, p.orange, { bold = true })
  link("CurSearch", "IncSearch")
  hi("MatchParen", p.blue, p.selection, { bold = true })
  hi("Comment", p.muted, nil, { italic = true })
  for group, color in pairs({
    Constant = p.orange, String = p.green, Character = p.green, Number = p.orange,
    Boolean = p.orange, Float = p.orange, Identifier = p.fg, Function = p.blue,
    Statement = p.purple, Keyword = p.purple, Operator = p.cyan, PreProc = p.purple,
    Type = p.cyan, Special = p.orange, Delimiter = p.muted, Title = p.blue,
    Directory = p.blue, ErrorMsg = p.red, WarningMsg = p.orange,
    DiagnosticError = p.red, DiagnosticWarn = p.orange, DiagnosticInfo = p.blue,
    DiagnosticHint = p.cyan, Added = p.green, Removed = p.red, Changed = p.blue,
  }) do hi(group, color) end
  hi("Todo", p.orange, nil, { bold = true })
  hi("NonText", p.border)
  hi("IblIndent", p.border)
  hi("IblScope", p.blue)
  link("Whitespace", "NonText")
  link("EndOfBuffer", "NonText")
  hi("WinSeparator", p.border, p.bg)
  hi("StatusLine", p.fg, p.panel, { bold = true })
  hi("StatusLineNC", p.muted, p.panel)
  hi("TabLine", p.muted, p.panel)
  hi("TabLineFill", nil, p.panel)
  hi("TabLineSel", p.blue, p.bg, { bold = true })
  hi("Pmenu", p.fg, p.panel)
  hi("PmenuSel", p.fg, p.selection, { bold = true })
  hi("PmenuSbar", nil, p.line)
  hi("PmenuThumb", nil, p.border)
  hi("Folded", p.muted, p.panel)
  link("FoldColumn", "SignColumn")
  hi("DiffAdd", nil, p.add)
  hi("DiffDelete", p.red, p.delete)
  hi("DiffChange", nil, p.line)
  hi("DiffText", nil, p.selection)
  for _, kind in ipairs({ "Error", "Warn", "Info", "Hint" }) do
    local color = ({ Error = p.red, Warn = p.orange, Info = p.blue, Hint = p.cyan })[kind]
    hi("DiagnosticUnderline" .. kind, nil, nil, { undercurl = true, sp = color })
  end
  for group, target in pairs({
    ["@variable"] = "Identifier", ["@variable.builtin"] = "Special",
    ["@property"] = "Identifier", ["@function"] = "Function",
    ["@function.builtin"] = "Function", ["@constructor"] = "Type",
    ["@keyword"] = "Keyword", ["@type"] = "Type", ["@string"] = "String",
    ["@comment"] = "Comment", ["@markup.heading"] = "Title",
    ["@markup.link"] = "Underlined", ["@tag"] = "Keyword",
    NeoTreeNormal = "NormalFloat", NeoTreeNormalNC = "NormalFloat",
    NeoTreeEndOfBuffer = "NormalFloat", NeoTreeDirectoryName = "Directory",
    NeoTreeDirectoryIcon = "Directory", NeoTreeRootName = "Title",
    NeoTreeGitAdded = "Added", NeoTreeGitModified = "Changed", NeoTreeGitDeleted = "Removed",
    TelescopeNormal = "NormalFloat", TelescopeBorder = "FloatBorder",
    TelescopeTitle = "FloatTitle", TelescopeSelection = "PmenuSel",
    TelescopeMatching = "Function", AerialNormal = "NormalFloat",
  }) do link(group, target) end
  hi("Underlined", p.blue, nil, { underline = true })
  vim.g.terminal_color_0 = p.panel
  local ansi = { p.red, p.green, p.orange, p.blue, p.purple, p.cyan, p.fg }
  for i, color in ipairs(ansi) do
    vim.g["terminal_color_" .. i] = color
    vim.g["terminal_color_" .. (i + 8)] = color
  end
  vim.g.terminal_color_8 = p.muted
end

return M
