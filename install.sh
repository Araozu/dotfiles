#!/bin/sh

set -e

# Create config directories
mkdir -p "$HOME/.config"

# Handle .config directory symlinks first
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

# Handle root directory dotfiles
cd "$HOME/dotfiles/root" || exit 1
for file in *; do
    [ -f "$file" ] || continue

    target="$HOME/.$file"
    if [ -L "$target" ]; then
        echo "Skipping .$file (symlink already exists)"
        continue
    elif [ -e "$target" ]; then
        echo "Skipping .$file (target exists and is not a symlink)"
        continue
    fi

    ln -sf "$PWD/$file" "$target"
    echo "Linked .$file"
done
