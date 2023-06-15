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
	echo 'TASK: use stow to create symlinks in XDG config dir'
	stow -v --target=$(HOME) bash
	mkdir -p -v $(HOME)/.config/{npm,nvim,neovim,git,stylua,wezterm,kitty,yamllint,tree-sitter,erlang_ls}
	stow -v  --target=$(HOME)/.config/npm npm
	stow -v  --target=$(HOME)/.config/nvim nvim
	stow -v  --target=$(HOME)/.config/neovim neovim
	stow -v  --target=$(HOME)/.config/git git
	stow -v  --target=$(HOME)/.config/stylua stylua
	stow -v  --target=$(HOME)/.config/wezterm wezterm
	stow -v  --target=$(HOME)/.config/kitty kitty
	stow -v  --target=$(HOME)/.config/yamllint yamllint
	stow -v  --target=$(HOME)/.config/tree-sitter tree-sitter
	stow -v  --target=$(HOME)/.config/erlang_ls erlang_ls

bash: 
	if ! [ -L ~/.bashrc ] 
	then
	rm -fv ~/.bashrc
	ln -s .bashrc ~/
	fi
	mkdir -p ~/.bashrc.d
	stow -v  --dotfiles -t ~/ .bashrc.d

lazy:
	git clone https://github.com/LazyVim/starter nvim
	rm -rf nvim/.git

.PHONY: clean
clean:
	echo 'TASK : use stow to remove symlinks'
	# rm -rf ~/.config/nvim
	rm -rf ~/.local/state/nvim
	rm -rf ~/.local/share/nvim
	stow -D -v -t ~/.config/nvim nvim

