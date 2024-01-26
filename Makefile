.PHONY: fish git less nvim termux

bold := $(shell tput bold)
reset := $(shell tput sgr0)
linux_config := https://raw.githubusercontent.com/Yutsuten/linux-config/main

all: fish git less nvim termux

fish:
	@echo '${bold}>> Fish settings <<${reset}'
	rm -f ~/.config/fish/config.fish
	rm -f ~/.config/fish/functions/*.fish
	ln -srf fish/config.fish ~/.config/fish/config.fish
	ln -srf fish/functions/nnn.fish ~/.config/fish/functions/nnn.fish
	curl -Lso ~/.config/fish/functions/l1.fish "${linux_config}/tools/fish/functions/l1.fish"
	curl -Lso ~/.config/fish/functions/ll.fish "${linux_config}/tools/fish/functions/ll.fish"
	curl -Lso ~/.config/fish/functions/lo.fish "${linux_config}/tools/fish/functions/lo.fish"
	curl -Lso ~/.config/fish/functions/ls.fish "${linux_config}/tools/fish/functions/ls.fish"
	curl -Lso ~/.config/fish/functions/passgen.fish "${linux_config}/tools/fish/functions/passgen.fish"
	curl -Ls "${linux_config}/tools/fish/functions/fish_prompt.fish" | sed 's/(prompt_login)/(set -q SSH_TTY \&\& prompt_login)/g' > ~/.config/fish/functions/fish_prompt.fish
	curl -Ls "${linux_config}/tools/fish/functions/tts.fish" | sed 's/mpv --really-quiet \$$filename/termux-media-player play $$filename > \/dev\/null/g' > ~/.config/fish/functions/tts.fish

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

nvim:
	@echo '${bold}>> Neovim settings <<${reset}'
	rm -f ~/.config/nvim/init.vim ~/.config/nvim/*
	rm -rf ~/.local/share/nvim/site/*
	mkdir -p ~/.config/nvim ~/.local/share/nvim/site/pack/all ~/.local/share/nvim/site/plugin ~/.local/share/nvim/site/ftplugin ~/.local/share/nvim/site/doc
	ln -srnf nvim/pack/start ~/.local/share/nvim/site/pack/all/start
	ln -srnf nvim/pack/opt ~/.local/share/nvim/site/pack/all/opt
	curl -Lso ~/.config/nvim/init.vim "${linux_config}/tools/nvim/init.vim"
	curl -Lso nvim/pack/start/colorschemes/colors/onehalfdark.vim "${linux_config}/tools/nvim/pack/start/colorschemes/colors/onehalfdark.vim"
	curl -Lso ~/.local/share/nvim/site/plugin/colorscheme.vim "${linux_config}/tools/nvim/plugin/colorscheme.vim"
	curl -Lso ~/.local/share/nvim/site/plugin/gitsigns.lua "${linux_config}/tools/nvim/plugin/gitsigns.lua"
	curl -Lso ~/.local/share/nvim/site/plugin/gpg.vim "${linux_config}/tools/nvim/plugin/gpg.vim"
	curl -Lso ~/.local/share/nvim/site/plugin/statusline.vim "${linux_config}/tools/nvim/plugin/statusline.vim"
	curl -Lso ~/.local/share/nvim/site/plugin/tabline.vim "${linux_config}/tools/nvim/plugin/tabline.vim"
	curl -Lso ~/.local/share/nvim/site/plugin/vue.vim "${linux_config}/tools/nvim/plugin/vue.vim"
	curl -Lso ~/.local/share/nvim/site/ftplugin/fish.vim "${linux_config}/tools/nvim/ftplugin/fish.vim"
	curl -Lso ~/.local/share/nvim/site/ftplugin/python.vim "${linux_config}/tools/nvim/ftplugin/python.vim"
	curl -Lso ~/.local/share/nvim/site/doc/custom.txt "${linux_config}/tools/nvim/doc/custom.txt"
	nvim --cmd ':helptags ALL | :q' --headless

termux:
	ln -srf termux/colors.properties ~/.termux/colors.properties
	termux-reload-settings
