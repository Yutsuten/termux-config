.PHONY: fish git helix less lftp nnn termux

bold := $(shell tput bold)
reset := $(shell tput sgr0)
linux_config := ~/projects/linux-config

all: fish git helix less lftp nnn termux

fish:
	@echo '${bold}>> Fish settings <<${reset}'
	mkdir -p ~/.config/fish/functions
	rm -f ~/.config/fish/config.fish
	rm -f ~/.config/fish/functions/*.fish
	ln -srf fish/config.fish ~/.config/fish/config.fish
	ln -srf fish/functions/*.fish ~/.config/fish/functions/
	ln -srf ${linux_config}/tools/fish/functions/passgen.fish ~/.config/fish/functions/passgen.fish
	cp -p ${linux_config}/tools/fish/functions/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish
	sed -i -e 's/(prompt_login)/(set -q SSH_TTY \&\& prompt_login)/g' -e 's/ --dir-length=0//g' ~/.config/fish/functions/fish_prompt.fish

git:
	echo '${bold}>> Git settings <<${reset}'
	git config --global core.excludesfile ~/.config/gitignore
	git config --global core.pager 'less -+XF -S'
	git config --global pager.branch false
	git config --global core.editor 'hx'
	git config --global commit.gpgsign true
	ln -srf ${linux_config}/tools/git/gitignore ~/.config/gitignore

helix:
	echo '${bold}>> Helix settings <<${reset}'
	mkdir -p ~/.config/helix
	ln -srf ${linux_config}/tools/helix/config.toml ~/.config/helix/config.toml
	sed -i -e 's/onedark_modified/onedark/g' -e 's/file-name/file-base-name/g' ~/.config/helix/config.toml

less:
	@echo '${bold}>> Less settings <<${reset}'
	mkdir -p ~/.config/less
	ln -srf ${linux_config}/tools/less/lessopen.fish ~/.config/less/lessopen.fish
	ln -srf ${linux_config}/tools/less/lessclose.fish ~/.config/less/lessclose.fish
	chmod u+x ~/.config/less/*.fish

lftp:
	@echo '${bold}>> LFTP settings <<${reset}'
	mkdir -p ~/.config/lftp
	ln -srf ${linux_config}/tools/lftp/lftp.rc ~/.config/lftp/lftp.rc

nnn:
	@echo '${bold}>> Nnn plugins <<${reset}'
	rm -rf ~/.config/nnn/plugins
	mkdir -p ~/.config/nnn/plugins ~/.local/share/nnn
	ln -srf nnn/* ~/.config/nnn/plugins/
	ln -srf ${linux_config}/tools/nnn/plugins/.utils ~/.config/nnn/plugins/.utils
	ln -srf ${linux_config}/tools/nnn/plugins/archive ~/.config/nnn/plugins/archive
	ln -srf ${linux_config}/tools/nnn/plugins/find ~/.config/nnn/plugins/find
	ln -srf ${linux_config}/tools/nnn/plugins/gpg ~/.config/nnn/plugins/gpg
	ln -srf ${linux_config}/tools/nnn/plugins/tts ~/.config/nnn/plugins/tts
	sed -i '1c\#!/data/data/com.termux/files/usr/bin/env fish' ~/.config/nnn/plugins/*
	sed -i 's/mpv .*/termux-media-player play $$output_file > \/dev\/null/g' ~/.config/nnn/plugins/tts
	find ~/.config/nnn/plugins -xtype l -delete

termux:
	@echo '${bold}>> Termux settings <<${reset}'
	mkdir -p ~/bin ~/.local/bin
	ln -srf termux/colors.properties ~/.termux/colors.properties
	ln -srf termux/termux.properties ~/.termux/termux.properties
	ln -srf termux/share ~/bin/termux-file-editor
	ln -srf termux/menu ~/bin/menu
	find ~/bin -xtype l -delete
	cp -p ${linux_config}/desktop/bin/fpass ~/.local/bin/fpass
	sed -i '1c\#!/data/data/com.termux/files/usr/bin/env fish' ~/.local/bin/fpass
	cp -p ${linux_config}/desktop/bin/edit ~/.local/bin/edit
	sed -i '1c\#!/data/data/com.termux/files/usr/bin/env fish' ~/.local/bin/edit
	chmod u+x ~/.local/bin/*
	find ~/.local/bin -xtype l -delete
	test -s ~/.termux/Source-Code-Pro.ttf || wget -nv -NP ~/.termux 'https://raw.githubusercontent.com/termux/termux-styling/master/app/src/main/assets/fonts/Source-Code-Pro.ttf'
	termux-reload-settings
