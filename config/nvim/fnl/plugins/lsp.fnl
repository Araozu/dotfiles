(fn disable-formatting [client]
  (set client.server_capabilities.documentFormattingProvider false)
  (set client.server_capabilities.documentRangeFormattingProvider false))

(fn disable-other-formatters [bufnr eslint-client-id]
  (let [clients (vim.lsp.get_active_clients {:bufnr bufnr})]
    (each [_ client (ipairs clients)]
      (when (and
              (not= client.id eslint-client-id)
              (and client.server_capabilities client.server_capabilities.documentFormattingProvider))
        (set client.server_capabilities.documentFormattingProvider false)))))

(local lazydev
       {1 :folke/lazydev.nvim
        :ft :lua
        :opts {:library [{:path :luvit-meta/library :words ["vim%.uv"]}]}})

(local luvit-meta {1 "Bilal2453/luvit-meta"
                   :lazy true})

(local lspconfig {1 :neovim/nvim-lspconfig
                  :config (fn []
                            ; Configure Gleam lang
                            ((. (require :lspconfig) :gleam :setup) {})
                            ; Configure Typescript: disable auto format
                            ((. (require :lspconfig) :ts_ls :setup) 
                             {:on_attach (fn [client
                                              bufnr]
                                           (disable-formatting client))})
                            ; Configure eslint for use instead of ts-ls
                            ((. (require :lspconfig) :eslint :setup) 
                             {:on_attach (fn [client bufnr]
                                           ; Disable other formattes
                                          (disable-other-formatters bufnr client.id)
                                          (vim.api.nvim_create_autocmd 
                                            :BufWritePre 
                                            {:buffer bufnr :command :EslintFixAll}))})

                            (vim.api.nvim_create_autocmd :LspAttach
                                                         {:callback (fn [event]
                                                                      (fn map [keys
                                                                               func
                                                                               desc
                                                                               mode]
                                                                        (set-forcibly! mode
                                                                                       (or mode
                                                                                           :n))
                                                                        (vim.keymap.set mode
                                                                                        keys
                                                                                        func
                                                                                        {:buffer event.buf
                                                                                         :desc (.. "LSP: "
                                                                                                   desc)}))

                                                                      (map :gd
                                                                           (. (require :telescope.builtin)
                                                                              :lsp_definitions)
                                                                           "[G]oto [D]efinition")
                                                                      (map :gr
                                                                           (. (require :telescope.builtin)
                                                                              :lsp_references)
                                                                           "[G]oto [R]eferences")
                                                                      (map :gI
                                                                           (. (require :telescope.builtin)
                                                                              :lsp_implementations)
                                                                           "[G]oto [I]mplementation")
                                                                      (map :<leader>D
                                                                           (. (require :telescope.builtin)
                                                                              :lsp_type_definitions)
                                                                           "Type [D]efinition")
                                                                      (map :<leader>ds
                                                                           (. (require :telescope.builtin)
                                                                              :lsp_document_symbols)
                                                                           "[D]ocument [S]ymbols")
                                                                      (map :<leader>ws
                                                                           (. (require :telescope.builtin)
                                                                              :lsp_dynamic_workspace_symbols)
                                                                           "[W]orkspace [S]ymbols")
                                                                      (map :<leader>rn
                                                                           vim.lsp.buf.rename
                                                                           "[R]e[n]ame")
                                                                      (map :<leader>ca
                                                                           vim.lsp.buf.code_action
                                                                           "[C]ode [A]ction"
                                                                           [:n
                                                                            :x])
                                                                      (map :gD
                                                                           vim.lsp.buf.declaration
                                                                           "[G]oto [D]eclaration")
                                                                      (local client
                                                                             (vim.lsp.get_client_by_id event.data.client_id))
                                                                      (when (and client
                                                                                 (client.supports_method vim.lsp.protocol.Methods.textDocument_documentHighlight))
                                                                        (local highlight-augroup
                                                                               (vim.api.nvim_create_augroup :kickstart-lsp-highlight
                                                                                                            {:clear false}))
                                                                        (vim.api.nvim_create_autocmd [:CursorHold
                                                                                                      :CursorHoldI]
                                                                                                     {:buffer event.buf
                                                                                                      :callback vim.lsp.buf.document_highlight
                                                                                                      :group highlight-augroup})
                                                                        (vim.api.nvim_create_autocmd [:CursorMoved
                                                                                                      :CursorMovedI]
                                                                                                     {:buffer event.buf
                                                                                                      :callback vim.lsp.buf.clear_references
                                                                                                      :group highlight-augroup})
                                                                        (vim.api.nvim_create_autocmd :LspDetach
                                                                                                     {:callback (fn [event2]
                                                                                                                  (vim.lsp.buf.clear_references)
                                                                                                                  (vim.api.nvim_clear_autocmds {:buffer event2.buf
                                                                                                                                                :group :kickstart-lsp-highlight}))
                                                                                                      :group (vim.api.nvim_create_augroup :kickstart-lsp-detach
                                                                                                                                          {:clear true})}))
                                                                      (when (and client
                                                                                 (client.supports_method vim.lsp.protocol.Methods.textDocument_inlayHint))
                                                                        (map :<leader>th
                                                                             (fn []
                                                                               (vim.lsp.inlay_hint.enable (not (vim.lsp.inlay_hint.is_enabled {:bufnr event.buf}))))
                                                                             "[T]oggle Inlay [H]ints"))
                                                                      (local opts
                                                                             {:buffer event.buf})
                                                                      (vim.keymap.set :n
                                                                                      :gh
                                                                                      (fn []
                                                                                        (vim.diagnostic.open_float))
                                                                                      {:buffer event.buf
                                                                                       :desc "[h] Open floating diagnostic"}))
                                                          :group (vim.api.nvim_create_augroup :kickstart-lsp-attach
                                                                                              {:clear true})})
                            (var capabilities
                                 (vim.lsp.protocol.make_client_capabilities))
                            (set capabilities
                                 (vim.tbl_deep_extend :force capabilities
                                                      ((. (require :cmp_nvim_lsp)
                                                          :default_capabilities))))
                            (local servers
                                   {:astro {}
                                    :clojure_lsp {}
                                    :eslint {}
                                    :gopls {}
                                    :emmet_language_server {}
                                    :lua_ls {:settings {:Lua {:completion {:callSnippet :Replace}}}}
                                    :tailwindcss {}
                                    :ts_ls {}
                                    :omnisharp {}
                                    :zls {}})
                            ((. (require :mason) :setup))
                            (local ensure-installed
                                   (vim.tbl_keys (or servers {})))
                            (vim.list_extend ensure-installed [:stylua])
                            ((. (require :mason-tool-installer) :setup) {:ensure_installed ensure-installed})
                            ((. (require :mason-lspconfig) :setup) {:handlers [(fn [server-name]
                                                                                 (local server
                                                                                        (or (. servers
                                                                                               server-name)
                                                                                            {}))
                                                                                 (set server.capabilities
                                                                                      (vim.tbl_deep_extend :force
                                                                                                           {}
                                                                                                           capabilities
                                                                                                           (or server.capabilities
                                                                                                               {})))
                                                                                 ((. (require :lspconfig)
                                                                                     server-name
                                                                                     :setup) server))]}))
                  :dependencies [{1 :williamboman/mason.nvim :config true}
                                 :williamboman/mason-lspconfig.nvim
                                 :WhoIsSethDaniel/mason-tool-installer.nvim
                                 {1 :j-hui/fidget.nvim :opts {}}
                                 :hrsh7th/cmp-nvim-lsp]})

[
 lazydev
 luvit-meta
 lspconfig]
