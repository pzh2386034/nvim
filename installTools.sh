#!/bin/bash
curl -L git.io/antigen > antigen.zsh
sudo apt install ripgrep zsh neovim fzf fd-find fzy 
sudo apt install universal-ctags
sudo apt install python-pip3 python3.12-venv
sudo apt install zoxide


curl -L git.io/antigen > ~/wks/antigen/antigen.zsh
ln -sf ~/.config/dotzshrc ~/.zshrc
chsh -s /usr/bin/zsh

### Macos

#curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

