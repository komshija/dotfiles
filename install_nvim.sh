#!/usr/bin/env bash

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_dependencies()
{
  sudo apt-get install ninja-build gettext cmake curl build-essential
}

install_nvim()
{
  git clone https://github.com/neovim/neovim $SCRIPT_DIR/neovim_repo
  cd $SCRIPT_DIR/neovim_repo
  git checkout stable
  make CMAKE_BUILD_TYPE=RelWithDebInfo 
  sudo make install
}

stow_nvim()
{
  cd "$SCRIPT_DIR"
  stow --restow --target="$HOME" --dir="$PWD" nvim
}


main()
{
  install_dependencies
  install_nvim
}
main
