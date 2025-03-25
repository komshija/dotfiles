#!/bin/bash

install_zsh()
{
	sudo apt update
	sudo apt install -y stow zsh fzf
}

setup_zsh()
{
	sudo chsh -s $(which zsh)
	sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
}


install_zsh
setup_zsh
stow zshrc -t ~
