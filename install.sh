#!/bin/sh
# ~/dotfiles/install.sh

set -e

mkdir -p "$HOME/.config"

cd "$HOME/dotfiles/config" || exit 1
for dir in *; do
    [ -d "$dir" ] || continue

    target="$HOME/.config/$dir"
    if [ -L "$target" ]; then
        echo "Skipping $dir (symlink already exists)"
        continue
    elif [ -e "$target" ]; then
        echo "Skipping $dir (target exists and is not a symlink)"
        continue
    fi

    ln -sf "$PWD/$dir" "$target"
    echo "Linked $dir"
done
