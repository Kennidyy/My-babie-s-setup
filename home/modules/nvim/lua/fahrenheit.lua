local fahrenheit = {}

fahrenheit.colors = {
	bg = "#000000",
	fg = "#ffffce",
	cursor_bg = "#bbbbbb",
	cursor_fg = "#ffffff",
	sel_bg = "#4e739f",
	sel_fg = "#ffffce",
	black = "#1d1d1d",
	red = "#cda074",
	green = "#9e744d",
	yellow = "#fecf75",
	blue = "#720102",
	magenta = "#734c4d",
	cyan = "#979797",
	white = "#ffffce",
	bright_black = "#000000",
	bright_red = "#fecea0",
	bright_green = "#cc734d",
	bright_yellow = "#fd9f4d",
	bright_blue = "#cb4a05",
	bright_magenta = "#4e739f",
	bright_cyan = "#fed04d",
	bright_white = "#ffffff",
}

function fahrenheit.setup()
	vim.o.termguicolors = true

	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end
	vim.g.colors_name = "fahrenheit"

	local c = fahrenheit.colors
	local set_hl = vim.api.nvim_set_hl

	set_hl(0, "Normal", { bg = c.bg, fg = c.fg })
	set_hl(0, "NormalFloat", { bg = c.bg, fg = c.fg })
	set_hl(0, "SnacksExplorerNormal", { bg = c.bg })
	set_hl(0, "SnacksExplorerBorder", { bg = c.bg })
	set_hl(0, "Cursor", { bg = c.cursor_bg, fg = c.cursor_fg })
	set_hl(0, "Visual", { bg = c.magenta, fg = c.fg })
	set_hl(0, "Search", { bg = c.bright_yellow, fg = c.black })
	set_hl(0, "IncSearch", { bg = c.yellow, fg = c.black })
	set_hl(0, "LineNr", { fg = c.cyan })
	set_hl(0, "CursorLineNr", { fg = c.bright_yellow, bold = true })
	set_hl(0, "SignColumn", { bg = c.bg })
	set_hl(0, "VertSplit", { fg = c.cyan, bg = c.bg })
	set_hl(0, "Pmenu", { bg = c.black, fg = c.fg })
	set_hl(0, "PmenuSel", { bg = c.sel_bg, fg = c.sel_fg })
	set_hl(0, "StatusLine", { bg = c.black, fg = c.fg })
	set_hl(0, "StatusLineNC", { bg = c.black, fg = c.cyan })
	set_hl(0, "TabLine", { bg = c.black, fg = c.cyan })
	set_hl(0, "TabLineSel", { bg = c.bg, fg = c.bright_yellow })
	set_hl(0, "TabLineFill", { bg = c.black })

	set_hl(0, "Comment", { fg = c.cyan, italic = true })
	set_hl(0, "String", { fg = c.yellow })
	set_hl(0, "Identifier", { fg = c.red })
	set_hl(0, "Function", { fg = c.bright_red })
	set_hl(0, "Keyword", { fg = c.blue })
	set_hl(0, "Statement", { fg = c.blue })
	set_hl(0, "Constant", { fg = c.bright_cyan })
	set_hl(0, "Number", { fg = c.bright_cyan })
	set_hl(0, "PreProc", { fg = c.magenta })
	set_hl(0, "Type", { fg = c.green })
	set_hl(0, "Special", { fg = c.bright_blue })
	set_hl(0, "Underlined", { fg = c.bright_cyan, underline = true })
	set_hl(0, "Error", { bg = c.blue, fg = c.bright_white })
	set_hl(0, "Todo", { bg = c.bright_yellow, fg = c.black })
	set_hl(0, "Directory", { fg = c.red })
	set_hl(0, "SnacksExplorerDirectory", { fg = c.red })

	set_hl(0, "@variable", { fg = c.red })
	set_hl(0, "@function", { fg = c.bright_red })
	set_hl(0, "@keyword", { fg = c.blue })
	set_hl(0, "@string", { fg = c.yellow })
	set_hl(0, "@number", { fg = c.bright_cyan })
	set_hl(0, "@type", { fg = c.green })
	set_hl(0, "@comment", { fg = c.cyan, italic = true })

	set_hl(0, "DiagnosticError", { fg = c.blue })
	set_hl(0, "DiagnosticWarn", { fg = c.bright_yellow })
	set_hl(0, "DiagnosticInfo", { fg = c.bright_cyan })
	set_hl(0, "DiagnosticHint", { fg = c.cyan })

	set_hl(0, "lualine_a_normal", { bg = c.black, fg = c.fg })
	set_hl(0, "lualine_b_normal", { bg = c.black, fg = c.fg })
	set_hl(0, "lualine_c_normal", { bg = c.bg, fg = c.fg })
	set_hl(0, "lualine_x_normal", { bg = c.bg, fg = c.cyan })
	set_hl(0, "lualine_y_normal", { bg = c.black, fg = c.fg })
	set_hl(0, "lualine_z_normal", { bg = c.black, fg = c.fg })
	set_hl(0, "lualine_a_insert", { bg = c.green, fg = c.bg })
	set_hl(0, "lualine_b_insert", { bg = c.black, fg = c.fg })
	set_hl(0, "lualine_c_insert", { bg = c.bg, fg = c.fg })
	set_hl(0, "lualine_x_insert", { bg = c.bg, fg = c.cyan })
	set_hl(0, "lualine_y_insert", { bg = c.black, fg = c.fg })
	set_hl(0, "lualine_z_insert", { bg = c.black, fg = c.fg })
	set_hl(0, "lualine_a_visual", { bg = c.blue, fg = c.fg })
	set_hl(0, "lualine_b_visual", { bg = c.black, fg = c.fg })
	set_hl(0, "lualine_c_visual", { bg = c.bg, fg = c.fg })
	set_hl(0, "lualine_x_visual", { bg = c.bg, fg = c.cyan })
	set_hl(0, "lualine_y_visual", { bg = c.black, fg = c.fg })
	set_hl(0, "lualine_z_visual", { bg = c.black, fg = c.fg })
	set_hl(0, "lualine_a_replace", { bg = c.red, fg = c.bg })
	set_hl(0, "lualine_b_replace", { bg = c.black, fg = c.fg })
	set_hl(0, "lualine_c_replace", { bg = c.bg, fg = c.fg })
	set_hl(0, "lualine_x_replace", { bg = c.bg, fg = c.cyan })
	set_hl(0, "lualine_y_replace", { bg = c.black, fg = c.fg })
	set_hl(0, "lualine_z_replace", { bg = c.black, fg = c.fg })
	set_hl(0, "lualine_a_command", { bg = c.black, fg = c.fg })
	set_hl(0, "lualine_b_command", { bg = c.black, fg = c.fg })
	set_hl(0, "lualine_c_command", { bg = c.bg, fg = c.fg })
	set_hl(0, "lualine_x_command", { bg = c.bg, fg = c.cyan })
	set_hl(0, "lualine_y_command", { bg = c.black, fg = c.fg })
	set_hl(0, "lualine_z_command", { bg = c.black, fg = c.fg })
	set_hl(0, "lualine_a_inactive", { bg = c.black, fg = c.cyan })
	set_hl(0, "lualine_b_inactive", { bg = c.black, fg = c.cyan })
	set_hl(0, "lualine_c_inactive", { bg = c.bg, fg = c.cyan })
	set_hl(0, "lualine_x_inactive", { bg = c.bg, fg = c.cyan })
	set_hl(0, "lualine_y_inactive", { bg = c.black, fg = c.cyan })
	set_hl(0, "lualine_z_inactive", { bg = c.black, fg = c.cyan })
