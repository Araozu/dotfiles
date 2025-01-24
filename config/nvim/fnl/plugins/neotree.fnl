(local neotree {1 :nvim-neo-tree/neo-tree.nvim
                :cmd :Neotree
                :dependencies [:nvim-lua/plenary.nvim
                               :nvim-tree/nvim-web-devicons
                               :MunifTanjim/nui.nvim]
                :keys [{1 "\\"
                        2 ":Neotree reveal<CR>"
                        :desc "NeoTree reveal"
                        :silent true}]
                :opts {:filesystem {:window {:mappings {"\\" :close_window}}}}
                :version "*"})

[neotree]
