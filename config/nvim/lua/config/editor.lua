vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 4

-- Disasble backup write, due to conflicts with some hot reload tools (dotnet watch)
vim.opt.backup = false
vim.opt.writebackup = false

--
-- Some keymaps
--
vim.keymap.set("n", "<leader>a", "<cmd>:e #<cr>", {desc = "[A]lternate buffer"})
vim.keymap.set("n", "<leader>bd", "<cmd>:bd<cr>", {desc = "[B]uffer [D]elete"})

-- cokeline specific
vim.keymap.set("n", "<leader>h", "<Plug>(cokeline-focus-prev)", {desc = "Previous buffer"})
vim.keymap.set("n", "<leader>l", "<Plug>(cokeline-focus-next)", {desc = "Next buffer"})
-- for i = 1, 9 do
--   vim.keymap.set("n", ("<Leader>%s"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i), {desc = ("Switch to tab %s"):format(i), silent = true})
-- end
vim.keymap.set("n", "<leader>H", "<Plug>(cokeline-switch-prev)", {desc = "Previous buffer swap"})
vim.keymap.set("n", "<leader>L", "<Plug>(cokeline-switch-next)", {desc = "Next buffer swap"})

-- neotree scpecific
vim.keymap.set("n", "<leader>tn", "<cmd>:Neotree focus toggle<cr>", {desc = "[T]oggle [N]eotree"})
vim.keymap.set("n", "<leader>tr", "<cmd>:Neotree reveal<cr>", {desc = "[T]oggle Neotree [R]eveal"})

-- telescope specific
vim.keymap.set("n", "<leader>tg", "<cmd>:Telescope git_status<cr>", {desc = "[T]elescope [G]it status"})

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {desc = "Open diagnostic [Q]uickfix list"})

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", {desc = "Move focus to the left window"})
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", {desc = "Move focus to the right window"})
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", {desc = "Move focus to the lower window"})
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", {desc = "Move focus to the upper window"})

-- folds
vim.keymap.set("n", "z$", "$zf%", {desc = "Fold EOL & %"})

-- Highlight when yanking (copying) text
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

