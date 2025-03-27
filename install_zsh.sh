#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_zsh() {
  sudo apt-get update
  sudo apt-get install -y zsh wget git stow
}

setup_zsh() {
  env RUNZSH=no KEEP_ZSHRC=yes CHSH=no sh -c "$(wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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


stow_zshrc() {
   cd "$SCRIPT_DIR"
   stow --restow --target="$HOME" --dir="$PWD" zshrc
}

main() {
  stow_zshrc
  install_zsh
  setup_zsh
}

main
