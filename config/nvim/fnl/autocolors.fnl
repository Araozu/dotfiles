;
; This file is to be called AFTER the color plugins have been loaded
;
(fn set-theme-for-directory []
  (let [cwd (vim.fn.getcwd)
        directory-themes {:acide/trazo-backend :github_light
                          :acide/trazo-frontend :onelight
                          :acide/perucontrol/backend :caret
                          :acide/perucontrol/frontend "rose-pine-moon"
                          :csharp :caret
                          :zig :ayu-dark}]
    (var theme "randomhue")
    (each [dir dir-theme (pairs directory-themes)]
      (when (string.find cwd dir 1 true) (set theme dir-theme) (lua :break)))
    (vim.cmd (.. "colorscheme " theme))))

(vim.api.nvim_create_autocmd [:DirChanged]
                             {:callback (fn [] (set-theme-for-directory))})

(set-theme-for-directory)
