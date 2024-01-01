.PHONY: fish git nvim nnn

bold := $(shell tput bold)
reset := $(shell tput sgr0)
linux_config := https://raw.githubusercontent.com/Yutsuten/linux-config/main

all: fish git nvim

fish:
	@echo '${bold}>> Fish settings <<${reset}'
	rm -f ~/.config/fish/config.fish
	rm -f ~/.config/fish/functions/*.fish
	ln -sf $(CURDIR)/fish/config.fish ~/.config/fish/config.fish
	ln -sf $(CURDIR)/fish/functions/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish
	ln -sf $(CURDIR)/fish/functions/nnn.fish ~/.config/fish/functions/nnn.fish
	curl -Lso ~/.config/fish/functions/ll.fish "${linux_config}/tools/fish/functions/ll.fish"
	curl -Lso ~/.config/fish/functions/lo.fish "${linux_config}/tools/fish/functions/lo.fish"
	curl -Lso ~/.config/fish/functions/ls.fish "${linux_config}/tools/fish/functions/ls.fish"
	curl -Lso ~/.config/fish/functions/passgen.fish "${linux_config}/tools/fish/functions/passgen.fish"
	curl -Ls "${linux_config}/tools/fish/functions/tts.fish" | sed 's/mpv --really-quiet/play-audio/g' > ~/.config/fish/functions/tts.fish

git:
	echo '${bold}>> Git settings <<${reset}'
	git config --global core.excludesfile ~/.config/gitignore
	git config --global core.pager 'less -+XF -S'
	git config --global pager.branch false
	git config --global core.editor 'nvim'
	git config --global commit.gpgsign true
	curl -Lso ~/.config/gitignore "${linux_config}/tools/git/gitignore"

nvim:
	@echo '${bold}>> Neovim settings <<${reset}'
	rm -f ~/.config/nvim/init.vim ~/.config/nvim/*
	rm -rf ~/.local/share/nvim/site/*
	mkdir -p ~/.config/nvim ~/.local/share/nvim/site/pack/all ~/.local/share/nvim/site/plugin ~/.local/share/nvim/site/ftplugin ~/.local/share/nvim/site/doc
	ln -snf $(CURDIR)/nvim/pack/start ~/.local/share/nvim/site/pack/all/start
	ln -snf $(CURDIR)/nvim/pack/opt ~/.local/share/nvim/site/pack/all/opt
	curl -Lso ~/.config/nvim/init.vim "${linux_config}/tools/neovim/init.vim"
	curl -Lso $(CURDIR)/nvim/pack/start/colorschemes/colors/onehalfdark.vim "${linux_config}/tools/neovim/pack/start/colorschemes/colors/onehalfdark.vim"
	curl -Lso ~/.local/share/nvim/site/plugin/colorscheme.vim "${linux_config}/tools/neovim/plugin/colorscheme.vim"
	curl -Lso ~/.local/share/nvim/site/ftplugin/fish.vim "${linux_config}/tools/neovim/ftplugin/fish.vim"
	curl -Lso ~/.local/share/nvim/site/ftplugin/python.vim "${linux_config}/tools/neovim/ftplugin/python.vim"
	curl -Lso ~/.local/share/nvim/site/doc/custom.txt "${linux_config}/tools/neovim/doc/custom.txt"
