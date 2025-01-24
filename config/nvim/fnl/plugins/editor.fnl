(local blankline
       {1 :lukas-reineke/indent-blankline.nvim
        :main :ibl
        :opts {:indent {:char "▏"}
               :scope {:show_end false :show_start false}}})

(local emmet
       {1 :olrtg/nvim-emmet
        :config (fn []
                  (vim.keymap.set [:n :v] :<leader>xe
                                  (. (require :nvim-emmet)
                                     :wrap_with_abbreviation)))})

(local autoformat {1 :stevearc/conform.nvim
                   :cmd [:ConformInfo]
                   :event [:BufWritePre]
                   :keys [{1 :<leader>f
                           2 (fn []
                               ((. (require :conform) :format) {:async true
                                                                :lsp_format :fallback}))
                           :desc "[F]ormat buffer"
                           :mode ""}]
                   :opts {:format_on_save (fn [bufnr]
                                            (local disable-filetypes
                                                   {:c true :cpp true})
                                            (var lsp-format-opt nil)
                                            (if (. disable-filetypes
                                                   (. vim.bo bufnr :filetype))
                                                (set lsp-format-opt :never)
                                                (set lsp-format-opt :fallback))
                                            {:lsp_format lsp-format-opt
                                             :timeout_ms 500})
                          :formatters_by_ft {:lua [:stylua]}
                          :notify_on_error false}})

(local autocomplete {1 :hrsh7th/nvim-cmp
                     :config (fn []
                               (local cmp (require :cmp))
                               (local luasnip (require :luasnip))
                               (luasnip.config.setup {})
                               (cmp.setup {:completion {:completeopt "menu,menuone,noinsert"}
                                           :mapping (cmp.mapping.preset.insert {:<C-Space> (cmp.mapping.complete {})
                                                                                :<C-b> (cmp.mapping.scroll_docs (- 4))
                                                                                :<C-f> (cmp.mapping.scroll_docs 4)
                                                                                :<C-h> (cmp.mapping (fn []
                                                                                                      (when (luasnip.locally_jumpable (- 1))
                                                                                                        (luasnip.jump (- 1))))
                                                                                                    [:i
                                                                                                     :s])
                                                                                :<C-l> (cmp.mapping (fn []
                                                                                                      (when (luasnip.expand_or_locally_jumpable)
                                                                                                        (luasnip.expand_or_jump)))
                                                                                                    [:i
                                                                                                     :s])
                                                                                :<C-n> (cmp.mapping.select_next_item)
                                                                                :<C-p> (cmp.mapping.select_prev_item)
                                                                                :<C-y> (cmp.mapping.confirm {:select true})})
                                           :snippet {:expand (fn [args]
                                                               (luasnip.lsp_expand args.body))}
                                           :sources [{:group_index 0
                                                      :name :lazydev}
                                                     {:name :nvim_lsp}
                                                     {:name :luasnip}
                                                     {:name :path}]}))
                     :dependencies [{1 :L3MON4D3/LuaSnip
                                     :build ((fn []
                                               (when (or (= (vim.fn.has :win32)
                                                            1)
                                                         (= (vim.fn.executable :make)
                                                            0))
                                                 (lua "return "))
                                               "make install_jsregexp"))
                                     :dependencies {}}
                                    :saadparwaiz1/cmp_luasnip
                                    :hrsh7th/cmp-nvim-lsp
                                    :hrsh7th/cmp-path]
                     :event :InsertEnter})

(local comments {1 :folke/todo-comments.nvim
                 :dependencies [:nvim-lua/plenary.nvim]
                 :event :VimEnter
                 :opts {:signs false}})

(local mini {1 :echasnovski/mini.nvim
             :config (fn []
                       ((. (require :mini.ai) :setup) {:n_lines 500})
                       ((. (require :mini.surround) :setup))
                       (local statusline (require :mini.statusline))
                       (statusline.setup {:use_icons vim.g.have_nerd_font})

                       (fn statusline.section_location []
                         "%2l:%-2v"))})

[
 blankline
 emmet
 autoformat
 autocomplete
 comments
 mini
 "tpope/vim-sleuth" ; Detect tabstop and shiftwidth automatically
 ]
