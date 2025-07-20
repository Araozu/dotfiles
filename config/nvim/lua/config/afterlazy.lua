-- Things that run after lazy has been called
local function set_theme_for_directory()
	local cwd = vim.fn.getcwd()
	local directory_themes = {
		["acide/trazo-backend"] = "github_light",
		["acide/trazo-frontend"] = "onelight",
		["acide/perucontrol/backend"] = "caret",
		csharp = "caret",
		zig = "ayu-dark",
	}
	local theme = "randomhue"
	for dir, dir_theme in pairs(directory_themes) do
		if string.find(cwd, dir, 1, true) then
			theme = dir_theme
			break
		else
		end
	end
	return vim.cmd(("colorscheme " .. theme))
end

local function _2_()
	return set_theme_for_directory()
end

vim.api.nvim_create_autocmd({ "DirChanged" }, { callback = _2_ })

set_theme_for_directory()
