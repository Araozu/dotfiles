(local git
       {1 :lewis6991/gitsigns.nvim
        :config (fn []
                  ((. (require :gitsigns) :setup) {:on_attach (fn [bufnr]
                                                                (local gitsigns
                                                                       (require :gitsigns))

                                                                (fn map [mode
                                                                         l
                                                                         r
                                                                         opts]
                                                                  (set-forcibly! opts
                                                                                 (or opts
                                                                                     {}))
                                                                  (set opts.buffer
                                                                       bufnr)
                                                                  (vim.keymap.set mode
                                                                                  l
                                                                                  r
                                                                                  opts))

                                                                (map :n "]c"
                                                                     (fn []
                                                                       (if vim.wo.diff
                                                                           (vim.cmd.normal {1 "]c"
                                                                                            :bang true})
                                                                           (gitsigns.nav_hunk :next)))
                                                                     {:desc "Next Git hunk"})
                                                                (map :n "[c"
                                                                     (fn []
                                                                       (if vim.wo.diff
                                                                           (vim.cmd.normal {1 "[c"
                                                                                            :bang true})
                                                                           (gitsigns.nav_hunk :prev)))
                                                                     {:desc "Previous Git hunk"})
                                                                (map :n
                                                                     :<leader>gs
                                                                     gitsigns.stage_hunk
                                                                     {:desc "[s]tage hunk"})
                                                                (map :n
                                                                     :<leader>gr
                                                                     gitsigns.reset_hunk
                                                                     {:desc "[r]eset hunk"})
                                                                (map :v
                                                                     :<leader>gs
                                                                     (fn []
                                                                       (gitsigns.stage_hunk [(vim.fn.line ".")
                                                                                             (vim.fn.line :v)]))
                                                                     {:desc "[S]tage hunk"})
                                                                (map :v
                                                                     :<leader>gr
                                                                     (fn []
                                                                       (gitsigns.reset_hunk [(vim.fn.line ".")
                                                                                             (vim.fn.line :v)]))
                                                                     {:desc "[R]eset hunk"})
                                                                (map :n
                                                                     :<leader>gS
                                                                     gitsigns.stage_buffer
                                                                     {:desc "[S]tage buffer"})
                                                                (map :n
                                                                     :<leader>gu
                                                                     gitsigns.undo_stage_hunk
                                                                     {:desc "[u]ndo stage hunk"})
                                                                (map :n
                                                                     :<leader>gR
                                                                     gitsigns.reset_buffer
                                                                     {:desc "[R]eset buffer"})
                                                                (map :n
                                                                     :<leader>gp
                                                                     gitsigns.preview_hunk
                                                                     {:desc "[p]review hunk"})
                                                                (map :n
                                                                     :<leader>gb
                                                                     (fn []
                                                                       (gitsigns.blame_line {:full true}))
                                                                     {:desc "[b]lame line"})
                                                                (map :n
                                                                     :<leader>tb
                                                                     gitsigns.toggle_current_line_blame
                                                                     {:desc "Toggle current line [b]lame"})
                                                                (map :n
                                                                     :<leader>gd
                                                                     gitsigns.diffthis
                                                                     {:desc "[d]iff this file"})
                                                                (map :n
                                                                     :<leader>gD
                                                                     (fn []
                                                                       (gitsigns.diffthis "~"))
                                                                     {:desc "[D]iff this ~"})
                                                                (map :n
                                                                     :<leader>td
                                                                     gitsigns.toggle_deleted
                                                                     {:desc "Toggle [d]eleted"})
                                                                (map [:o :x]
                                                                     :ih
                                                                     ":<C-U>Gitsigns select_hunk<CR>"))
                                                   :signs {:add {:text "+"}
                                                           :change {:text "~"}
                                                           :changedelete {:text "~"}
                                                           :delete {:text "_"}
                                                           :topdelete {:text "‾"}}}))})	

[git]
