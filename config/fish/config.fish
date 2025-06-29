if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Sane defaults
set -gx EDITOR vi
set -gx VISUAL vi

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

# pnpm end

starship init fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
