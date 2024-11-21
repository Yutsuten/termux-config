.PHONY: fish git helix less lftp nnn termux

bold := $(shell tput bold)
reset := $(shell tput sgr0)
linux_config := https://raw.githubusercontent.com/Yutsuten/linux-config/main

all: fish git helix less lftp nnn termux

fish:
	@echo '${bold}>> Fish settings <<${reset}'
	rm -f ~/.config/fish/config.fish
	rm -f ~/.config/fish/functions/*.fish
	ln -srf fish/config.fish ~/.config/fish/config.fish
	ln -srf fish/functions/*.fish ~/.config/fish/functions/
	curl -Lso ~/.config/fish/functions/idict.fish "${linux_config}/tools/fish/functions/idict.fish"
	curl -Lso ~/.config/fish/functions/passgen.fish "${linux_config}/tools/fish/functions/passgen.fish"
	curl -Ls "${linux_config}/tools/fish/functions/fish_prompt.fish" | sed 's/(prompt_login)/(set -q SSH_TTY \&\& prompt_login)/g' > ~/.config/fish/functions/fish_prompt.fish
	curl -Ls "${linux_config}/tools/fish/functions/tts.fish" | sed 's/mpv --really-quiet --volume=100 \$$filename/termux-media-player play $$filename > \/dev\/null/g' > ~/.config/fish/functions/tts.fish

git:
	echo '${bold}>> Git settings <<${reset}'
	git config --global core.excludesfile ~/.config/gitignore
	git config --global core.pager 'less -+XF -S'
	git config --global pager.branch false
	git config --global core.editor 'hx'
	git config --global commit.gpgsign true
	curl -Lso ~/.config/gitignore "${linux_config}/tools/git/gitignore"

helix:
	echo '${bold}>> Helix settings <<${reset}'
	mkdir -p ~/.config/helix
	curl -Ls "${linux_config}/tools/helix/config.toml" | sed -e 's/onedark_modified/onedark/g' -e 's/file-name/file-base-name/g' > ~/.config/helix/config.toml

less:
	@echo '${bold}>> Less settings <<${reset}'
	mkdir -p less
	curl -Lso less/lessopen.fish "${linux_config}/tools/less/lessopen.fish"
	curl -Lso less/lessclose.fish "${linux_config}/tools/less/lessclose.fish"
	chmod u+x less/*.fish

lftp:
	@echo '${bold}>> LFTP settings <<${reset}'
	curl -Lso ~/.config/lftp/rc "${linux_config}/tools/lftp/lftp.rc"

nnn:
	@echo '${bold}>> Nnn plugins <<${reset}'
	mkdir -p ~/.config/nnn
	rm -rf ~/.config/nnn/plugins
	ln -srf nnn ~/.config/nnn/plugins

termux:
	@echo '${bold}>> Termux settings <<${reset}'
	mkdir -p ~/bin ~/.local/bin
	ln -srf termux/colors.properties ~/.termux/colors.properties
	ln -srf termux/termux.properties ~/.termux/termux.properties
	ln -srf termux/share ~/bin/termux-file-editor
	ln -srf termux/todo ~/bin/todo
	curl -Ls "${linux_config}/desktop/bin/fpass" | sed '1c\#!/data/data/com.termux/files/usr/bin/env fish' > ~/.local/bin/fpass
	curl -Ls "${linux_config}/desktop/bin/edit" | sed '1c\#!/data/data/com.termux/files/usr/bin/env fish' > ~/.local/bin/edit
	chmod +x ~/.local/bin/fpass
	chmod +x ~/.local/bin/edit
	curl -Lso ~/.termux/font.ttf 'https://raw.githubusercontent.com/termux/termux-styling/master/app/src/main/assets/fonts/Source-Code-Pro.ttf'
	termux-reload-settings
