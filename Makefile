SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --silent
MAKEFLAGS += -j$(shell nproc)
.DEFAULT_GOAL := config

.PHONY: config
config:
	# sudo dnf install stow -y
	echo 'TASK: use stow to create symlinks in XDG config dir'
	mkdir -p -v $(HOME)/.config/{npm,nvim,git,kitty}
	#stow -v  --target=$(HOME)/.config/nvim nvim
	stow -v  --target=$(HOME)/.config/nvim nvim
	stow -v  --target=$(HOME)/.config/git git
	#stow -v  --target=$(HOME)/.config/stylua stylua
	#stow -v  --target=$(HOME)/.config/wezterm wezterm
	stow -v  --target=$(HOME)/.config/kitty kitty
	#stow -v  --target=$(HOME)/.config/yamllint yamllint
	#stow -v  --target=$(HOME)/.config/tree-sitter tree-sitter
	#stow -v  --target=$(HOME)/.config/erlang_ls erlang_ls

.PHONY: clean
clean:
	echo 'TASK : use stow to remove symlinks'
	rm -rfv ~/.config/neovim
	rm -rfv ~/.local/state/neovim
	rm -rfv ~/.local/share/neovim
	stow -D -v -t ~/.config/neovim neovim
	


.PHONY: bash
bash: 
	echo 'TASK: bring bash under git control'
	cd bash
	stow -v --target=$(HOME) .
	cd ../

lazy:
	nvim --headless "+Lazy! sync" +qa


fonts:
	mkdir -p ~/.local/share/fonts/BlexMono
	#fc-cache -f -v
	fc-list

