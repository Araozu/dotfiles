local lualine
local function _1_()
	local lualine0 = require("lualine")
	local colors = {
		bg = "#202328",
		blue = "#51afef",
		cyan = "#008080",
		darkblue = "#081633",
		fg = "#bbc2cf",
		green = "#98be65",
		magenta = "#c678dd",
		orange = "#FF8800",
		red = "#ec5f67",
		violet = "#a9a1e1",
		yellow = "#ECBE7B",
	}
	local conditions
	local function _2_()
		return (vim.fn.empty(vim.fn.expand("%:t")) ~= 1)
	end
	local function _3_()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", (filepath .. ";"))
		return ((gitdir and (#gitdir > 0)) and (#gitdir < #filepath))
	end
	local function _4_()
		return (vim.fn.winwidth(0) > 80)
	end
	conditions = { buffer_not_empty = _2_, check_git_workspace = _3_, hide_in_width = _4_ }
	local config
	local function _5_(name, ctx)
		local first_letter = string.sub(name, 1, 1)
		local rest = string.sub(name, 2)
		local str_lower = string.lower(rest)
		return (first_letter .. str_lower)
	end
	config = {
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		options = { component_separators = "", section_separators = "", theme = "auto" },
		sections = {
			lualine_a = { { "mode", color = { gui = "bold" }, fmt = _5_ } },
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
	}
	local function ins_left(component)
		return table.insert(config.sections.lualine_c, component)
	end
	local function ins_right(component)
		return table.insert(config.sections.lualine_x, component)
	end
	ins_left({ "location" })
	ins_left({
		"diagnostics",
		diagnostics_color = { error = { fg = colors.red }, info = { fg = colors.cyan }, warn = { fg = colors.yellow } },
		sources = { "nvim_diagnostic" },
		symbols = { error = "\239\129\151 ", info = "\239\129\170 ", warn = "\239\129\177 " },
	})
	local function _6_()
		return "%="
	end
	ins_left({ _6_ })
	ins_right({ "filetype" })
	ins_right({
		"o:encoding",
		color = { fg = colors.green, gui = "bold" },
		cond = conditions.hide_in_width,
		fmt = string.upper,
	})
	ins_right({ "fileformat", color = { fg = colors.green, gui = "bold" }, fmt = string.upper, icons_enabled = false })
	ins_right({ "branch", color = { fg = colors.violet, gui = "bold" }, icon = "\239\145\191" })
	ins_right({
		"diff",
		cond = conditions.hide_in_width,
		diff_color = { added = { fg = colors.green }, modified = { fg = colors.orange }, removed = { fg = colors.red } },
		symbols = { added = "\239\131\190 ", modified = "\243\176\157\164 ", removed = "\239\133\134 " },
	})
	return lualine0.setup(config)
end
lualine = { "nvim-lualine/lualine.nvim", config = _1_, dependencies = { "nvim-tree/nvim-web-devicons" } }
return { lualine }
