if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Sane defaults
set -gx EDITOR vi
set -gx VISUAL vi
set -gx TERM foot

function git-push
    git push github (git rev-parse --abbrev-ref HEAD)
end

function git-pull
    git pull github develop --no-rebase
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
fish_add_path ~/.local/share/nvm/v22.13.0/bin/

# common alias
alias l='eza --long --header --icons --group-directories-first'
alias ll='eza --all --long --header --icons --group-directories-first'
alias lt='eza --ignore-glob="node_modules" --tree --level=2 --header --icons --group-directories-first'
alias ltt='eza --ignore-glob="node_modules" --tree --header --icons --group-directories-first'

# pnpm
set -gx PNPM_HOME "/home/fernando/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

starship init fish | source
