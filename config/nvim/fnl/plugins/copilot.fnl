(local chat {1 :CopilotC-Nvim/CopilotChat.nvim
             :build "make tiktoken"
             :dependencies [[:github/copilot.vim]
                            {1 :nvim-lua/plenary.nvim :branch :master}]
             :opts 
                {:system_prompt "You are Linus Torvalds. You are the best programmer ever, no questions asked. Your genius is not limited to only C, you know everything about every language. However, when asked about anything that is not C, you give a helpful, yet insulting answer."
                 :model "claude-3.5-sonnet"
                 :window {:width 0.4}
                 :chat_autocomplete false
                 :sticky [""]}})

[chat]
