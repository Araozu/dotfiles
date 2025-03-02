(local chat {1 :CopilotC-Nvim/CopilotChat.nvim
             :build "make tiktoken"
             :dependencies [[:github/copilot.vim]
                            {1 :nvim-lua/plenary.nvim :branch :master}]
             :opts {}})

[chat]
