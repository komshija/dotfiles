
setup_start()
{
	echo "#############"
	echo "Start of $1"
	echo "#############"
}

setup_end()
{
	echo "#############"
	echo "$1 is done"
	echo "#############"	 
}

######################################################################################

setup_packages()
{
	setup_start "Setup packages"

	sudo apt update
	sudo apt upgrade -y

	sudo apt install -y gnome-tweaks \
			 git \
			 chrome-gnome-shell \
			 g++ \
			 clang \
			 clang-format \
			 clang-tidy \
			 unzip \
			 tmux \
			 zsh \
			 gettext \
			 libslang2-dev \
			 autoconf \
			 autopoint

	setup_end "Setup packages"
}

######################################################################################

setup_directories() 
{
	setup_start "Setup directories"

	mkdir -p ~/source/

	setup_end "Setup directories"
}

######################################################################################

setup_git()
{
	setup_start "Setup git"
	
	git config --global user.email  "milan.r.radosavljevic@outlook.com"
	git config --global user.name "Milan Radosavljevic" 

	setup_end "Setup git"
}

######################################################################################

install_fonts()
{
mkdir -p ~/.fonts

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/0xProto.zip -P ~/.fonts
unzip ~/.fonts/0xProto.zip
}

######################################################################################
# Setup dock on GNOME

setup_gnome_dock()
{
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 30
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM' 
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
}

######################################################################################
# Kitty setup
install_kitty()
{
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
echo 'kitty.desktop' > ~/.config/xdg-terminals.list
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator ~/.local/bin/kitty 50
sudo update-alternatives --config /x-terminal-emulator
sudo update-alternatives --set x-terminal-emulator ~/.local/bin/kitty 
}

######################################################################################
# Zsh setup

setup_zsh()
{
sudo chsh -s $(which zsh)
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zsh-syntax-highlighting plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install zsh-autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install Fuzzy finder
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# Download theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
}

######################################################################################
# Tmux setup

setup_tmux_tpm()
{
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}






