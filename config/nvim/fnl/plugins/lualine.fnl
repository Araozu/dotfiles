(local lualine {1 :nvim-lualine/lualine.nvim
                :config (fn []
                          (local lualine (require :lualine))
                          (local colors
                                 {:bg "#202328"
                                  :blue "#51afef"
                                  :cyan "#008080"
                                  :darkblue "#081633"
                                  :fg "#bbc2cf"
                                  :green "#98be65"
                                  :magenta "#c678dd"
                                  :orange "#FF8800"
                                  :red "#ec5f67"
                                  :violet "#a9a1e1"
                                  :yellow "#ECBE7B"})
                          (local conditions
                                 {:buffer_not_empty (fn []
                                                      (not= (vim.fn.empty (vim.fn.expand "%:t"))
                                                            1))
                                  :check_git_workspace (fn []
                                                         (local filepath
                                                                (vim.fn.expand "%:p:h"))
                                                         (local gitdir
                                                                (vim.fn.finddir :.git
                                                                                (.. filepath
                                                                                    ";")))
                                                         (and (and gitdir
                                                                   (> (length gitdir)
                                                                      0))
                                                              (< (length gitdir)
                                                                 (length filepath))))
                                  :hide_in_width (fn []
                                                   (> (vim.fn.winwidth 0) 80))})
                          (local config
                                 {:inactive_sections {:lualine_a {}
                                                      :lualine_b {}
                                                      :lualine_c {}
                                                      :lualine_x {}
                                                      :lualine_y {}
                                                      :lualine_z {}}
                                  :options {:component_separators ""
                                            :section_separators ""
                                            :theme :auto}
                                  :sections {:lualine_a [{1 :mode
                                                          :color {:gui :bold}
                                                          :fmt (fn [name ctx]
                                                                 (local first-letter
                                                                        (string.sub name
                                                                                    1
                                                                                    1))
                                                                 (local rest
                                                                        (string.sub name
                                                                                    2))
                                                                 (local str-lower
                                                                        (string.lower rest))
                                                                 (.. first-letter
                                                                     str-lower))}]
                                             :lualine_b {}
                                             :lualine_c {}
                                             :lualine_x {}
                                             :lualine_y {}
                                             :lualine_z {}}})

                          (fn ins-left [component]
                            (table.insert config.sections.lualine_c component))

                          (fn ins-right [component]
                            (table.insert config.sections.lualine_x component))

                          (ins-left [:location])
                          (ins-left {1 :diagnostics
                                     :diagnostics_color {:error {:fg colors.red}
                                                         :info {:fg colors.cyan}
                                                         :warn {:fg colors.yellow}}
                                     :sources [:nvim_diagnostic]
                                     :symbols {:error " "
                                               :info " "
                                               :warn " "}})
                          (ins-left [(fn [] "%=")])
                          (ins-right [:filetype])
                          (ins-right {1 "o:encoding"
                                      :color {:fg colors.green :gui :bold}
                                      :cond conditions.hide_in_width
                                      :fmt string.upper})
                          (ins-right {1 :fileformat
                                      :color {:fg colors.green :gui :bold}
                                      :fmt string.upper
                                      :icons_enabled false})
                          (ins-right {1 :branch
                                      :color {:fg colors.violet :gui :bold}
                                      :icon ""})
                          (ins-right {1 :diff
                                      :cond conditions.hide_in_width
                                      :diff_color {:added {:fg colors.green}
                                                   :modified {:fg colors.orange}
                                                   :removed {:fg colors.red}}
                                      :symbols {:added " "
                                                :modified "󰝤 "
                                                :removed " "}})
                          (lualine.setup config))
                :dependencies [:nvim-tree/nvim-web-devicons]})

[lualine]
