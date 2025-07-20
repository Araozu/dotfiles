return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local bufferline = require("bufferline")

		-- setup configuration
		bufferline.setup({
			options = {
				--
				diagnostics = "nvim_lsp",
				separator_style = "slant",
				numbers = "ordinal",
			},
		})

		-- setup keymaps

		-- tab manipulation
		vim.keymap.set("n", "<leader>j", ":tabprevious<CR>", { desc = "Previous Tab" })
		vim.keymap.set("n", "<leader>k", ":tabnext<CR>", { desc = "Next Tab" })

		-- buffer manipulation
		vim.keymap.set("n", "<leader>bcr", function()
			bufferline.close_in_direction("right")
		end, { desc = "[B]uffers: [C]lose to the [R]ight" })

		vim.keymap.set("n", "<leader>bcl", function()
			bufferline.close_in_direction("left")
		end, { desc = "[B]uffers: [C]lose to the [L]eft" })

		vim.keymap.set("n", "<leader>bco", function()
			bufferline.close_others()
		end, { desc = "[B]uffers: [C]lose [O]thers" })

		vim.keymap.set("n", "<leader>bp", function()
			bufferline.groups.toggle_pin()
		end, { desc = "[B]uffer: Toggle [P]in" })

		-- buffer positioning
		vim.keymap.set("n", "<leader>h", function()
			bufferline.cycle(-1)
		end, { desc = "Previous buffer" })
		vim.keymap.set("n", "<leader>l", function()
			bufferline.cycle(1)
		end, { desc = "Next buffer" })

		--
		for i = 1, 9 do
			vim.keymap.set("n", ("<Leader>%s"):format(i), function()
				bufferline.go_to(i, true)
			end, { desc = ("Switch to tab %s"):format(i), silent = true })
		end
		--

		vim.keymap.set("n", "<leader>H", function()
			bufferline.move_to(-1)
		end, { desc = "Previous buffer swap" })
		vim.keymap.set("n", "<leader>L", function()
			bufferline.move_to(1)
		end, { desc = "Next buffer swap" })
	end,
}
