(local telescope {1 :nvim-telescope/telescope.nvim
                  :branch :0.1.x
                  :config (fn []
                            ((. (require :telescope) :setup) {:defaults {:layout_config {:horizontal {:height 0.95
                                                                                                      :preview_width 0.5
                                                                                                      :width 0.95}
                                                                                         :vertical {:height 0.9
                                                                                                    :preview_height 0.7
                                                                                                    :width 0.7}}
                                                                         :layout_strategy :vertical}
                                                              :extensions {:ui-select [((. (require :telescope.themes)
                                                                                           :get_dropdown))]}})
                            (pcall (. (require :telescope) :load_extension)
                                   :fzf)
                            (pcall (. (require :telescope) :load_extension)
                                   :ui-select)
                            (local builtin (require :telescope.builtin))
                            (vim.keymap.set :n :<leader>sh builtin.help_tags
                                            {:desc "[S]earch [H]elp"})
                            (vim.keymap.set :n :<leader>sk builtin.keymaps
                                            {:desc "[S]earch [K]eymaps"})
                            (vim.keymap.set :n :<leader>sf builtin.find_files
                                            {:desc "[S]earch [F]iles"})
                            (vim.keymap.set :n :<leader>ss builtin.builtin
                                            {:desc "[S]earch [S]elect Telescope"})
                            (vim.keymap.set :n :<leader>sw builtin.grep_string
                                            {:desc "[S]earch current [W]ord"})
                            (vim.keymap.set :n :<leader>sg builtin.live_grep
                                            {:desc "[S]earch by [G]rep"})
                            (vim.keymap.set :n :<leader>sd builtin.diagnostics
                                            {:desc "[S]earch [D]iagnostics"})
                            (vim.keymap.set :n :<leader>s. builtin.oldfiles
                                            {:desc "[S]earch Recent Files (\".\" for repeat)"})
                            (vim.keymap.set :n :<leader>/ builtin.buffers
                                            {:desc "[/] Find existing buffers"})
                            (vim.keymap.set :n :<leader>sc
                                            (fn []
                                              (builtin.colorscheme ((. (require :telescope.themes)
                                                                       :get_dropdown) {:previewer false :winblend 20})))
                                            {:desc "[S]earch [C]olorschemes"})
                            (vim.keymap.set :n :<leader><leader>
                                            builtin.current_buffer_fuzzy_find
                                            {:desc "[ ] Fuzzily search in current buffer"})
                            (vim.keymap.set :n :<leader>s/
                                            (fn []
                                              (builtin.live_grep {:grep_open_files true
                                                                  :prompt_title "Live Grep in Open Files"}))
                                            {:desc "[S]earch [/] in Open Files"})
                            (vim.keymap.set :n :<leader>sn
                                            (fn []
                                              (builtin.find_files {:cwd (vim.fn.stdpath :config)}))
                                            {:desc "[S]earch [N]eovim files"}))
                  :dependencies [:nvim-lua/plenary.nvim
                                 {1 :nvim-telescope/telescope-fzf-native.nvim
                                  :build :make
                                  :cond (fn [] (= (vim.fn.executable :make) 1))}
                                 [:nvim-telescope/telescope-ui-select.nvim]
                                 {1 :nvim-tree/nvim-web-devicons
                                  :enabled vim.g.have_nerd_font}]
                  :event :VimEnter})

[telescope]
