if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Sane defaults
set -gx EDITOR vi
set -gx VISUAL vi
set -gx TERM xterm-256color

function git-push
    set -l remotes (git remote | string trim | string match -v '')

    if test (count $remotes) -eq 0
        echo "No remotes configured"
        return 1
    end

    # Pick the best remote
    set -l remote $remotes[1]  # fallback
    for preferred in forgejo gitea github origin
        if contains $preferred $remotes
            set remote $preferred
            break
        end
    end

    set -l branch (git rev-parse --abbrev-ref HEAD)
    echo "Pushing $branch to $remote"
    git push $remote $branch
end

function git-pull
    set -l remote (git remote | head -n1)
    if test -z "$remote"
        echo "No remote found"
        return 1
    end

    git pull $remote develop --no-rebase
end

function git-status
    git status -s
end

function git-log
    git log --oneline --graph --decorate --all -20
end

# Proper PATH handling
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin

# Better directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# vim keybindings
fish_vi_key_bindings
# Make the cursor change based on vi mode
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

# add node to env, installed by nvm fish
fish_add_path ~/.local/share/nvm/v22.13.1/bin/

# common alias
alias l='eza --long --header --icons --group-directories-first'
alias ll='eza --all --long --header --icons --group-directories-first'
alias lt='eza --ignore-glob="node_modules" --tree --level=2 --header --icons --group-directories-first'
alias ltt='eza --ignore-glob="node_modules" --tree --header --icons --group-directories-first'
alias llt='eza --ignore-glob="node_modules" --all --tree --level=2 --header --icons --group-directories-first'
alias lltt='eza --all --ignore-glob="node_modules" --tree --header --icons --group-directories-first'

# pnpm
set -gx PNPM_HOME "/home/fernando/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

starship init fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# go binaries
fish_add_path ~/go/bin/