end

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "fahrenheit",
	callback = function()
		fahrenheit.setup()
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.defer_fn(function()
			local l = fahrenheit.colors
			local modes = { "normal", "insert", "visual", "replace", "command", "inactive" }
			local sections = { "a", "b", "c", "x", "y", "z" }
			for _, m in ipairs(modes) do
				for _, s in ipairs(sections) do
					vim.api.nvim_set_hl(0, "lualine_" .. s .. "_" .. m, { bg = l.black, fg = l.fg })
				end
			end
			vim.api.nvim_set_hl(0, "lualine_a_normal", { bg = l.black, fg = l.fg, bold = true })
			vim.api.nvim_set_hl(0, "lualine_a_insert", { bg = l.green, fg = l.bg, bold = true })
			vim.api.nvim_set_hl(0, "lualine_a_visual", { bg = l.red, fg = l.bg, bold = true })
			vim.api.nvim_set_hl(0, "lualine_a_replace", { bg = l.blue, fg = l.fg, bold = true })
			vim.api.nvim_set_hl(0, "lualine_c_normal", { bg = l.bg, fg = l.fg })
			vim.api.nvim_set_hl(0, "lualine_c_insert", { bg = l.bg, fg = l.fg })
			vim.api.nvim_set_hl(0, "lualine_c_visual", { bg = l.bg, fg = l.fg })
			vim.api.nvim_set_hl(0, "lualine_c_replace", { bg = l.bg, fg = l.fg })
			vim.api.nvim_set_hl(0, "lualine_x_normal", { bg = l.bg, fg = l.cyan })
			vim.api.nvim_set_hl(0, "lualine_x_insert", { bg = l.bg, fg = l.cyan })
			vim.api.nvim_set_hl(0, "lualine_x_visual", { bg = l.bg, fg = l.cyan })
			vim.api.nvim_set_hl(0, "lualine_x_replace", { bg = l.bg, fg = l.cyan })
		end, 0)
	end,
})

return fahrenheit
