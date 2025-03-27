#!/usr/bin/env bash

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_dependencies() {
  sudo apt install libevent-dev ncurses-dev build-essential bison pkg-config automake stow
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
}

install_tmux() {
  git clone https://github.com/tmux/tmux.git $SCRIPT_DIR/tmux_repo
  cd tmux_repo
  sh autogen.sh
  ./configure
  make && sudo make install
}

stow_tmux() {
  cd "$SCRIPT_DIR"
  stow --restow --target="$HOME" --dir="$PWD" tmux
}

main() {
  install_dependencies
  install_tmux
  stow_tmux
}

main
