#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
targets=("$HOME/.config/nvim" "$HOME/.config/tmux" "$HOME/.config/kitty" "$HOME/.tmux.conf" "$HOME/.local/bin/kitty-tmux-launch")
sources=("$repo_dir/config/nvim" "$repo_dir/config/tmux" "$repo_dir/config/kitty" "$repo_dir/tmux.conf" "$repo_dir/bin/kitty-tmux-launch")

for target in "${targets[@]}"; do
  if [[ -e "$target" || -L "$target" ]]; then
    printf 'Already exists: %s\nMove it aside before installing.\n' "$target" >&2
    exit 1
  fi
done

mkdir -p "$HOME/.config" "$HOME/.local/bin"
for i in "${!targets[@]}"; do
  ln -s "${sources[$i]}" "${targets[$i]}"
  printf 'Linked %s\n' "${targets[$i]}"
done
