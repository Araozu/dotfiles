-- Ensure lazy and hotpot are always installed
local function ensure_installed(plugin, branch)
	local user, repo = string.match(plugin, "(.+)/(.+)")
	local repo_path = vim.fn.stdpath("data") .. "/lazy/" .. repo
	if not (vim.uv or vim.loop).fs_stat(repo_path) then
		vim.notify("Installing " .. plugin .. " " .. branch)
		local repo_url = "https://github.com/" .. plugin .. ".git"
		local out = vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"--branch=" .. branch,
			repo_url,
			repo_path,
		})
		if vim.v.shell_error ~= 0 then
			vim.api.nvim_echo({
				{ "Failed to clone " .. plugin .. ":\n", "ErrorMsg" },
				{ out, "WarningMsg" },
				{ "\nPress any key to exit..." },
			}, true, {})
			vim.fn.getchar()
			os.exit(1)
		end
	end
	return repo_path
end
local lazy_path = ensure_installed("folke/lazy.nvim", "stable")
local hotpot_path = ensure_installed("rktjmp/hotpot.nvim", "v0.14.6")
-- As per Lazy's install instructions, but also include hotpot
vim.opt.runtimepath:prepend({ hotpot_path, lazy_path })

-- You must call vim.loader.enable() before requiring hotpot unless you are
-- passing {performance = {cache = false}} to Lazy.
vim.loader.enable()

require("hotpot") -- Optionally you may call require("hotpot").setup(...) here

-- You must include Hotpot in your plugin list for it to function correctly.
-- If you want to use Lazy's "structured" style, see the next code sample.
require("lazy").setup({
	spec = {
		-- Add hotpot directly here
		{ "rktjmp/hotpot.nvim" },
		-- Then import your other plugins
		{ import = "plugins" },
	},
})
