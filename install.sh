e#!/bin/bash -e

# Install Script based on Optixal's neovim-init.vim install script
# Use on Ubuntu 22.04 LTS

# Installs neovim and all necessary dependencies for Eymay's init.vim. Does not check if dependencies have already been installed. 
NEOVIM_VERSION=0.7.0

echo '[*] Preparing Neovim config directory ...'
mkdir -p ~/.config/nvim

echo '[*] Installing dependencies ...'
    sudo apt update
    sudo apt install \
        wget \
        curl \
        git \
        build-essential \
	-y

# Install neovim
echo "[*] Installing neovim $NEOVIM_VERSION ..."
wget "https://github.com/neovim/neovim/releases/download/v$NEOVIM_VERSION/nvim-linux64.tar.gz" -O /tmp/nvim-linux64.tar.gz
mkdir -p ~/.local/bin
tar xf /tmp/nvim-linux64.tar.gz -C ~/.local
ln -sf $(readlink -f ~/.local/nvim-linux64/bin/nvim) ~/.local/bin/nvim

sudo apt install \
	nodejs \
	fd-find \
	-y	
ln -s $(which fdfind) ~/.local/bin/fd

# Install vim-plug plugin manager
echo '[*] Installing vim-plug'
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Enter Neovim and install plugins with vim-plug's :PlugInstall using a temporary init.vim, which avoids warnings about missing colorschemes, functions, etc
echo -e '[*] Running :PlugInstall within nvim ...'
sed '/call plug#end/q' ../init.vim > ~/.config/nvim/init.vim
nvim -c 'PlugInstall' -c 'qa'

# Copy init.vim and lua scripts in current working directory to nvim's config location
echo '[*] Copying init.vim & lua/ -> ~/.config/nvim/'
cp -r ../init.vim ../lua/ ~/.config/nvim/
