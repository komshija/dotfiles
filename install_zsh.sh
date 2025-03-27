#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_zsh() {
  sudo apt-get update
  sudo apt-get install -y zsh wget git stow
}

setup_zsh() {
  env RUNZSH=no sh -c "$(wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" || true

  git clone https://github.com/zsh-users/zsh-autosuggestions \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" || true

  git clone --depth=1 https://github.com/junegunn/fzf.git "$HOME/.fzf" || true
  "$HOME/.fzf/install" --all --no-bash --no-fish
  
  git clone https://github.com/sunlei/zsh-ssh \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-ssh" || true
 
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" || true

}

backup_conflicts() {
  BACKUP_DIR="$HOME/.setup-backup"

  mkdir -p "$BACKUP_DIR"
  cd "$SCRIPT_DIR/zshrc"

  for item in .* *; do
    if [[ "$item" == "." || "$item" == ".." || -z "$item" ]]; then
      continue
    fi
    
    target_item="$TARGET_DIR/$item"

    if [[ -e "$target_item" && ! -L "$target_item" ]]; then
      backup_name="$(basename "$item").bak_$(date +%Y%m%d_%H%M%S)"
      echo "  - Backing up: $target_item -> $BACKUP_DIR/$backup_name"
      mv "$target_item" "$BACKUP_DIR/$backup_name"
    fi
  done

  cd "$SCRIPT_DIR"
}

stow_zshrc() {
   cd "$SCRIPT_DIR"
   stow --restow --target="$HOME" --dir="$PWD" zshrc
}

main() {
  install_zsh
  setup_zsh
  backup_conflicts
  stow_zshrc
}

main
