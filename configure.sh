#!/bin/bash


#if [ ! -d $HOME/.cargo/bin ]; then
#	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
#fi


# Docker

if ! dpkg -s "docker-ce" >/dev/null 2>&1; then

	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

	echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  buster stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

	sudo apt-get update
	sudo apt-get install docker-ce docker-ce-cli containerd.io
fi 

# Chrome

if ! dpkg -s "google-chrome-stable" >/dev/null 2>&1; then
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo apt install ./google-chrome-stable_current_amd64.deb	
fi

# Vivaldi

if ! dpkg -s "vivaldi" >/dev/null 2>&1; then
	wget https://repo.vivaldi.com/archive/deb/dists/stable/main/binary-amd64/Packages
	ver=$(tac Packages| grep -m1 Version | cut -d " " -f2)
	wget https://repo.vivaldi.com/archive/deb/pool/main/vivaldi-stable_"$ver"_amd64.deb
	rm Packages
	sudo apt install ./vivaldi-stable_"$ver"_amd64.deb
	rm vivaldi-stable_"$ver"_amd64.deb
fi

# FZF

if ! -d ~/.fzf ;  then
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
fi

# ZSH

if ! -d "${ZDOTDIR:-$HOME}/.zprezto" ; then
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi


sudo apt install apt-listbugs apt-listchanges

dconf load /org/cinnamon/ conf/cinnamon.settings

sudo ln -s /var/lib/snapd/desktop/applications /usr/share/applications/snapd
