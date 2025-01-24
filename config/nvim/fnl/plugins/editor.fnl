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

[
 blankline
 emmet
 ]
