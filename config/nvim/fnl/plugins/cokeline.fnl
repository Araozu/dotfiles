(local cokeline {1 :willothy/nvim-cokeline
                 :config (fn []
                           (local get-hex
                                  (. (require :cokeline.hlgroups) :get_hl_attr))
                           (local hlgroups (require :cokeline.hlgroups))
                           (local yellow vim.g.terminal_color_3)
                           ((. (require :cokeline) :setup) {:components [{:text (fn [buffer]
                                                                                  (.. " "
                                                                                      buffer.index))}
                                                                         {:fg (fn [buffer]
                                                                                buffer.devicon.color)
                                                                          :text (fn [buffer]
                                                                                  (.. " "
                                                                                      buffer.devicon.icon))}
                                                                         {:fg (fn []
                                                                                (hlgroups.get_hl_attr :Comment
                                                                                                      :fg))
                                                                          :italic true
                                                                          :text (fn [buffer]
                                                                                  buffer.unique_prefix)}
                                                                         {:text (fn [buffer]
                                                                                  buffer.filename)
                                                                          :underline (fn [buffer]
                                                                                       (when (and buffer.is_hovered
                                                                                                  (not buffer.is_focused))
                                                                                         true))}
                                                                         {:text " "}
                                                                         {:on_click (fn [_
                                                                                         _
                                                                                         _
                                                                                         _
                                                                                         buffer]
                                                                                      (buffer:delete))
                                                                          :text (fn [buffer]
                                                                                  (when buffer.is_modified
                                                                                    (lua "return \"\""))
                                                                                  (when buffer.is_hovered
                                                                                    (lua "return \"󰅙\""))
                                                                                  "󰅖")}
                                                                         {:text " "}]
                                                            :default_hl {:bg (fn [buffer]
                                                                               (or (and buffer.is_focused
                                                                                        (get-hex :Normal
                                                                                                 :fg))
                                                                                   (get-hex :ColorColumn
                                                                                            :bg)))
                                                                         :fg (fn [buffer]
                                                                               (or (and buffer.is_focused
                                                                                        (get-hex :ColorColumn
                                                                                                 :bg))
                                                                                   (get-hex :Normal
                                                                                            :fg)))}
                                                            :sidebar {:components [{:bg (fn []
                                                                                          (get-hex :NvimTreeNormal
                                                                                                   :bg))
                                                                                    :bold true
                                                                                    :fg yellow
                                                                                    :text (fn [buf]
                                                                                            buf.filetype)}]
                                                                      :filetype [:NvimTree
                                                                                 :neo-tree]}}))
                 :dependencies [:nvim-lua/plenary.nvim
                                :nvim-tree/nvim-web-devicons
                                :stevearc/resession.nvim]})

[cokeline]
