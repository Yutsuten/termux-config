.PHONY: fish git less lftp nnn nvim termux

bold := $(shell tput bold)
reset := $(shell tput sgr0)
linux_config := https://raw.githubusercontent.com/Yutsuten/linux-config/main

all: fish git less lftp nnn nvim termux

fish:
	@echo '${bold}>> Fish settings <<${reset}'
	rm -f ~/.config/fish/config.fish
	rm -f ~/.config/fish/functions/*.fish
	ln -srf fish/config.fish ~/.config/fish/config.fish
	ln -srf fish/functions/*.fish ~/.config/fish/functions/
	curl -Lso ~/.config/fish/functions/gpgedit.fish "${linux_config}/tools/fish/functions/gpgedit.fish"
	curl -Lso ~/.config/fish/functions/idict.fish "${linux_config}/tools/fish/functions/idict.fish"
	curl -Lso ~/.config/fish/functions/passgen.fish "${linux_config}/tools/fish/functions/passgen.fish"
	curl -Ls "${linux_config}/tools/fish/functions/fish_prompt.fish" | sed 's/(prompt_login)/(set -q SSH_TTY \&\& prompt_login)/g' > ~/.config/fish/functions/fish_prompt.fish
	curl -Ls "${linux_config}/tools/fish/functions/tts.fish" | sed 's/mpv --really-quiet --volume=100 \$$filename/termux-media-player play $$filename > \/dev\/null/g' > ~/.config/fish/functions/tts.fish

git:
	echo '${bold}>> Git settings <<${reset}'
	git config --global core.excludesfile ~/.config/gitignore
	git config --global core.pager 'less -+XF -S'
	git config --global pager.branch false
	git config --global core.editor 'nvim'
	git config --global commit.gpgsign true
	curl -Lso ~/.config/gitignore "${linux_config}/tools/git/gitignore"

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

nvim:
	@echo '${bold}>> Neovim settings <<${reset}'
	rm -rf ~/.config/nvim ~/.local/share/nvim/site
	mkdir -p ~/.config/nvim/after/plugin ~/.config/nvim/after/ftplugin ~/.config/nvim/doc ~/.local/share/nvim/site/pack/all
	ln -srnf nvim/pack/start ~/.local/share/nvim/site/pack/all/start
	ln -srnf nvim/pack/opt ~/.local/share/nvim/site/pack/all/opt
	curl -Lso ~/.config/nvim/init.vim "${linux_config}/tools/nvim/init.vim"
	curl -Lso nvim/pack/start/colorschemes/colors/onehalfdark.vim "${linux_config}/tools/nvim/pack/start/colorschemes/colors/onehalfdark.vim"
	curl -Lso ~/.config/nvim/doc/custom.txt "${linux_config}/tools/nvim/doc/custom.txt"
	curl -Lso ~/.config/nvim/after/plugin/colorscheme.vim "${linux_config}/tools/nvim/plugin/colorscheme.vim"
	curl -Lso ~/.config/nvim/after/plugin/fzf.vim "${linux_config}/tools/nvim/plugin/fzf.vim"
	curl -Lso ~/.config/nvim/after/plugin/gitsigns.lua "${linux_config}/tools/nvim/plugin/gitsigns.lua"
	curl -Lso ~/.config/nvim/after/plugin/nnn.vim "${linux_config}/tools/nvim/plugin/nnn.vim"
	curl -Lso ~/.config/nvim/after/plugin/statusline.vim "${linux_config}/tools/nvim/plugin/statusline.vim"
	curl -Lso ~/.config/nvim/after/plugin/tabline.vim "${linux_config}/tools/nvim/plugin/tabline.vim"
	curl -Lso ~/.config/nvim/after/plugin/vue.vim "${linux_config}/tools/nvim/plugin/vue.vim"
	curl -Lso ~/.config/nvim/after/ftplugin/fish.vim "${linux_config}/tools/nvim/ftplugin/fish.vim"
	curl -Lso ~/.config/nvim/after/ftplugin/python.vim "${linux_config}/tools/nvim/ftplugin/python.vim"
	nvim --cmd ':helptags ALL | :q' --headless

termux:
	@echo '${bold}>> Termux settings <<${reset}'
	mkdir -p ~/bin
	ln -srf termux/colors.properties ~/.termux/colors.properties
	ln -srf termux/share ~/bin/termux-file-editor
	ln -srf termux/todo ~/bin/todo
	curl -Lso ~/.termux/font.ttf 'https://raw.githubusercontent.com/termux/termux-styling/master/app/src/main/assets/fonts/Source-Code-Pro.ttf'
	termux-reload-settings
