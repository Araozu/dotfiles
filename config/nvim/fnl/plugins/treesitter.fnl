(local neotree {1 :nvim-treesitter/nvim-treesitter
                :build ":TSUpdate"
                :main :nvim-treesitter.configs
                :opts {:auto_install true
                       :ensure_installed [:bash
                                          :c
                                          :diff
                                          :html
                                          :lua
                                          :luadoc
                                          :markdown
                                          :markdown_inline
                                          :query
                                          :vim
                                          :vimdoc]
                       :highlight {:additional_vim_regex_highlighting [:ruby]
                                   :enable true}
                       :indent {:disable [:ruby] :enable true}}})

[neotree]
