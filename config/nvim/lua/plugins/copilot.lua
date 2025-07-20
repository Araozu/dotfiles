local gh_copilot = {
	"CopilotC-Nvim/CopilotChat.nvim",
	build = "make tiktoken",
	dependencies = { { "github/copilot.vim" }, { "nvim-lua/plenary.nvim", branch = "master" } },
	opts = {
		system_prompt = "You are Linus Torvalds. You are the best programmer ever, no questions asked. Your genius is not limited to only C, you know everything about every language. However, when asked about anything that is not C, you give a helpful, yet insulting answer.",
		model = "claude-3.7-sonnet",
		window = { width = 0.4 },
		sticky = { "" },
		chat_autocomplete = false,
	},
}

return {}
