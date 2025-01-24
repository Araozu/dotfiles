; My Neovim config, based on kickstart.nvim
; and rewritten in Fennel, because why not?

(set vim.g.mapleader " ")
(set vim.g.maplocalleader " ")
(set vim.g.have_nerd_font true)
(set vim.opt.number true)
(set vim.opt.relativenumber true)
(set vim.opt.mouse "a")
(set vim.opt.showmode false)
(vim.schedule (fn [] (set vim.opt.clipboard "unnamedplus")))
(set vim.opt.breakindent true)
(set vim.opt.undofile true)
(set vim.opt.ignorecase true)
(set vim.opt.smartcase true)
(set vim.opt.signcolumn "yes")
(set vim.opt.updatetime 250)
(set vim.opt.timeoutlen 300)
(set vim.opt.splitright true)
(set vim.opt.splitbelow true)
(set vim.opt.list true)
(set vim.opt.listchars
     {"tab" "» " "trail" "·" "nbsp" "␣"})
(set vim.opt.inccommand "split")
(set vim.opt.cursorline true)
; Minimal number of screen lines to keep above/below
(set vim.opt.scrolloff 4)

;
; Setup carry over
;

; Keymaps for buffer switching
(vim.keymap.set :n :<leader>h "<Plug>(cokeline-focus-prev)"
                {:desc "Previous buffer"})
(vim.keymap.set :n :<leader>l "<Plug>(cokeline-focus-next)"
                {:desc "Next buffer"})
(vim.keymap.set :n :<leader>a "<cmd>:e #<cr>" {:desc "[A]lternate buffer"})
(vim.keymap.set :n :<leader>bd "<cmd>:bd<cr>" {:desc "[B]uffer [D]elete"})

; cokeline
(for [i 1 9]
  (vim.keymap.set :n (: "<Leader>%s" :format i)
                  (: "<Plug>(cokeline-focus-%s)" :format i)
                  {:desc (: "Switch to tab %s" :format i) :silent true}))

(vim.keymap.set :n :<leader>H "<Plug>(cokeline-switch-prev)"
                {:desc "Previous buffer swap"})
(vim.keymap.set :n :<leader>L "<Plug>(cokeline-switch-next)"
                {:desc "Next buffer swap"})

; neotree
(vim.keymap.set :n :<leader>tn "<cmd>:Neotree focus toggle<cr>"
                {:desc "[T]oggle [N]eotree"})
(vim.keymap.set :n :<leader>tr "<cmd>:Neotree reveal<cr>"
                {:desc "[T]oggle Neotree [R]eveal"})
(vim.keymap.set :n :<leader>tg "<cmd>:Telescope git_status<cr>"
                {:desc "[T]elescope [G]it status"})
(vim.keymap.set :n :<Esc> :<cmd>nohlsearch<CR>)
(vim.keymap.set :n :<leader>q vim.diagnostic.setloclist
                {:desc "Open diagnostic [Q]uickfix list"})

; Moving
(vim.keymap.set :n :<C-h> :<C-w><C-h> {:desc "Move focus to the left window"})
(vim.keymap.set :n :<C-l> :<C-w><C-l> {:desc "Move focus to the right window"})
(vim.keymap.set :n :<C-j> :<C-w><C-j> {:desc "Move focus to the lower window"})
(vim.keymap.set :n :<C-k> :<C-w><C-k> {:desc "Move focus to the upper window"})

; Fold
(vim.keymap.set :n :z$ "$zf%" {:desc "Fold EOL & %"})

; Highlight when yanking (copying) text
(vim.api.nvim_create_autocmd :TextYankPost
                             {:callback (fn [] (vim.highlight.on_yank))
                              :desc "Highlight when yanking (copying) text"
                              :group (vim.api.nvim_create_augroup :kickstart-highlight-yank
                                                                  {:clear true})})


(print "I have been setup with Fennel :D")
