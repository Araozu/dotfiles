(local whichkey
       {1 :folke/which-key.nvim
        :event :VimEnter
        :opts {:icons {:keys (or (and vim.g.have_nerd_font {})
                                 {:BS "<BS> "
                                  :C "<C-…> "
                                  :CR "<CR> "
                                  :D "<D-…> "
                                  :Down "<Down> "
                                  :Esc "<Esc> "
                                  :F1 :<F1>
                                  :F10 :<F10>
                                  :F11 :<F11>
                                  :F12 :<F12>
                                  :F2 :<F2>
                                  :F3 :<F3>
                                  :F4 :<F4>
                                  :F5 :<F5>
                                  :F6 :<F6>
                                  :F7 :<F7>
                                  :F8 :<F8>
                                  :F9 :<F9>
                                  :Left "<Left> "
                                  :M "<M-…> "
                                  :NL "<NL> "
                                  :Right "<Right> "
                                  :S "<S-…> "
                                  :ScrollWheelDown "<ScrollWheelDown> "
                                  :ScrollWheelUp "<ScrollWheelUp> "
                                  :Space "<Space> "
                                  :Tab "<Tab> "
                                  :Up "<Up> "})
                       :mappings vim.g.have_nerd_font}
               :spec [{1 :<leader>c :group "[C]ode" :mode [:n :x]}
                      {1 :<leader>d :group "[D]ocument"}
                      {1 :<leader>r :group "[R]ename"}
                      {1 :<leader>s :group "[S]earch"}
                      {1 :<leader>w :group "[W]orkspace"}
                      {1 :<leader>t :group "[T]oggle"}]}})

[whichkey]
